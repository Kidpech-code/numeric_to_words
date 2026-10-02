/// Legacy entrypoint for Thai number-to-words utilities.
///
/// New code can import `package:thai_number_words/thai_number_words.dart`.
/// Both entrypoints export the same API: integer and decimal reading,
/// [thaiBahtText], [englishCurrencyText], [thaiCurrencyText], fractions,
/// individual digits, and Thai and Roman numeral utilities.
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
export 'src/domain/currency.dart';
export 'src/infrastructure/currency_registry.dart';
export 'src/application/currency_format.dart';
