import '../core/number_to_words.dart';
import '../core/options.dart';
import '../parse/roman_numerals.dart';

/// Converts a Roman numeral string directly to Thai words.
/// Example: 'IV' -> 'สี่', 'XV' -> 'สิบห้า'.
String romanToThaiWords(
  String roman, {
  ThaiNumberOptions options = const ThaiNumberOptions(),
}) {
  final value = parseRoman(roman);
  return thaiNumberToWords(value, options: options);
}
