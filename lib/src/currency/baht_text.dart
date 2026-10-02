import '../core/options.dart';
import '../core/number_to_words.dart';
import 'rounding.dart';

/// Converts a numeric amount to Thai Baht text ("Thai Baht Text").
///
/// Rules:
/// - Rounds to 2 decimal places (สตางค์) using half-up rounding.
/// - Uses "...บาทถ้วน" when the satang part is zero.
/// - Supports negative amounts by prefixing with options.negativeWord.
/// - Accepts [num], [BigInt], or exact decimal [String] input (e.g. `"1,234.56"`).
String thaiBahtText(
  Object amount, {
  ThaiBahtTextOptions options = const ThaiBahtTextOptions(),
}) {
  final rounded = roundMoney(amount);
  final baht = rounded.units ~/ BigInt.from(100);
  final satang = (rounded.units % BigInt.from(100)).toInt();

  final bahtWords = thaiNumberToWords(baht, options: options);
  final buffer = StringBuffer();
  if (rounded.negative) buffer.write(options.negativeWord);
  buffer.write(bahtWords);
  buffer.write(options.majorUnit);
  if (satang == 0) {
    if (options.useIntegerSuffix) buffer.write(options.integerSuffix);
  } else {
    buffer.write(thaiIntToWords(satang, options: options));
    buffer.write(options.minorUnit);
  }
  return buffer.toString();
}
