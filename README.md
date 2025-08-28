
## Thai Number Words

Lightweight, pure-Dart utilities to convert numbers to Thai words: integers, currency (Baht text),
decimals, fractions, digit-by-digit reading, Thai numerals (๐–๙), and Roman numerals. Works on all
platforms supported by Dart (iOS, Android, Web, Windows, macOS, Linux) and is WASM-friendly.

[![Pub Version](https://img.shields.io/pub/v/thai_number_words)](https://pub.dev/packages/thai_number_words)
[![Pub Points](https://img.shields.io/pub/points/thai_number_words)](https://pub.dev/packages/thai_number_words/score)
[![Popularity](https://img.shields.io/pub/popularity/thai_number_words)](https://pub.dev/packages/thai_number_words/score)
[![Likes](https://img.shields.io/pub/likes/thai_number_words)](https://pub.dev/packages/thai_number_words)

This package provides easy-to-use utilities for converting numbers to Thai text, with customizable options.

## Features

- Convert integers to Thai words (supports BigInt and negatives)
- Convert to "Baht text" with half-up rounding to 2 decimals (customizable units)
- Read decimals as "point + digit-by-digit" with options for fixed fraction digits
- Handle fractions in the format "X ส่วน Y"
- Easily customize words and reading formats

## Getting Started

```dart
// Preferred entrypoint
import 'package:thai_number_words/thai_number_words.dart';
// (Legacy entrypoint remains available: package:thai_number_words/numeric_to_words.dart)
```

## Examples (Quick Start)

See the full runnable example in [example/](example/).

### Integers:

```dart
thaiIntToWords(121); // "หนึ่งร้อยยี่สิบเอ็ด"
thaiIntToWords(2523456); // "สองล้านห้าแสนยี่สิบสามพันสี่ร้อยห้าสิบหก"
thaiIntToWords(-1); // "ลบหนึ่ง"
```

### Currency (Baht text):

```dart
thaiBahtText(0); // "ศูนย์บาทถ้วน"
thaiBahtText(1.1); // "หนึ่งบาทสิบสตางค์"
thaiBahtText(1.005); // "หนึ่งบาทหนึ่งสตางค์" (half-up rounding)
thaiBahtText(-12.3); // "ลบสิบสองบาทสามสิบสตางค์"

// Customize units
thaiBahtText(
	10.5,
	options: const ThaiBahtTextOptions(majorUnit: 'ดอลลาร์', minorUnit: 'เซนต์'),
); // "สิบดอลลาร์ห้าสิบเซนต์"
```

### Decimals:

```dart
thaiDecimal(0.5); // "ศูนย์จุดห้า"
thaiDecimal(1.0); // "หนึ่ง" (by default omits trailing .0)
thaiDecimal(1.0, options: const ThaiDecimalOptions(omitPointWhenFractionZero: false));
// => "หนึ่งจุดศูนย์"
thaiDecimal(0.5, options: const ThaiDecimalOptions(fixedFractionDigits: 2));
// => "ศูนย์จุดห้าศูนย์"
```

### Fractions:

```dart
thaiFraction(BigInt.one, BigInt.two); // "หนึ่งส่วนสอง"
thaiFraction(BigInt.from(3), BigInt.from(4)); // "สามส่วนสี่"
thaiFraction(BigInt.from(-1), BigInt.from(2)); // "ลบหนึ่งส่วนสอง"
```

### Digit-by-digit (OTP/IDs):

```dart
thaiDigits('12345'); // "หนึ่งสองสามสี่ห้า"
thaiDigits('-007'); // "ลบศูนย์ศูนย์เจ็ด"
thaiDigits('12.30', options: const ThaiDigitsOptions(includeDecimalPoint: true, separator: ' '));
// => "หนึ่ง สอง จุด สาม ศูนย์"
```

### Roman numerals:

```dart
parseRoman('IV'); // 4
parseRoman('LXXX'); // 80
parseRoman('MMDCCCLXII'); // 2862
parseRoman('CM'); // 900
romanToThaiWords('IV'); // "สี่"
```

Overline note: Combining overline (U+0305) multiplies a symbol by 1,000. Example: `M\u0305` = 1,000,000.

```dart
parseRoman('M\u0305'); // 1000000
romanToThaiWords('M\u0305'); // "หนึ่งล้าน"
```

### Quick table: Roman ↔ Arabic ↔ Thai words

| Roman | Arabic   | Thai words  |
|-------|----------|-------------|
| I     | 1        | หนึ่ง       |
| IV    | 4        | สี่         |
| V     | 5        | ห้า         |
| IX    | 9        | เก้า        |
| X     | 10       | สิบ         |
| XL    | 40       | สี่สิบ      |
| L     | 50       | ห้าสิบ      |
| XC    | 90       | เก้าสิบ     |
| C     | 100      | หนึ่งร้อย   |
| D     | 500      | ห้าร้อย     |
| M     | 1000     | หนึ่งพัน    |
| M\u0305 | 1,000,000 | หนึ่งล้าน |

## Summary: integers vs decimals/fractions

| Number | Integers | Decimals/Fractions                                                      |
|--------|----------|-------------------------------------------------------------------------|
| 1.0    | หนึ่ง    | หนึ่ง (or "หนึ่งจุดศูนย์" with omitPointWhenFractionZero: false)         |
| 0.5    | –        | ศูนย์จุดห้า (or "ศูนย์จุดห้าศูนย์" when fixedFractionDigits: 2)          |
| 1/2    | –        | หนึ่งส่วนสอง                                                            |
| 3/4    | –        | สามส่วนสี่                                                              |

## Options

```dart
// Customize negative and zero words
const numOpts = ThaiNumberOptions(negativeWord: 'ติดลบ', zeroWord: 'ศูนย์');

// Customize currency units and suffix
const bahtOpts = ThaiBahtTextOptions(
	majorUnit: 'บาท',
	integerSuffix: 'ถ้วน',
);

// Customize decimal reading
const decOpts = ThaiDecimalOptions(
	decimalPointWord: 'จุด',
	omitPointWhenFractionZero: true,
);

// Digit-by-digit reading (e.g., OTP)
const digitOpts = ThaiDigitsOptions(
	separator: ' ',
	decimalPointWord: 'จุด',
);

```

## Compatibility

- Supports latest stable Dart/Flutter per `pubspec.yaml`.
- No external runtime dependencies.

## Tips & Best Practices

- Use the right utility for the job: `thaiIntToWords`/`thaiNumberToWords` (integers), `thaiBahtText` (currency), `thaiDecimal` (decimals), `thaiFraction` (fractions), `thaiDigits` (digit-by-digit).
- Prefer `const` options for reuse; use `BigInt` for very large numbers.
- Currency rounding: pass raw numbers to `thaiBahtText` (it performs half-up to 2 decimals).

---

Thai readers: อ่านเอกสารฉบับเต็มภาษาไทยได้ที่ docs/README.th.md
