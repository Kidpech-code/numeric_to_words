import 'options.dart';

class ThaiNumberOptions {
  final String zeroWord;
  final String negativeWord;
  const ThaiNumberOptions({
    this.zeroWord = 'ศูนย์',
    this.negativeWord = 'ลบ',
  });
}

/// แปลงเลขจำนวนเต็ม (BigInt) เป็นคำอ่านภาษาไทย
String thaiNumberToWords(
  BigInt value, {
  ThaiNumberOptions options = const ThaiNumberOptions(),
}) {
  if (value == BigInt.zero) return options.zeroWord;

  final negative = value.isNegative;
  final absVal = negative ? -value : value;

  final words = _ThaiNumberFormatter.format(absVal);

  return negative ? '${options.negativeWord}$words' : words;
}

/// convenience สำหรับ int
String thaiIntToWords(
  int value, {
  ThaiNumberOptions options = const ThaiNumberOptions(),
}) =>
    thaiNumberToWords(BigInt.from(value), options: options);

/// แปลงจำนวนเงินเป็นข้อความแบบ BAHTTEXT (อิง Microsoft Office)
/// ปัดเศษทศนิยมมาตรฐานไป 2 ตำแหน่ง (satang)
String thaiBahtText(
  dynamic amount, {
  ThaiNumberOptions options = const ThaiNumberOptions(),
}) {
  bool negative = false;
  String? raw;

  if (amount is BigInt) {
    if (amount.isNegative) negative = true;
    final abs = amount.abs();
    final satangTotal = abs * BigInt.from(100);
    return _renderBahtText(satangTotal, negative, options);
  } else if (amount is int) {
    if (amount < 0) negative = true;
    final satangTotal = BigInt.from(amount.abs()) * BigInt.from(100);
    return _renderBahtText(satangTotal, negative, options);
  } else if (amount is num) {
    if (amount.isNaN) throw ArgumentError('amount is NaN');
    if (amount.isInfinite) throw ArgumentError('amount is infinite');
    if (amount < 0) {
      negative = true;
      amount = -amount;
    }
    raw = amount.toStringAsFixed(12); // high precision buffer
  } else if (amount is String) {
    raw = amount.trim();
    if (raw.startsWith('-')) {
      negative = true;
      raw = raw.substring(1).trim();
    }
    if (raw.isEmpty) raw = '0';
  } else {
    throw ArgumentError('Unsupported amount type: ${amount.runtimeType}');
  }

  if (raw != null) {
    final cleaned = raw.replaceAll(',', '');
    final parts = cleaned.split('.');
    final intPartStr = parts[0].isEmpty ? '0' : parts[0];
    var fracStr = parts.length > 1 ? parts[1] : '';
    if (fracStr.length > 18) fracStr = fracStr.substring(0, 18);

    final intPart = BigInt.parse(intPartStr);
    final scale = fracStr.length;
    final fracInt = scale == 0 ? BigInt.zero : BigInt.parse(fracStr);

    if (scale == 0) {
      final satangTotal = intPart * BigInt.from(100);
      return _renderBahtText(satangTotal, negative, options);
    } else {
      final base = BigInt.from(10).pow(scale);
      final combined = intPart * base + fracInt; // value * base
      // round( value * 100 ) => (combined * 100 + base/2) / base
      final satangTotal = (combined * BigInt.from(100) + base ~/ BigInt.two) ~/ base;
      return _renderBahtText(satangTotal, negative, options);
    }
  }

  throw StateError('Unexpected parsing path');
}

String _renderBahtText(
  BigInt satangTotal,
  bool negative,
  ThaiNumberOptions options,
) {
  final baht = satangTotal ~/ BigInt.from(100);
  final satang = (satangTotal % BigInt.from(100)).toInt();

  final bahtWords = thaiNumberToWords(baht, options: options);
  String result;
  if (satang == 0) {
    result = '$bahtWordsบาทถ้วน';
  } else {
    final satangWords = thaiNumberToWords(BigInt.from(satang), options: options);
    result = '$bahtWordsบาท${satangWords}สตางค์';
  }
  return negative ? '${options.negativeWord}$result' : result;
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
    'เก้า'
  ];

  static String format(BigInt n) {
    if (n < BigInt.from(1000000)) {
      return _formatUnderMillion(n.toInt());
    }
    final million = BigInt.from(1000000);
    final high = n ~/ million;
    final low = n % million;
    final highWords = format(high);
    if (low == BigInt.zero) {
      return '$highWordsล้าน';
    } else if (low == BigInt.one) {
      return '$highWordsล้านเอ็ด';
    } else {
      return '$highWordsล้าน${_formatUnderMillion(low.toInt())}';
    }
  }

  static String _formatUnderMillion(int n) {
    assert(n >= 0 && n < 1000000);
    if (n == 0) return '';

    final s = n.toString().padLeft(6, '0');
    final d = s.split('').map(int.parse).toList(growable: false);
    final sb = StringBuffer();

    // hundred-thousands
    if (d[0] != 0) {
      if (d[0] == 1) sb.write('หนึ่ง'); else sb.write(_digits[d[0]]);
      sb.write('แสน');
    }
    // ten-thousands
    if (d[1] != 0) {
      if (d[1] == 1) sb.write('หนึ่งหมื่น'); else { sb.write(_digits[d[1]]); sb.write('หมื่น'); }
    }
    // thousands
    if (d[2] != 0) {
      if (d[2] == 1) sb.write('หนึ่งพัน'); else { sb.write(_digits[d[2]]); sb.write('พัน'); }
    }
    // hundreds
    if (d[3] != 0) {
      sb.write(_digits[d[3]]); sb.write('ร้อย');
    }
    // tens
    if (d[4] != 0) {
      if (d[4] == 1) sb.write('สิบ');
      else if (d[4] == 2) sb.write('ยี่สิบ');
      else { sb.write(_digits[d[4]]); sb.write('สิบ'); }
    }
    // units
    final unit = d[5];
    if (unit != 0) {
      final hasHigher = n > 10;
      if (unit == 1 && hasHigher) sb.write('เอ็ด'); else sb.write(_digits[unit]);
    }
    return sb.toString();
  }
}