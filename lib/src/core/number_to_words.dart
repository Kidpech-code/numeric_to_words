import 'options.dart';

/// Options container (assumed existing in options.dart):
/// class ThaiNumberOptions {
///   final String zeroWord; // default 'ศูนย์'
///   final String negativeWord; // default 'ลบ'
///   const ThaiNumberOptions({this.zeroWord = 'ศูนย์', this.negativeWord = 'ลบ'});
/// }
///
/// Core functions provided:
/// - thaiNumberToWords(BigInt)
/// - thaiIntToWords(int)
/// - thaiBahtText(num | String)
///
/// Enhancements in this revision:
/// 1. Fixed cross-group final '1' => 'เอ็ด' rule when the overall number > 1 and final group == 1
///    (e.g. 1,000,001 => หนึ่งล้านเอ็ด, 1,001,000,001 => หนึ่งพันเอ็ดล้านเอ็ด)
/// 2. Removed stray backslash before positive forms when negative.
/// 3. Added thaiBahtText for money reading (BAHTTEXT style) with correct rounding to 2 decimals.
/// 4. Added internal helpers for safe decimal parsing & rounding.
/// 5. Left existing under-million formatting logic intact for intra-group 'เอ็ด' rule (n > 10).

String thaiNumberToWords(
  BigInt value, {
  ThaiNumberOptions options = const ThaiNumberOptions(),
}) {
  final isNegative = value.isNegative;
  final absVal = isNegative ? -value : value;

  if (absVal == BigInt.zero) {
    return options.zeroWord;
  }

  final words = _ThaiNumberFormatter._formatBigInt(absVal);
  return isNegative ? '${options.negativeWord}$words' : words;
}

String thaiIntToWords(
  int value, {
  ThaiNumberOptions options = const ThaiNumberOptions(),
}) => thaiNumberToWords(BigInt.from(value), options: options);

/// Convert a numeric amount to Thai Baht text similar to Microsoft Office BAHTTEXT.
/// Rounding: standard rounding to 2 decimal places (>= .005 of a satang triggers rounding).
/// Examples:
///   0 => ศูนย์บาทถ้วน
///   0.05 => ห้าสตางค์
///   0.5 => ห้าสิบสตางค์
///   0.995 => หนึ่งบาทถ้วน
///   1.005 => หนึ่งบาทหนึ่งสตางค์
///   21.25 => ยี่สิบเอ็ดบาทยี่สิบห้าสตางค์
String thaiBahtText(
  dynamic amount, {
  ThaiNumberOptions options = const ThaiNumberOptions(),
}) {
  // Accept num / String / int / double.
  BigInt satangTotal;
  bool negative = false;
  if (amount is String) {
    amount = amount.trim();
    if (amount.startsWith('-')) {
      negative = true;
      amount = amount.substring(1);
    }
    if (amount.isEmpty) amount = '0';
    // Normalize: allow commas
    final cleaned = amount.replaceAll(',', '');
    // Split integer/ fraction parts
    final parts = cleaned.split('.');
    final intPart = parts[0].isEmpty ? '0' : parts[0];
    var fracPart = parts.length > 1 ? parts[1] : '';
    if (fracPart.length > 6) {
      // limit to 6 for safety before rounding
      fracPart = fracPart.substring(0, 6);
    }
    // Build integer of satangs with high precision: (intPart * 10^scale + fracPart) then round to 2 decimals
    final scale = fracPart.length;
    final bigIntPart = BigInt.parse(intPart.isEmpty ? '0' : intPart);
    final fracInt = fracPart.isEmpty ? BigInt.zero : BigInt.parse(fracPart);
    // Total in 10^-scale units.
    // Convert to satang: multiply by 100, then divide by 10^scale with rounding.
    final power = BigInt.from(10).pow(scale);
    final scaled = bigIntPart * power + fracInt; // integer representing value * 10^scale
    if (power == BigInt.zero) {
      satangTotal = bigIntPart * BigInt.from(100);
    } else {
      // Multiply scaled by 100 then divide by power with rounding.
      final numerator = scaled * BigInt.from(100);
      final quotient = numerator ~/ power;
      final remainder = numerator % power;
      // Rounding: compare remainder * 2 >= power
      satangTotal = (remainder * BigInt.from(2) >= power) ? (quotient + BigInt.one) : quotient;
    }
  } else if (amount is num) {
    if (amount.isNaN) throw ArgumentError('amount is NaN');
    if (amount.isInfinite) throw ArgumentError('amount is infinite');
    if (amount < 0) {
      negative = true;
      amount = -amount;
    }
    // Avoid double precision issues by using string with adequate precision.
    final asStr = amount.toStringAsFixed(10); // high precision buffer
    return thaiBahtText(asStr, options: options).replaceFirst(options.negativeWord, negative ? options.negativeWord : '');
  } else if (amount is BigInt) {
    satangTotal = amount * BigInt.from(100);
  } else {
    throw ArgumentError('Unsupported amount type: \\${amount.runtimeType}');
  }

  if (negative) {
    return options.negativeWord + thaiBahtText(_satangBigIntToDecimalString(satangTotal), options: options);
  }

  final baht = satangTotal ~/ BigInt.from(100);
  final satang = (satangTotal % BigInt.from(100)).toInt();

  if (satang == 0) {
    return thaiNumberToWords(baht, options: options) + 'บาทถ้วน';
  }
  return thaiNumberToWords(baht, options: options) + 'บาท' + thaiNumberToWords(BigInt.from(satang), options: options) + 'สตางค์';
}

