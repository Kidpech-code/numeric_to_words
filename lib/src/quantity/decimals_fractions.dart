import '../core/options.dart';
import '../core/number_to_words.dart';

/// Reads a decimal number in Thai, pronouncing the decimal point and each digit after it.
/// Examples:
/// - 0.5 -> ศูนย์จุดห้า
/// - with fixedFractionDigits: 2, 0.5 -> ศูนย์จุดห้าศูนย์
/// - 1.0 -> หนึ่ง (by default), unless [options.omitPointWhenFractionZero] is false.
String thaiDecimal(
  num value, {
  ThaiDecimalOptions options = const ThaiDecimalOptions(),
}) {
  if (value.isNaN) throw ArgumentError('value is NaN');
  if (!value.isFinite) throw ArgumentError('value is not finite');

  final isNegative = value < 0;
  var s = value.abs().toString();

  // Normalize with fixed fraction digits if requested.
  if (options.fixedFractionDigits != null) {
    s = value.abs().toStringAsFixed(options.fixedFractionDigits!);
  }

  final parts = s.split('.');
  final intPart = BigInt.parse(parts[0]);
  final fracPart = parts.length > 1 ? parts[1] : '';

  final intWords = thaiNumberToWords(intPart, options: options);

  // If fraction zeros and omit flag => just integer words.
  final isFractionAllZeros =
      fracPart.isEmpty || RegExp(r'^0+$').hasMatch(fracPart);
  if (isFractionAllZeros && options.omitPointWhenFractionZero) {
    return isNegative ? '${options.negativeWord}$intWords' : intWords;
  }

  final digitMap = [
    '',
    'หนึ่ง',
    'สอง',
    'สาม',
    'สี่',
    'ห้า',
    'หก',
    'เจ็ด',
    'แปด',
    'เก้า',
  ];
  final fracWords = fracPart.split('').map((ch) {
    final d = int.parse(ch);
    return digitMap[d].isEmpty ? options.zeroWord : digitMap[d];
  }).join();

  final result = StringBuffer()
    ..write(intWords)
    ..write(options.decimalPointWord)
    ..write(fracWords);
  return isNegative
      ? '${options.negativeWord}${result.toString()}'
      : result.toString();
}

/// Reads a fraction in Thai using the pattern "X ส่วน Y".
/// Examples:
/// - 1/2 -> หนึ่งส่วนสอง
/// - 3/4 -> สามส่วนสี่
/// - negative numerator or denominator prefixes with negativeWord.
String thaiFraction(
  BigInt numerator,
  BigInt denominator, {
  ThaiNumberOptions options = const ThaiNumberOptions(),
}) {
  if (denominator == BigInt.zero) {
    throw ArgumentError('denominator must not be zero');
  }

  // Normalize sign: keep sign on the whole, values non-negative for word conversion.
  final signNegative = (numerator.isNegative) ^ (denominator.isNegative);
  final numAbs = numerator.abs();
  final denAbs = denominator.abs();

  final numWords = thaiNumberToWords(numAbs, options: options);
  final denWords = thaiNumberToWords(denAbs, options: options);

  final phrase = StringBuffer()
    ..write(numWords)
    ..write('ส่วน')
    ..write(denWords);
  return signNegative
      ? '${options.negativeWord}${phrase.toString()}'
      : phrase.toString();
}
