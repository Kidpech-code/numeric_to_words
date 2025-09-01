import '../core/number_to_words.dart' show thaiNumberToWords; // existing
import '../domain/currency.dart';

String _roundHalfUpToCentsString(num amount) {
  final negative = amount < 0;
  var value = amount.abs();
  final s = value.toStringAsFixed(3); // guard against 1.005 issues
  final parts = s.split('.');
  var cents = int.parse(parts[1]);
  var whole = int.parse(parts[0]);
  // parts[1] has 3 digits; implement half-up to 2 digits
  final hundred = cents ~/ 10; // first two digits
  final third = cents % 10;
  var minor = hundred + (third >= 5 ? 1 : 0);
  if (minor == 100) {
    whole += 1;
    minor = 0;
  }
  final res =
      '${negative ? '-' : ''}$whole.${minor.toString().padLeft(2, '0')}';
  return res;
}

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

/// Format a number into English currency words, with minor unit when needed.
String englishCurrencyText(num amount, CurrencyUnit currency) {
  final rounded = _roundHalfUpToCentsString(amount);
  final neg = rounded.startsWith('-');
  final parts = (neg ? rounded.substring(1) : rounded).split('.');
  final whole = BigInt.parse(parts[0]);
  final minor = int.parse(parts[1]);
  final wholeWords = _englishIntToWords(whole);
  final wholeUnit = whole == BigInt.one
      ? currency.englishSingular
      : currency.englishPlural;
  if (minor == 0) {
    final s = '$wholeWords $wholeUnit';
    return neg ? 'minus $s' : s;
  }
  final minorUnit = minor == 1
      ? (currency.englishMinorSingular ?? 'cent')
      : (currency.englishMinorPlural ?? 'cents');
  final minorWords = _englishIntToWords(BigInt.from(minor));
  final s = '$wholeWords $wholeUnit and $minorWords $minorUnit';
  return neg ? 'minus $s' : s;
}

/// Format a number into Thai currency words using existing Thai number-to-words.
String thaiCurrencyText(num amount, CurrencyUnit currency) {
  final rounded = _roundHalfUpToCentsString(amount);
  final neg = rounded.startsWith('-');
  final parts = (neg ? rounded.substring(1) : rounded).split('.');
  final whole = BigInt.parse(parts[0]);
  final minor = int.parse(parts[1]);
  final wholeWords = thaiNumberToWords(whole);
  if (minor == 0) {
    final sep = currency.code == 'THB' ? '' : ' ';
    final s = '$wholeWords$sep${currency.thaiName}';
    return neg ? 'ลบ$s' : s;
  }
  final minorWords = thaiNumberToWords(BigInt.from(minor));
  final minorName = currency.thaiMinorName ?? 'สตางค์';
  final sep = currency.code == 'THB' ? '' : ' ';
  final s = '$wholeWords$sep${currency.thaiName}$minorWords$minorName';
  return neg ? 'ลบ$s' : s;
}
