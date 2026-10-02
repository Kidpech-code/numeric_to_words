/// Names used by `englishCurrencyText` and `thaiCurrencyText`.
///
/// The formatters read amounts to [minorUnitDigits] decimal places. Supply
/// minor-unit names when they differ from the defaults `cent`/`cents` and
/// `สตางค์`.
class CurrencyUnit {
  /// Currency code; `THB` is formatted without a space before the Thai name.
  ///
  /// Codes are not validated.
  final String code;

  /// English name used when the whole amount is one.
  final String englishSingular;

  /// English name used for other whole amounts.
  final String englishPlural;

  /// Thai name for the major unit.
  final String thaiName;

  /// English minor-unit name used when the minor amount is one.
  final String? englishMinorSingular;

  /// English minor-unit name used for other minor amounts.
  final String? englishMinorPlural;

  /// Thai name for the minor unit.
  final String? thaiMinorName;

  /// Decimal places for this currency; defaults to 2. Use 0 for currencies
  /// without a minor unit, such as JPY.
  final int minorUnitDigits;

  /// Creates a currency unit with optional minor-unit names.
  const CurrencyUnit({
    required this.code,
    required this.englishSingular,
    required this.englishPlural,
    required this.thaiName,
    this.englishMinorSingular,
    this.englishMinorPlural,
    this.thaiMinorName,
    this.minorUnitDigits = 2,
  });
}
