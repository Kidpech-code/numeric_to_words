import 'package:thai_number_words/thai_number_words.dart';

void main() {
  // Integers
  print(thaiIntToWords(121)); // หนึ่งร้อยยี่สิบเอ็ด
  print(thaiIntToWords(2523456)); // สองล้านห้าแสนสองหมื่นสามพันสี่ร้อยห้าสิบหก
  print(thaiIntToWords(-1)); // ลบหนึ่ง

  // Baht Text
  print(thaiBahtText(0)); // ศูนย์บาทถ้วน
  print(thaiBahtText(1.1)); // หนึ่งบาทสิบสตางค์
  print(thaiBahtText(1.005)); // หนึ่งบาทหนึ่งสตางค์
  print(thaiBahtText(-12.3)); // ลบสิบสองบาทสามสิบสตางค์
  print(thaiBahtText('1,234.56')); // หนึ่งพันสองร้อยสามสิบสี่บาทห้าสิบหกสตางค์

  // Custom units
  print(
    thaiBahtText(
      10.5,
      options: const ThaiBahtTextOptions(
        majorUnit: 'ดอลลาร์',
        minorUnit: 'เซนต์',
      ),
    ),
  );
  // สิบดอลลาร์ห้าสิบเซนต์

  // Omit 'ถ้วน' for integer baht
  print(
    thaiBahtText(
      100,
      options: const ThaiBahtTextOptions(useIntegerSuffix: false),
    ),
  ); // หนึ่งร้อยบาท

  // Decimals
  print(thaiDecimal(0.5)); // ศูนย์จุดห้า
  print(thaiDecimal(1.0)); // หนึ่ง
  print(
    thaiDecimal(
      1.0,
      options: const ThaiDecimalOptions(omitPointWhenFractionZero: false),
    ),
  ); // หนึ่งจุดศูนย์
  print(
    thaiDecimal(0.5, options: const ThaiDecimalOptions(fixedFractionDigits: 2)),
  ); // ศูนย์จุดห้าศูนย์

  // Fractions
  print(thaiFraction(BigInt.one, BigInt.two)); // หนึ่งส่วนสอง
  print(thaiFraction(BigInt.from(3), BigInt.from(4))); // สามส่วนสี่
  print(thaiFraction(BigInt.from(-1), BigInt.from(2))); // ลบหนึ่งส่วนสอง

  // English/Thai currency formatting for USD
  final usd = CurrencyRegistry.byCode['USD']!;
  print(englishCurrencyText(25, usd)); // twenty-five dollars
  print(thaiCurrencyText(25, usd)); // ยี่สิบห้า ดอลลาร์สหรัฐ

  // IDs, Thai numerals, and Roman numerals
  print(thaiDigits('0012')); // ศูนย์ศูนย์หนึ่งสอง
  print(arabicDigitsToThai('123')); // ๑๒๓
  print(parseThaiInteger('๑๒๓')); // 123
  print(romanToThaiWords('IV')); // สี่
  print(romanToThaiWords('M\u0305')); // หนึ่งล้าน
}
