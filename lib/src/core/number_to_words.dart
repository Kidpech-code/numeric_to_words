import 'options.dart';

/// Converts an integer to Thai words.
///
/// Contract:
/// - Input: any [BigInt] (positive, zero, or negative).
/// - Output: Thai words without spaces (e.g. 121 -> "หนึ่งร้อยยี่สิบเอ็ด").
/// - Errors: none for valid [BigInt] input.
///
/// Notes:
/// - Supports arbitrarily large integers via [BigInt].
/// - Handles negative numbers (prefix with [ThaiNumberOptions.negativeWord]).
/// - Returns [ThaiNumberOptions.zeroWord] when value is zero.
String thaiNumberToWords(
  BigInt value, {
  ThaiNumberOptions options = const ThaiNumberOptions(),
}) {
  final isNegative = value.isNegative;
  final absVal = (isNegative ? -value : value);

  if (absVal == BigInt.zero) {
    return options.zeroWord;
  }

  final words = _ThaiNumberFormatter._formatBigInt(absVal);
  return isNegative ? '${options.negativeWord}$words' : words;
}

/// Convenience overload for `int`.
String thaiIntToWords(
  int value, {
  ThaiNumberOptions options = const ThaiNumberOptions(),
}) {
  return thaiNumberToWords(BigInt.from(value), options: options);
}

/// Internal Thai number formatter implementation.
class _ThaiNumberFormatter {
  static const List<String> _digits = [
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

  /// Format arbitrary non-negative integer to Thai words.
  static String _formatBigInt(BigInt n) {
    assert(n >= BigInt.zero);

    // Split into base-1,000,000 groups (ล้าน).
    final million = BigInt.from(1000000);
    final groups = <int>[]; // each 0..999,999
    var x = n;
    while (x > BigInt.zero) {
      final q = x ~/ million;
      final r = x % million;
      groups.add(r.toInt());
      x = q;
    }
    // Highest group last in list; reverse iterate
    final sb = StringBuffer();
    for (var i = groups.length - 1; i >= 0; i--) {
      final g = groups[i];
      if (g != 0) {
        sb.write(_formatUnderMillion(g));
      }
      if (i > 0) {
        sb.write('ล้าน');
      }
    }
    final result = sb.toString();
    return result.isEmpty ? 'ศูนย์' : result;
  }

  /// Format a number in range 1..999,999 to Thai words.
  static String _formatUnderMillion(int n) {
    assert(n >= 0 && n < 1000000);
    if (n == 0) return '';

    final s = n.toString().padLeft(6, '0');
    final digits = s.split('').map(int.parse).toList(growable: false);
    final sb = StringBuffer();

    // Hundred-thousands
    final ht = digits[0];
    if (ht != 0) {
      sb.write(_digits[ht]);
      sb.write('แสน');
    }

    // Ten-thousands and thousands combined as two-digit phrase + 'พัน'
    final tt = digits[1];
    final th = digits[2];
    final ttTh = tt * 10 + th;
    if (ttTh != 0) {
      sb.write(_formatTwoDigitsForHigherDenominations(ttTh));
      sb.write('พัน');
    }

    // Hundreds
    final h = digits[3];
    if (h != 0) {
      sb.write(_digits[h]);
      sb.write('ร้อย');
    }

    // Tens
    final t = digits[4];
    if (t != 0) {
      if (t == 1) {
        sb.write('สิบ');
      } else if (t == 2) {
        sb.write('ยี่สิบ');
      } else {
        sb.write(_digits[t]);
        sb.write('สิบ');
      }
    }

    // Units place
    final unit = digits[5];
    if (unit != 0) {
      final hasHigher =
          n > 10; // any higher place implies n > 10 for Thai "เอ็ด"
      if (unit == 1 && hasHigher) {
        sb.write('เอ็ด');
      } else {
        sb.write(_digits[unit]);
      }
    }

    return sb.toString();
  }

  /// Format 1..99 as Thai words for higher denominations (พัน, แสน, etc.).
  /// Never uses 'ยี่' - always uses 'สอง' for 20-29 range.
  static String _formatTwoDigitsForHigherDenominations(int n) {
    assert(n >= 0 && n < 100);
    if (n == 0) return '';
    if (n < 10) return _digits[n];
    final tens = n ~/ 10;
    final ones = n % 10;
    final sb = StringBuffer();
    if (tens == 1) {
      sb.write('สิบ');
    } else {
      // Always use 'สอง' instead of 'ยี่' for higher denominations
      sb.write(_digits[tens]);
      sb.write('สิบ');
    }
    if (ones != 0) {
      if (ones == 1) {
        sb.write('เอ็ด');
      } else {
        sb.write(_digits[ones]);
      }
    }
    return sb.toString();
  }
}
