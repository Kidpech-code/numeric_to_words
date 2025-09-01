/// Thai number-to-words utilities public API.
///
/// Re-exports common utilities organized by domain:
/// - Core number formatting ([thaiIntToWords], [thaiNumberToWords])
/// - Currency formatting ([thaiBahtText])
/// - Options for customization ([ThaiNumberOptions], [ThaiBahtTextOptions])
/// - Decimals and fractions ([thaiDecimal], [thaiFraction])
/// - Digit-by-digit reading ([thaiDigits])
/// - Thai numerals parsing ([thaiNumeralsToArabic], [arabicDigitsToThai], [parseThaiInteger])
/// - Roman numerals parsing and reading ([parseRoman], [romanToThaiWords])
library;

export 'src/core/options.dart';
export 'src/core/number_to_words.dart' show thaiIntToWords, thaiNumberToWords;
export 'src/currency/baht_text.dart' show thaiBahtText;
export 'src/quantity/decimals_fractions.dart' show thaiDecimal, thaiFraction;
export 'src/quantity/digits.dart' show thaiDigits;
export 'src/parse/thai_numerals.dart'
    show thaiNumeralsToArabic, arabicDigitsToThai, parseThaiInteger;
export 'src/parse/roman_numerals.dart' show parseRoman;
export 'src/quantity/roman_to_words.dart' show romanToThaiWords;
// Currency (multilingual)
export 'src/domain/currency.dart';
export 'src/infrastructure/currency_registry.dart';
export 'src/application/currency_format.dart';
