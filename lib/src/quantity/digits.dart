import '../core/options.dart';
import '../parse/thai_numerals.dart';

/// Reads a number as individual Thai digits without composing into place-value words.
/// Example: 12345 -> "หนึ่งสองสามสี่ห้า".
/// Supports negative and optional decimal point word.
String thaiDigits(String numeric, {ThaiDigitsOptions options = const ThaiDigitsOptions()}) {
  if (numeric.isEmpty) {
    throw ArgumentError('numeric is empty');
  }
  // Trim spaces
  final raw = numeric.trim();
  var s = raw;
  var isNegative = false;
  if (s.startsWith('+')) s = s.substring(1);
  if (s.startsWith('-')) {
    isNegative = true;
    s = s.substring(1);
  }
  if (s.isEmpty) throw ArgumentError('numeric has no digits');

  // Normalize Thai numerals to Arabic digits for validation/reading
  s = thaiNumeralsToArabic(s);

  // Validate characters (digits and optional one dot)
  final dotCount = '.'.allMatches(s).length;
  if (dotCount > 1) throw ArgumentError('numeric contains more than one decimal point');
  if (!RegExp(r'^[0-9]+(\.[0-9]+)?$').hasMatch(s)) {
    throw ArgumentError('numeric contains invalid characters');
  }

  final digitMap = ['ศูนย์', 'หนึ่ง', 'สอง', 'สาม', 'สี่', 'ห้า', 'หก', 'เจ็ด', 'แปด', 'เก้า'];
  final out = <String>[];

  for (final ch in s.split('')) {
    if (ch == '.') {
      if (options.includeDecimalPoint) out.add(options.decimalPointWord);
      continue;
    }
    final d = int.parse(ch);
    out.add(digitMap[d]);
  }

  final joined = out.join(options.separator);
  return isNegative ? '${options.negativeWord}$joined' : joined;
}
