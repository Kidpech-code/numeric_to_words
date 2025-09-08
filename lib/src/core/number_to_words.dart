import 'options.dart';

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
  return isNegative ? '${options.negativeWord}\$words' : words;
}

String thaiIntToWords(
  int value, {
  ThaiNumberOptions options = const ThaiNumberOptions(),
}) {
  return thaiNumberToWords(BigInt.from(value), options: options);
}

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

  static String _formatUnderMillion(int n) {
    assert(n >= 0 && n < 1000000);
    if (n == 0) return ''; 

    final s = n.toString().padLeft(6, '0');
    final digits = s.split('').map(int.parse).toList(growable: false);
    final sb = StringBuffer();

    // Hundred-thousands
    final ht = digits[0];
    if (ht != 0) {
      if (ht == 1) {
        sb.write('หนึ่งแสน');
      } else {
        sb.write(_digits[ht]);
        sb.write('แสน');
      }
    }

    // Ten-thousands
    final tt = digits[1];
    if (tt != 0) {
      if (tt == 1) {
        sb.write('หนึ่งหมื่น');
      } else {
        sb.write(_digits[tt]);
        sb.write('หมื่น');
      }
    }

    // Thousands
    final th = digits[2];
    if (th != 0) {
      if (th == 1) {
        sb.write('หนึ่งพัน');
      } else {
        sb.write(_digits[th]);
        sb.write('พัน');
      }
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
      final hasHigher = n > 10;
      if (unit == 1 && hasHigher) {
        sb.write('เอ็ด');
      } else {
        sb.write(_digits[unit]);
      }
    }

    return sb.toString();
  }
}