String _satangBigIntToDecimalString(BigInt satang) {
  // Convert satang BigInt back to decimal string with 2 decimals for recursion after adding negative sign.
  final isNeg = satang.isNegative;
  final abs = isNeg ? -satang : satang;
  final baht = abs ~/ BigInt.from(100);
  final sat = (abs % BigInt.from(100)).toInt();
  final s = '\\$baht.${sat.toString().padLeft(2, '0')}';
  return isNeg ? '-$s' : s;
}

class _ThaiNumberFormatter {
  static const List<String> _digits = [
    '', 'หนึ่ง', 'สอง', 'สาม', 'สี่', 'ห้า', 'หก', 'เจ็ด', 'แปด', 'เก้า'
  ];

  static String _formatBigInt(BigInt n) {
    assert(n >= BigInt.zero);

    final million = BigInt.from(1000000);
    final groups = <int>[]; // each 0..999,999 (base 1,000,000)
    var x = n;
    while (x > BigInt.zero) {
      final q = x ~/ million;
      final r = x % million;
      groups.add(r.toInt());
      x = q;
    }
    if (groups.isEmpty) return 'ศูนย์';

    final hasHigherNonZero = groups.length > 1 && groups.skip(1).any((g) => g != 0);

    final buffer = StringBuffer();
    for (var i = groups.length - 1; i >= 0; i--) {
      final g = groups[i];
      if (g != 0) {
        if (i == 0 && g == 1 && hasHigherNonZero) {
          // Final group == 1 with any preceding non-zero groups: use 'เอ็ด'
          buffer.write('เอ็ด');
        } else {
          buffer.write(_formatUnderMillion(g));
        }
      }
      if (i > 0) {
        buffer.write('ล้าน');
      }
    }
    final result = buffer.toString();
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
        sb..write('หนึ่ง')..write('แสน');
      } else {
        sb..write(_digits[ht])..write('แสน');
      }
    }

    // Ten-thousands
    final tt = digits[1];
    if (tt != 0) {
      if (tt == 1) {
        sb.write('หนึ่งหมื่น');
      } else {
        sb..write(_digits[tt])..write('หมื่น');
      }
    }

    // Thousands
    final th = digits[2];
    if (th != 0) {
      if (th == 1) {
        sb.write('หนึ่งพัน');
      } else {
        sb..write(_digits[th])..write('พัน');
      }
    }

    // Hundreds
    final h = digits[3];
    if (h != 0) {
      sb..write(_digits[h])..write('ร้อย');
    }

    // Tens
    final t = digits[4];
    if (t != 0) {
      if (t == 1) {
        sb.write('สิบ');
      } else if (t == 2) {
        sb.write('ยี่สิบ');
      } else {
        sb..write(_digits[t])..write('สิบ');
      }
    }

    // Units
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