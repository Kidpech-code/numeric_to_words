# Thai Number Words — เอกสารภาษาไทย

เอกสารฉบับเต็มภาษาไทยสำหรับแพ็กเกจ thai_number_words

## คำอธิบายโดยย่อ

แพ็กเกจสำหรับแปลงตัวเลขเป็นข้อความภาษาไทย: จำนวนเต็ม สกุลเงิน (บาท/สตางค์) ทศนิยม เศษส่วน และอ่านทีละหลัก รองรับตัวเลขไทย (๐–๙) และเลขโรมัน พร้อมตัวเลือกปรับแต่งคำอ่านได้

- รองรับ BigInt และค่าติดลบ
- Baht text ปัดเศษแบบ half-up 2 ตำแหน่ง ปรับหน่วยและคำลงท้ายได้
- ทศนิยม: อ่าน "จุด" และอ่านทีละหลัก กำหนด fixedFractionDigits ได้
- เศษส่วน: รูปแบบ "X ส่วน Y"
- อ่านทีละหลัก: เหมาะกับ OTP/เบอร์โทร/เลขเอกสาร

## เริ่มต้นใช้งาน

ติดตั้งในโปรเจกต์ Dart ด้วย `dart pub add thai_number_words` หรือโปรเจกต์ Flutter ด้วย `flutter pub add thai_number_words` จากนั้นคัดลอกโค้ดนี้ไปรัน:

```dart
import 'package:thai_number_words/thai_number_words.dart';

void main() {
  print(thaiIntToWords(121)); // หนึ่งร้อยยี่สิบเอ็ด
  print(thaiBahtText(1.1));  // หนึ่งบาทสิบสตางค์
}
```

ยังใช้ import เดิม `package:thai_number_words/numeric_to_words.dart` ได้ ตัวอย่างที่รันได้ครบอยู่ใน [example/main.dart](../example/main.dart) (`dart run example/main.dart` จากโฟลเดอร์รีโป)

## เลือกฟังก์ชันให้ตรงงาน

| งาน | ฟังก์ชัน |
| --- | --- |
| จำนวนเต็ม รวมถึง `BigInt` | `thaiIntToWords` หรือ `thaiNumberToWords` |
| จำนวนเงินบาท | `thaiBahtText` |
| เงินสกุลอื่น | `thaiCurrencyText` หรือ `englishCurrencyText` กับ `CurrencyRegistry` |
| ทศนิยม | `thaiDecimal` |
| เศษส่วน | `thaiFraction` |
| OTP หรือเลขที่ต้องรักษาศูนย์นำหน้า | `thaiDigits` โดยส่งค่าเป็น `String` |
| เลขไทยหรือเลขโรมัน | `parseThaiInteger`, `arabicDigitsToThai`, `thaiNumeralsToArabic`, `parseRoman`, `romanToThaiWords` |

## ตัวอย่างการใช้งาน

ดูตัวอย่างเต็มใน [example/main.dart](../example/main.dart)

### จำนวนเต็ม (Integers)

```dart
thaiIntToWords(121); // "หนึ่งร้อยยี่สิบเอ็ด"
thaiIntToWords(2523456); // "สองล้านห้าแสนสองหมื่นสามพันสี่ร้อยห้าสิบหก"
thaiIntToWords(-1); // "ลบหนึ่ง"
```

### สกุลเงิน (Baht Text)

```dart
thaiBahtText(0); // "ศูนย์บาทถ้วน"
thaiBahtText(1.1); // "หนึ่งบาทสิบสตางค์"
thaiBahtText(1.005); // "หนึ่งบาทหนึ่งสตางค์" (ปัดเศษ half-up)
thaiBahtText(-12.3); // "ลบสิบสองบาทสามสิบสตางค์"
thaiBahtText('1,234.56'); // "หนึ่งพันสองร้อยสามสิบสี่บาทห้าสิบหกสตางค์"

// ปรับหน่วยเป็นสกุลอื่นได้
thaiBahtText(
  10.5,
  options: const ThaiBahtTextOptions(majorUnit: 'ดอลลาร์', minorUnit: 'เซนต์'),
); // "สิบดอลลาร์ห้าสิบเซนต์"

// ไม่เติม 'ถ้วน' กรณีจำนวนเต็ม
thaiBahtText(100, options: const ThaiBahtTextOptions(useIntegerSuffix: false)); // "หนึ่งร้อยบาท"
```

