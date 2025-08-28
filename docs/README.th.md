# Thai Number Words — เอกสารภาษาไทย

เอกสารฉบับเต็มภาษาไทยสำหรับแพ็กเกจ thai_number_words

> Tip: README หลักบน pub.dev เป็นภาษาอังกฤษเพื่อให้ได้คะแนนคุณภาพสูงสุด จึงย้ายเนื้อหาภาษาไทยฉบับเต็มมาไว้ที่ไฟล์นี้

---

## คำอธิบายโดยย่อ

แพ็กเกจสำหรับแปลงตัวเลขเป็นข้อความภาษาไทย: จำนวนเต็ม สกุลเงิน (บาท/สตางค์) ทศนิยม เศษส่วน และอ่านทีละหลัก รองรับตัวเลขไทย (๐–๙) และเลขโรมัน พร้อมตัวเลือกปรับแต่งคำอ่านได้

- รองรับ BigInt และค่าติดลบ
- Baht text ปัดเศษแบบ half-up 2 ตำแหน่ง ปรับหน่วยและคำลงท้ายได้
- ทศนิยม: อ่าน "จุด" และอ่านทีละหลัก กำหนด fixedFractionDigits ได้
- เศษส่วน: รูปแบบ "X ส่วน Y"
- อ่านทีละหลัก: เหมาะกับ OTP/เบอร์โทร/เลขเอกสาร

## เริ่มต้นใช้งาน

```dart
// Preferred entrypoint
import 'package:thai_number_words/thai_number_words.dart';
// (Legacy entrypoint is still available: package:thai_number_words/numeric_to_words.dart)
```

## ตัวอย่างการใช้งาน

ดูตัวอย่างเต็มในโฟลเดอร์ example/

### จำนวนเต็ม (Integers)

```dart
thaiIntToWords(121); // "หนึ่งร้อยยี่สิบเอ็ด"
thaiIntToWords(2523456); // "สองล้านห้าแสนยี่สิบสามพันสี่ร้อยห้าสิบหก"
thaiIntToWords(-1); // "ลบหนึ่ง"
```

### สกุลเงิน (Baht Text)

```dart
thaiBahtText(0); // "ศูนย์บาทถ้วน"
thaiBahtText(1.1); // "หนึ่งบาทสิบสตางค์"
thaiBahtText(1.005); // "หนึ่งบาทหนึ่งสตางค์" (ปัดเศษ half-up)
thaiBahtText(-12.3); // "ลบสิบสองบาทสามสิบสตางค์"

// ปรับหน่วยเป็นสกุลอื่นได้
thaiBahtText(
  10.5,
  options: const ThaiBahtTextOptions(majorUnit: 'ดอลลาร์', minorUnit: 'เซนต์'),
); // "สิบดอลลาร์ห้าสิบเซนต์"
```

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

หมายเหตุ Overline (ขีดบน): ใช้ combining overline (U+0305) เพื่อคูณค่าของสัญลักษณ์ด้วย 1,000 ต่อหนึ่งตัวอักษร เช่น `M\u0305` = 1,000,000

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
- `thaiDigits` รองรับเฉพาะตัวเลข [0-9] และจุดหนึ่งตำแหน่ง
- ควรใช้ `thaiDecimal`/`thaiBahtText` แทน `thaiIntToWords` กับทศนิยม/จำนวนเงิน

## ช่วยกันพัฒนา

ยินดีรับ Issue/PR พร้อมตัวอย่าง input/output ที่ต้องการ
