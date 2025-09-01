/// Domain entity and value objects for currency names in English and Thai.
class CurrencyUnit {
  final String code; // Optional ISO-like code (not strictly enforced)
  final String englishSingular;
  final String englishPlural;
  final String thaiName; // Thai name for the major unit

  final String? englishMinorSingular; // e.g., cent
  final String? englishMinorPlural; // e.g., cents
  final String? thaiMinorName; // e.g., สตางค์

  const CurrencyUnit({
    required this.code,
    required this.englishSingular,
    required this.englishPlural,
    required this.thaiName,
    this.englishMinorSingular,
    this.englishMinorPlural,
    this.thaiMinorName,
  });
}