ถ้าต้องการเก็บจำนวนเงินตามที่ป้อนอย่างแม่นยำ ให้ส่งทศนิยมเป็น `String`; การส่ง `num` แบบเดิมยังใช้ได้

### สกุลเงินอื่น

```dart
final usd = CurrencyRegistry.byCode['USD']!;
englishCurrencyText(25, usd); // "twenty-five dollars"
thaiCurrencyText(25, usd); // "ยี่สิบห้า ดอลลาร์สหรัฐ"
englishCurrencyText(1.5, CurrencyRegistry.byCode['JPY']!); // "two yen"
englishCurrencyText('1.2345', CurrencyRegistry.byCode['KWD']!); // "one dinar and two hundred thirty-five fils"
```

ทั้งสองฟังก์ชันรับจำนวนเงินเป็น `String` ได้เมื่อค่าทศนิยมต้องแม่นยำตามที่ป้อน

### ทศนิยม (Decimals)

```dart
thaiDecimal(0.5); // "ศูนย์จุดห้า"
thaiDecimal(-0.5); // "ลบศูนย์จุดห้า"
thaiDecimal(1.0); // "หนึ่ง" (ค่าเริ่มต้น: ไม่อ่าน ".ศูนย์")

thaiDecimal(0.5, options: const ThaiDecimalOptions(fixedFractionDigits: 2));
// "ศูนย์จุดห้าศูนย์"

thaiDecimal(1.0, options: const ThaiDecimalOptions(omitPointWhenFractionZero: false));
// "หนึ่งจุดศูนย์"
```

### เศษส่วน (Fractions)

```dart
thaiFraction(BigInt.one, BigInt.two); // "หนึ่งส่วนสอง"
thaiFraction(BigInt.from(3), BigInt.from(4)); // "สามส่วนสี่"
thaiFraction(BigInt.from(-1), BigInt.from(2)); // "ลบหนึ่งส่วนสอง"
```

### อ่านทีละหลัก (Digits)

```dart
thaiDigits('12345'); // "หนึ่งสองสามสี่ห้า"
thaiDigits('-007'); // "ลบศูนย์ศูนย์เจ็ด"

thaiDigits('12.30', options: const ThaiDigitsOptions(includeDecimalPoint: true, separator: ' '));
// "หนึ่ง สอง จุด สาม ศูนย์"
```

### เลขโรมัน (Roman numerals)

```dart
parseRoman('IV'); // 4
parseRoman('LXXX'); // 80
parseRoman('MMDCCCLXII'); // 2862
parseRoman('CM'); // 900

romanToThaiWords('IV'); // "สี่"
romanToThaiWords('XV'); // "สิบห้า"
romanToThaiWords('LXXX'); // "แปดสิบ"
```

หมายเหตุ Overline (ขีดบน): ใช้ combining overline (U+0305) เพื่อคูณค่าของสัญลักษณ์ด้วย 1,000 เช่น `M̅` = 1,000,000 (เขียนเป็น `M\u0305` ใน Dart)

```dart
parseRoman('M\u0305'); // 1000000
romanToThaiWords('M\u0305'); // "หนึ่งล้าน"
```

## การตั้งค่า (Options)

```dart
const numOpts = ThaiNumberOptions(negativeWord: 'ติดลบ', zeroWord: 'ศูนย์');

const bahtOpts = ThaiBahtTextOptions(
  majorUnit: 'บาท',
  minorUnit: 'สตางค์',
  integerSuffix: 'ถ้วน',
  useIntegerSuffix: true, // กำหนด false เพื่อไม่เติม 'ถ้วน'
);

const decOpts = ThaiDecimalOptions(
  decimalPointWord: 'จุด',
  fixedFractionDigits: 2,
  omitPointWhenFractionZero: true,
);

const digitOpts = ThaiDigitsOptions(
  separator: ' ',
  includeDecimalPoint: true,
  decimalPointWord: 'จุด',
);
```

## เคสขอบ/ข้อควรระวัง

- `thaiFraction` ห้ามตัวส่วนเป็นศูนย์ (จะ `throw ArgumentError`)
- `thaiDigits` รับเลขอารบิกหรือเลขไทย (๐–๙) และจุดทศนิยมได้ไม่เกินหนึ่งตำแหน่ง
- ควรใช้ `thaiDecimal`/`thaiBahtText` แทน `thaiIntToWords` กับทศนิยม/จำนวนเงิน

## ช่วยกันพัฒนา

ยินดีรับ Issue/PR พร้อมตัวอย่าง input/output ที่ต้องการ
