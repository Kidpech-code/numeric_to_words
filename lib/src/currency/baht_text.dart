import '../core/options.dart';
import '../core/number_to_words.dart';

/// Converts a numeric amount to Thai Baht text ("Thai Baht Text").
///
/// Rules:
/// - Rounds to 2 decimal places (สตางค์) using half-up rounding.
/// - Uses "...บาทถ้วน" when the satang part is zero.
/// - Supports negative amounts by prefixing with options.negativeWord.
String thaiBahtText(num amount, {ThaiBahtTextOptions options = const ThaiBahtTextOptions()}) {
  if (amount.isNaN) {
    throw ArgumentError('amount is NaN');
  }
  if (!amount.isFinite) {
    throw ArgumentError('amount is not finite');
  }

  final isNegative = amount < 0;
  final absAmount = amount.abs();

  final _Rounded r = _roundHalfUpToCents(absAmount);
  final baht = r.baht;
  final satang = r.satang;

  final bahtWords = thaiNumberToWords(baht, options: options);
  final buffer = StringBuffer();
  if (isNegative) buffer.write(options.negativeWord);
  buffer.write(bahtWords);
  buffer.write(options.majorUnit);
  if (satang == 0) {
    buffer.write(options.integerSuffix);
  } else {
    buffer.write(thaiIntToWords(satang, options: options));
    buffer.write(options.minorUnit);
  }
  return buffer.toString();
}

/// Result of rounding a number to baht and satang using half-up to 2 decimals.
class _Rounded {
  final BigInt baht;
  final int satang;
  _Rounded(this.baht, this.satang);
}

_Rounded _roundHalfUpToCents(num amount) {
  final s = amount.toString();
  final intPartStr = s.contains('.') ? s.split('.')[0] : s;
  final fracStr = s.contains('.') ? s.split('.')[1] : '';

  final baht = BigInt.parse(intPartStr);
  final f = fracStr.padRight(3, '0'); // need at least 3 digits for rounding
  final c2 = f.substring(0, 2);
  final c3 = f.substring(2, 3);
  var satang = int.parse(c2);
  final rDigit = int.parse(c3);
  if (rDigit >= 5) {
    satang += 1;
  }
  var bahtAdj = baht;
  if (satang >= 100) {
    satang -= 100;
    bahtAdj += BigInt.one;
  }
  return _Rounded(bahtAdj, satang);
}
