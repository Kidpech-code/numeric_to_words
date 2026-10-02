/// Words used when converting an integer to Thai text.
class ThaiNumberOptions {
  /// Prefix for negative values. Defaults to `ลบ`.
  final String negativeWord;

  /// Word returned for zero. Defaults to `ศูนย์`.
  final String zeroWord;

  /// Creates reusable options for Thai number conversion.
  const ThaiNumberOptions({this.negativeWord = 'ลบ', this.zeroWord = 'ศูนย์'});
}

/// Words and units used by the exported `thaiBahtText` formatter.
class ThaiBahtTextOptions extends ThaiNumberOptions {
  /// Whether to append [integerSuffix] when there is no fractional unit.
  final bool useIntegerSuffix;

  /// Major unit, such as `บาท`. Defaults to `บาท`.
  final String majorUnit;

  /// Minor unit, such as `สตางค์`. Defaults to `สตางค์`.
  final String minorUnit;

  /// Suffix for whole amounts. Defaults to `ถ้วน`.
  final String integerSuffix;

  /// Creates options with Thai baht units and words by default.
  const ThaiBahtTextOptions({
    super.negativeWord = 'ลบ',
    super.zeroWord = 'ศูนย์',
    this.majorUnit = 'บาท',
    this.minorUnit = 'สตางค์',
    this.integerSuffix = 'ถ้วน',
    this.useIntegerSuffix = true,
  });
}

/// Words and fraction display used by `thaiDecimal`.
class ThaiDecimalOptions extends ThaiNumberOptions {
  /// Word spoken for the decimal point. Defaults to `จุด`.
  final String decimalPointWord;

  /// Number of fraction digits to format before reading them one by one.
  ///
  /// For example, `2` makes `0.5` read as `ศูนย์จุดห้าศูนย์`.
  /// Formatting uses `num.toStringAsFixed`, including its rounding behavior.
  final int? fixedFractionDigits;

  /// Whether a zero fractional part is omitted. Defaults to `true`.
  ///
  /// For example, `1.0` reads as `หนึ่ง` when this is true.
  final bool omitPointWhenFractionZero;

  /// Creates options for reading decimal numbers.
  const ThaiDecimalOptions({
    super.negativeWord = 'ลบ',
    super.zeroWord = 'ศูนย์',
    this.decimalPointWord = 'จุด',
    this.fixedFractionDigits,
    this.omitPointWhenFractionZero = true,
  });
}

/// Options for reading a numeric string one digit at a time with `thaiDigits`.
class ThaiDigitsOptions extends ThaiNumberOptions {
  /// Separator between spoken tokens. Defaults to an empty string.
  final String separator;

  /// Whether to say [decimalPointWord] for `.`. Defaults to `false`.
  final bool includeDecimalPoint;

  /// Word spoken for `.` when [includeDecimalPoint] is true. Defaults to `จุด`.
  final String decimalPointWord;

  /// Creates options for reading individual digits.
  const ThaiDigitsOptions({
    super.negativeWord = 'ลบ',
    super.zeroWord = 'ศูนย์',
    this.separator = '',
    this.includeDecimalPoint = false,
    this.decimalPointWord = 'จุด',
  });
}
