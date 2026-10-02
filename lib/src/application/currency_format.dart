import '../core/number_to_words.dart' show thaiNumberToWords; // existing
import '../domain/currency.dart';
import '../currency/rounding.dart';

/// English integer to words (minimal, up to trillions). For production, consider a full i18n lib.
String _englishIntToWords(BigInt n) {
  if (n == BigInt.zero) return 'zero';
  final negative = n.isNegative;
  var x = n.abs();
  const units = [
    '',
    'one',
    'two',
    'three',
    'four',
    'five',
    'six',
    'seven',
    'eight',
    'nine',
    'ten',
    'eleven',
    'twelve',
    'thirteen',
    'fourteen',
    'fifteen',
    'sixteen',
    'seventeen',
    'eighteen',
    'nineteen',
  ];
  const tens = [
    '',
    '',
    'twenty',
    'thirty',
    'forty',
    'fifty',
    'sixty',
    'seventy',
    'eighty',
    'ninety',
  ];
  final scales = <BigInt>[
    BigInt.parse('1000000000000000000'), // quintillion
    BigInt.parse('1000000000000000'), // quadrillion
    BigInt.parse('1000000000000'), // trillion
    BigInt.parse('1000000000'), // billion
    BigInt.parse('1000000'), // million
    BigInt.parse('1000'), // thousand
    BigInt.one,
  ];
  const scaleNames = <String>[
    'quintillion',
    'quadrillion',
    'trillion',
    'billion',
    'million',
    'thousand',
    '',
  ];

  String chunkToWords(int v) {
    if (v == 0) return '';
    final b = StringBuffer();
    final h = v ~/ 100;
    final t = v % 100;
    if (h > 0) {
      b.write('${units[h]} hundred');
      if (t > 0) b.write(' ');
    }
    if (t > 0) {
      if (t < 20) {
        b.write(units[t]);
      } else {
        final ten = t ~/ 10;
        final u = t % 10;
        b.write(tens[ten]);
        if (u > 0) b.write('-${units[u]}');
      }
    }
    return b.toString();
  }

  final sb = StringBuffer();
  for (var i = 0; i < scales.length; i++) {
    final scale = scales[i];
    if (x >= scale) {
      final q = x ~/ scale;
      x %= scale;
      final part = q.toInt();
      final words = chunkToWords(part);
      if (words.isNotEmpty) {
        if (sb.isNotEmpty) sb.write(' ');
        sb
          ..write(words)
          ..write(scaleNames[i].isNotEmpty ? ' ${scaleNames[i]}' : '');
      }
    }
  }
  return negative ? 'minus ${sb.toString()}' : sb.toString();
}

/// Formats [amount] as English currency words, with a minor unit when needed.
///
/// Accepts [num], [BigInt], or an exact decimal [String]. Rounds half-up to
/// [CurrencyUnit.minorUnitDigits] decimal places.
/// Whole amounts must be below 10^21 for the built-in English word list.
String englishCurrencyText(Object amount, CurrencyUnit currency) {
  final rounded = roundMoney(amount, fractionDigits: currency.minorUnitDigits);
  final neg = rounded.negative;
  final scale = BigInt.from(10).pow(currency.minorUnitDigits);
  final whole = rounded.units ~/ scale;
  final minor = rounded.units % scale;
  final wholeWords = _englishIntToWords(whole);
  final wholeUnit = whole == BigInt.one
      ? currency.englishSingular
      : currency.englishPlural;
  if (minor == BigInt.zero) {
    final s = '$wholeWords $wholeUnit';
    return neg ? 'minus $s' : s;
  }
  final minorUnit = minor == BigInt.one
      ? (currency.englishMinorSingular ?? 'cent')
      : (currency.englishMinorPlural ?? 'cents');
  final minorWords = _englishIntToWords(minor);
  final s = '$wholeWords $wholeUnit and $minorWords $minorUnit';
  return neg ? 'minus $s' : s;
}

/// Formats [amount] as Thai currency words, with a minor unit when needed.
///
/// Accepts [num], [BigInt], or an exact decimal [String]. Rounds half-up to
/// [CurrencyUnit.minorUnitDigits] decimal places.
String thaiCurrencyText(Object amount, CurrencyUnit currency) {
  final rounded = roundMoney(amount, fractionDigits: currency.minorUnitDigits);
  final neg = rounded.negative;
  final scale = BigInt.from(10).pow(currency.minorUnitDigits);
  final whole = rounded.units ~/ scale;
  final minor = rounded.units % scale;
  final wholeWords = thaiNumberToWords(whole);
  if (minor == BigInt.zero) {
    final sep = currency.code == 'THB' ? '' : ' ';
    final s = '$wholeWords$sep${currency.thaiName}';
    return neg ? 'ลบ$s' : s;
  }
  final minorWords = thaiNumberToWords(minor);
  final minorName = currency.thaiMinorName ?? 'สตางค์';
  final sep = currency.code == 'THB' ? '' : ' ';
  final s = '$wholeWords$sep${currency.thaiName}$minorWords$minorName';
  return neg ? 'ลบ$s' : s;
}
