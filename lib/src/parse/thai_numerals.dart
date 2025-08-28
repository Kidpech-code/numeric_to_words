/// Utilities for Thai numeral characters (๐-๙).

const _thaiToArabicMap = {'๐': '0', '๑': '1', '๒': '2', '๓': '3', '๔': '4', '๕': '5', '๖': '6', '๗': '7', '๘': '8', '๙': '9'};

const _arabicToThaiMap = {'0': '๐', '1': '๑', '2': '๒', '3': '๓', '4': '๔', '5': '๕', '6': '๖', '7': '๗', '8': '๘', '9': '๙'};

/// Convert any Thai numerals in [input] to Arabic digits. Other chars unchanged.
String thaiNumeralsToArabic(String input) {
  final buffer = StringBuffer();
  for (final ch in input.split('')) {
    buffer.write(_thaiToArabicMap[ch] ?? ch);
  }
  return buffer.toString();
}

/// Convert any Arabic digits in [input] to Thai numerals. Other chars unchanged.
String arabicDigitsToThai(String input) {
  final buffer = StringBuffer();
  for (final ch in input.split('')) {
    buffer.write(_arabicToThaiMap[ch] ?? ch);
  }
  return buffer.toString();
}

/// Parse an integer string consisting of Thai numerals (optional leading sign).
BigInt parseThaiInteger(String input) {
  final s = thaiNumeralsToArabic(input.trim());
  return BigInt.parse(s);
}
