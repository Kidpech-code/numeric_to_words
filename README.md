## numeric_to_words

[![Pub Version](https://img.shields.io/pub/v/numeric_to_words)](https://pub.dev/packages/numeric_to_words)
[![Pub Points](https://img.shields.io/pub/points/numeric_to_words)](https://pub.dev/packages/numeric_to_words/score)
[![Popularity](https://img.shields.io/pub/popularity/numeric_to_words)](https://pub.dev/packages/numeric_to_words/score)
[![Likes](https://img.shields.io/pub/likes/numeric_to_words)](https://pub.dev/packages/numeric_to_words)

ตัวช่วยแปลงตัวเลขเป็นข้อความภาษาไทยแบบใช้งานง่าย ปรับแต่งได้ แยก utilities ตามหมวดหมู่ชัดเจน เช่น จำนวนเต็ม สกุลเงิน (บาท/สตางค์) จำนวนทศนิยม และเศษส่วน

## คุณสมบัติเด่น

- แปลงจำนวนเต็มเป็นคำไทย รองรับจำนวนมาก (BigInt) และค่าติดลบ
- แปลงเป็น “บาท/สตางค์” ด้วยการปัดเศษแบบ half-up 2 ตำแหน่ง พร้อมปรับแต่งหน่วยและคำลงท้าย
- อ่านทศนิยมแบบ “จุด + อ่านทีละหลัก” พร้อมตัวเลือกกำหนดจำนวนหลักทศนิยมคงที่ (เติมศูนย์ให้ครบ)
- อ่านเศษส่วนรูปแบบ “X ส่วน Y” จัดการสัญลักษณ์ลบให้ถูกต้อง
- ออกแบบ options ให้ปรับคำพูดและรูปแบบการอ่านได้ง่าย

## เริ่มต้นใช้งาน

```dart
import 'package:numeric_to_words/numeric_to_words.dart';
```

## ตัวอย่างการใช้งาน

ดูโค้ดตัวอย่างแบบเต็มในโฟลเดอร์ [example/](example/).

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

### จำนวนทศนิยม (Decimals)

อ่าน “จุด” แล้วอ่านทีละหลักหลังจุด

```dart
thaiDecimal(0.5); // "ศูนย์จุดห้า"
thaiDecimal(-0.5); // "ลบศูนย์จุดห้า"
thaiDecimal(1.0); // "หนึ่ง" (ค่าเริ่มต้น: งดอ่าน ".ศูนย์")
```

ระบุจำนวนหลักทศนิยมคงที่ (เติมศูนย์ให้ครบ)

```dart
thaiDecimal(0.5, options: const ThaiDecimalOptions(fixedFractionDigits: 2));
// "ศูนย์จุดห้าศูนย์"

thaiDecimal(1.0, options: const ThaiDecimalOptions(omitPointWhenFractionZero: false));
// "หนึ่งจุดศูนย์"
```

### เศษส่วน (Fractions)

อ่านรูปแบบ “X ส่วน Y”

```dart
thaiFraction(BigInt.one, BigInt.two); // "หนึ่งส่วนสอง"
thaiFraction(BigInt.from(3), BigInt.from(4)); // "สามส่วนสี่"
thaiFraction(BigInt.from(-1), BigInt.from(2)); // "ลบหนึ่งส่วนสอง"
```

### อ่านทีละหลัก (Digits) 🔢

อ่านตัวเลขทีละหลักแบบตรงไปตรงมา เหมาะกับรหัส/เบอร์โทร/OTP เป็นต้น

```dart
thaiDigits('12345'); // "หนึ่งสองสามสี่ห้า"
thaiDigits('-007'); // "ลบศูนย์ศูนย์เจ็ด"

// แสดงคำว่า "จุด" และคั่นด้วยช่องว่างให้อ่านง่ายขึ้น
thaiDigits(
	'12.30',
	options: const ThaiDigitsOptions(includeDecimalPoint: true, separator: ' '),
); // "หนึ่ง สอง จุด สาม ศูนย์"
```

### Roman numerals (เลขโรมัน) 🏛️

รองรับการแปลงเลขโรมันเป็นเลข และเป็นคำอ่านไทยโดยตรง (รองรับ subtractive notation เช่น IV, IX, XL, XC, CD, CM)

```dart
// แปลงเป็นตัวเลข (BigInt)
parseRoman('IV'); // 4
parseRoman('LXXX'); // 80
parseRoman('MMDCCCLXII'); // 2862
parseRoman('CM'); // 900

// แปลงเป็นคำอ่านไทยโดยตรง
romanToThaiWords('IV'); // "สี่"
romanToThaiWords('XV'); // "สิบห้า"
romanToThaiWords('LXXX'); // "แปดสิบ"
```

หมายเหตุเรื่อง overline (ขีดบน):

- สามารถใช้เครื่องหมาย overline แบบ combining (U+0305) เพื่อคูณค่าของสัญลักษณ์ด้วย 1,000 ต่อหนึ่งตัวอักษร
- ตัวอย่าง: `M\u0305` (M ตามด้วย U+0305) มีค่าเท่ากับ 1,000,000

```dart
parseRoman('M\u0305'); // 1000000
romanToThaiWords('M\u0305'); // "หนึ่งล้าน"
```

ข้อจำกัด: การแสดงผล overline อาจขึ้นอยู่กับฟอนต์/แพลตฟอร์ม แต่ค่าที่แปลงได้ถูกต้อง

#### ตารางย่อ Roman ↔ Arabic ↔ คำอ่านไทย

| Roman | Arabic   | คำอ่านไทย   |
|-------|----------|--------------|
| I     | 1        | หนึ่ง        |
| II    | 2        | สอง          |
| III   | 3        | สาม          |
| IV    | 4        | สี่           |
| V     | 5        | ห้า          |
| VI    | 6        | หก           |
| VII   | 7        | เจ็ด         |
| VIII  | 8        | แปด          |
| IX    | 9        | เก้า         |
| X     | 10       | สิบ          |
| XL    | 40       | สี่สิบ        |
| L     | 50       | ห้าสิบ       |
| XC    | 90       | เก้าสิบ       |
| C     | 100      | หนึ่งร้อย     |
| CD    | 400      | สี่ร้อย       |
| D     | 500      | ห้าร้อย       |
| CM    | 900      | เก้าร้อย      |
| M     | 1000     | หนึ่งพัน      |
| `M\u0305` | 1,000,000 | หนึ่งล้าน |

## สรุป: จำนวนเต็ม vs ทศนิยม/เศษส่วน

| ตัวเลข | จำนวนเต็ม | จำนวนทศนิยม/เศษส่วน                                                      |
| ------ | --------- | ------------------------------------------------------------------------ |
| 1.0    | หนึ่ง     | หนึ่ง (หรือ "หนึ่งจุดศูนย์" หากตั้งค่า omitPointWhenFractionZero: false) |
| 0.5    | –         | ศูนย์จุดห้า (หรือ "ศูนย์จุดห้าศูนย์" เมื่อ fixedFractionDigits: 2)       |
| 1/2    | –         | หนึ่งส่วนสอง                                                             |
| 3/4    | –         | สามส่วนสี่                                                               |

หมายเหตุ: การอ่านจำนวน “เต็ม” ต่างจาก “ทศนิยม/เศษส่วน” อย่างชัดเจน การแยกหมวดช่วยลดความสับสนในการสื่อสารและการใช้งานในระบบต่างๆ

## การปรับแต่ง (Options)

```dart
// ปรับคำลบ/คำศูนย์ สำหรับจำนวนเต็มและการอ่านทั่วไป
const numOpts = ThaiNumberOptions(negativeWord: 'ติดลบ', zeroWord: 'ศูนย์');

// ปรับหน่วยสกุลเงินและคำลงท้าย
const bahtOpts = ThaiBahtTextOptions(
	majorUnit: 'บาท',
	minorUnit: 'สตางค์',
	integerSuffix: 'ถ้วน',
);

// ปรับการอ่านทศนิยม
const decOpts = ThaiDecimalOptions(
	decimalPointWord: 'จุด',
	fixedFractionDigits: 2, // เติมศูนย์ให้ครบสองหลัก
	omitPointWhenFractionZero: true,
);

// อ่านทีละหลัก (เช่น ใช้กับ OTP) ✨
const digitOpts = ThaiDigitsOptions(
	separator: ' ', // คั่นด้วยช่องว่างให้อ่านง่าย
	includeDecimalPoint: true,
	decimalPointWord: 'จุด',
);
```

## หมายเหตุเวอร์ชัน/ความเข้ากันได้

- รองรับ Dart/Flutter ตามที่กำหนดใน `pubspec.yaml`
- ไม่พึ่งพาแพ็กเกจภายนอกสำหรับการแปลงข้อความ

## Tips & Best Practices 💡

- เลือกใช้ยูทิลิตีให้เหมาะกับงาน
	- จำนวนเต็ม: `thaiIntToWords` / `thaiNumberToWords`
	- เงิน: `thaiBahtText` (ปัดเศษ half-up 2 ตำแหน่งอัตโนมัติ)
	- ทศนิยม: `thaiDecimal` (อ่าน “จุด” และทีละหลัก) – ใช้ `fixedFractionDigits` ถ้าต้องเติมศูนย์ให้ครบ
	- เศษส่วน: `thaiFraction` (รูปแบบ “X ส่วน Y”)
	- อ่านทีละหลัก: `thaiDigits` เหมาะกับ OTP/เบอร์โทร/เลขเอกสาร

- ประสิทธิภาพ ⚡️
	- สร้าง `Options` เป็น `const` และนำกลับมาใช้ซ้ำ เพื่อลด allocation
	- ถ้าต้องแปลงชุดเดิมซ้ำๆ ให้ cache ตามค่าที่ใช้จริงในเลเยอร์ของแอป
	- ใช้ `BigInt` เมื่อมีตัวเลขใหญ่มาก แทนการแปลงผ่าน `double`

- การปัดเศษและความแม่นยำ 💰
	- เงิน: ส่งค่าไปที่ `thaiBahtText` โดยตรง ไม่ต้องปัดเศษเอง ฟังก์ชันนี้ปัดแบบ half-up ให้แล้ว (เช่น 1.005 -> 1.01)
	- ทศนิยม: ตั้ง `fixedFractionDigits` เพื่อควบคุมจำนวนหลักหลังจุดให้คงที่ (0.5 -> 0.50)
	- ต้องการเก็บเลข 0 นำหน้า (เช่น 007 หรือรูปแบบทศนิยมเฉพาะ) ให้ใช้ `thaiDigits` ด้วย String เพื่อคงรูปเดิม

- การจัดรูปแบบเพื่อ UI 🎨
	- ต้องการเว้นวรรคระหว่างคำให้อ่านง่าย ใช้ `ThaiDigitsOptions(separator: ' ')`
	- สามารถปรับ `negativeWord`, `zeroWord`, `decimalPointWord` ให้ตรงกับคู่มือภาษาขององค์กร
	- สำหรับสกุลเงินอื่น เปลี่ยน `majorUnit`, `minorUnit`, `integerSuffix` ใน `ThaiBahtTextOptions`

- เคสขอบและข้อควรระวัง 🧩
	- `thaiDecimal(1.0)` ค่าเริ่มต้นจะไม่อ่าน “จุดศูนย์”; หากต้องการ ให้ตั้ง `omitPointWhenFractionZero: false`
	- `thaiFraction(..., denominator)` ห้ามตัวส่วนเป็นศูนย์ มิฉะนั้นจะ `throw ArgumentError`
	- ตัวเลขใหญ่ที่มีหลาย “ล้าน” รองรับอยู่แล้ว (แบ่งกลุ่มทุก 6 หลัก)
	- `thaiDigits` รับเฉพาะ [0-9] และจุดได้สูงสุดหนึ่งตำแหน่ง หากมีคอมมา/ฟอร์แมตอื่น กรุณาทำความสะอาดก่อน

- Anti-patterns 🚫
	- ไม่ควรใช้ `thaiIntToWords` กับทศนิยมหรือจำนวนเงิน ให้ใช้ `thaiDecimal`/`thaiBahtText` ตามประเภทข้อมูล
	- หลีกเลี่ยงการแปลงไป-กลับ `double` เมื่อต้องการความแม่นยำด้านทศนิยม ให้ใช้ตัวเลือก/สตริงช่วยควบคุมผลลัพธ์
	- ไม่ต้องต่อสตริง “ล้าน” เอง ปล่อยให้ตัวแปลงดูแลโครงสร้างคำ

- ทดสอบให้ครอบคลุม 🧪
	- เงิน: 1.005, 2.999, ค่าติดลบ ฯลฯ
	- ทศนิยม: กำหนด `fixedFractionDigits` หลายค่าและกรณี .0
	- เศษส่วน: นิวเมอเรเตอร์/ดีโนมิเนเตอร์ติดลบ และตัวส่วนเป็นศูนย์

## ช่วยกันพัฒนา

- เปิด Issue/PR ได้ที่ repository ของโปรเจ็กต์ (กรุณาแนบตัวอย่าง input/output ที่ต้องการ)
