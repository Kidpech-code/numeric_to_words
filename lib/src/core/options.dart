/// Options controlling general number formatting in Thai.
class ThaiNumberOptions {
  /// Prefix for negative numbers (e.g., "ลบ").
  final String negativeWord;

  /// Word used for zero when number is exactly 0 (e.g., "ศูนย์").
  final String zeroWord;

  const ThaiNumberOptions({this.negativeWord = 'ลบ', this.zeroWord = 'ศูนย์'});
}

/// Options controlling Baht text formatting.
class ThaiBahtTextOptions extends ThaiNumberOptions {
  /// Major currency unit (default: บาท).
  final String majorUnit;

  /// Minor currency unit (default: สตางค์).
  final String minorUnit;

  /// Suffix used when there is no minor part (default: ถ้วน).
  final String integerSuffix;

  const ThaiBahtTextOptions({
    super.negativeWord = 'ลบ',
    super.zeroWord = 'ศูนย์',
    this.majorUnit = 'บาท',
    this.minorUnit = 'สตางค์',
    this.integerSuffix = 'ถ้วน',
  });
}

/// Options controlling Decimal number reading.
class ThaiDecimalOptions extends ThaiNumberOptions {
  /// Word spoken for the decimal point (default: จุด).
  final String decimalPointWord;

  /// When provided, formats the number using fixed fraction digits before reading.
  /// e.g., fixedFractionDigits: 2 -> 0.5 reads as "ศูนย์จุดห้าศูนย์".
  final int? fixedFractionDigits;

  /// If true, when the fractional part is zero (e.g. 1.0 or 1.00), the output omits
  /// the decimal point and reads only the integer portion (default: true; outputs "หนึ่ง").
  final bool omitPointWhenFractionZero;

  const ThaiDecimalOptions({
    super.negativeWord = 'ลบ',
    super.zeroWord = 'ศูนย์',
    this.decimalPointWord = 'จุด',
    this.fixedFractionDigits,
    this.omitPointWhenFractionZero = true,
  });
}

/// Options for reading digits one-by-one (e.g., 123 -> "หนึ่งสองสาม").
class ThaiDigitsOptions extends ThaiNumberOptions {
  /// Separator inserted between each spoken token. Default '' (no space).
  final String separator;

  /// If true and a decimal point '.' is present in input string, include [decimalPointWord].
  final bool includeDecimalPoint;

  /// The word for decimal point when [includeDecimalPoint] is true.
  final String decimalPointWord;

  const ThaiDigitsOptions({
    super.negativeWord = 'ลบ',
    super.zeroWord = 'ศูนย์',
    this.separator = '',
    this.includeDecimalPoint = false,
    this.decimalPointWord = 'จุด',
  });
}
