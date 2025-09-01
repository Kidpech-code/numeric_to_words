import '../domain/currency.dart';

/// Registry of currency units (selected set per provided list).
/// Note: Names align with the Royal Institute list where applicable.
class CurrencyRegistry {
  static final Map<String, CurrencyUnit> byCode = {
    // Common examples
    'USD': const CurrencyUnit(
      code: 'USD',
      englishSingular: 'dollar',
      englishPlural: 'dollars',
      thaiName: 'ดอลลาร์สหรัฐ',
      englishMinorSingular: 'cent',
      englishMinorPlural: 'cents',
      thaiMinorName: 'เซนต์',
    ),
    'THB': const CurrencyUnit(
      code: 'THB',
      englishSingular: 'baht',
      englishPlural: 'baht',
      thaiName: 'บาท',
      englishMinorSingular: 'satang',
      englishMinorPlural: 'satang',
      thaiMinorName: 'สตางค์',
    ),
    'JPY': const CurrencyUnit(
      code: 'JPY',
      englishSingular: 'yen',
      englishPlural: 'yen',
      thaiName: 'เยน',
    ),
    'EUR': const CurrencyUnit(
      code: 'EUR',
      englishSingular: 'euro',
      englishPlural: 'euros',
      thaiName: 'ยูโร',
      englishMinorSingular: 'cent',
      englishMinorPlural: 'cents',
      thaiMinorName: 'เซนต์',
    ),
    'GBP': const CurrencyUnit(
      code: 'GBP',
      englishSingular: 'pound',
      englishPlural: 'pounds',
      thaiName: 'ปอนด์สเตอร์ลิง',
      englishMinorSingular: 'pence',
      englishMinorPlural: 'pence',
      thaiMinorName: 'เพนนี',
    ),
    'CNY': const CurrencyUnit(
      code: 'CNY',
      englishSingular: 'renminbi',
      englishPlural: 'renminbi',
      thaiName: 'หยวนเหรินหมินปี้',
    ),
    'KRW': const CurrencyUnit(
      code: 'KRW',
      englishSingular: 'won',
      englishPlural: 'won',
      thaiName: 'วอน',
    ),
    'VND': const CurrencyUnit(
      code: 'VND',
      englishSingular: 'dong',
      englishPlural: 'dong',
      thaiName: 'ดอง',
    ),
    'LAK': const CurrencyUnit(
      code: 'LAK',
      englishSingular: 'kip',
      englishPlural: 'kip',
      thaiName: 'กีบ',
    ),
    'KWD': const CurrencyUnit(
      code: 'KWD',
      englishSingular: 'dinar',
      englishPlural: 'dinars',
      thaiName: 'ดีนาร์คูเวต',
    ),
    'SAR': const CurrencyUnit(
      code: 'SAR',
      englishSingular: 'riyal',
      englishPlural: 'riyals',
      thaiName: 'ริยัลซาอุดีอาระเบีย',
    ),
    'HKD': const CurrencyUnit(
      code: 'HKD',
      englishSingular: 'dollar',
      englishPlural: 'dollars',
      thaiName: 'ดอลลาร์ฮ่องกง',
      englishMinorSingular: 'cent',
      englishMinorPlural: 'cents',
      thaiMinorName: 'เซนต์',
    ),
    'SGD': const CurrencyUnit(
      code: 'SGD',
      englishSingular: 'dollar',
      englishPlural: 'dollars',
      thaiName: 'ดอลลาร์สิงคโปร์',
      englishMinorSingular: 'cent',
      englishMinorPlural: 'cents',
      thaiMinorName: 'เซนต์',
    ),
    'AUD': const CurrencyUnit(
      code: 'AUD',
      englishSingular: 'dollar',
      englishPlural: 'dollars',
      thaiName: 'ดอลลาร์ออสเตรเลีย',
      englishMinorSingular: 'cent',
      englishMinorPlural: 'cents',
      thaiMinorName: 'เซนต์',
    ),
    'CAD': const CurrencyUnit(
      code: 'CAD',
      englishSingular: 'dollar',
      englishPlural: 'dollars',
      thaiName: 'ดอลลาร์แคนาดา',
      englishMinorSingular: 'cent',
      englishMinorPlural: 'cents',
      thaiMinorName: 'เซนต์',
    ),
    'NZD': const CurrencyUnit(
      code: 'NZD',
      englishSingular: 'dollar',
      englishPlural: 'dollars',
      thaiName: 'ดอลลาร์นิวซีแลนด์',
      englishMinorSingular: 'cent',
      englishMinorPlural: 'cents',
      thaiMinorName: 'เซนต์',
    ),
    // Add more as needed...
  };
}
