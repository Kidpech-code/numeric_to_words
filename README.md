## Thai Number Words

Lightweight, pure-Dart utilities to convert numbers to Thai words: integers, currency (Baht text),
decimals, fractions, digit-by-digit reading, Thai numerals (๐–๙), and Roman numerals. Works on all
platforms supported by Dart (iOS, Android, Web, Windows, macOS, Linux) and is WASM-friendly.

[![Pub Version](https://img.shields.io/pub/v/thai_number_words)](https://pub.dev/packages/thai_number_words)
[![Pub Points](https://img.shields.io/pub/points/thai_number_words)](https://pub.dev/packages/thai_number_words/score)
[![Likes](https://img.shields.io/pub/likes/thai_number_words)](https://pub.dev/packages/thai_number_words)

This package provides easy-to-use utilities for converting numbers to Thai text, with customizable options.

## Features

- Convert integers to Thai words (supports BigInt and negatives)
- Convert to "Baht text" with half-up rounding to 2 decimals (customizable units)
- Read decimals as "point + digit-by-digit" with options for fixed fraction digits
- Handle fractions in the format "X ส่วน Y"
- Easily customize words and reading formats

## Quick start

Add the package with `dart pub add thai_number_words` (or `flutter pub add thai_number_words` in a Flutter project), or add it to `pubspec.yaml`:

```yaml
dependencies:
  thai_number_words: ^1.0.0
```

Then copy this into a Dart file:

```dart
import 'package:thai_number_words/thai_number_words.dart';

void main() {
  print(thaiIntToWords(121)); // หนึ่งร้อยยี่สิบเอ็ด
  print(thaiBahtText(1.1));  // หนึ่งบาทสิบสตางค์
}
```

The legacy `package:thai_number_words/numeric_to_words.dart` import remains available.
Run the full example with `dart run example/main.dart` from this repository.

## Choose a function

| Need | Use |
| --- | --- |
| Integer, including `BigInt` | `thaiIntToWords` or `thaiNumberToWords` |
| Amount in baht | `thaiBahtText` |
| Other currencies | `thaiCurrencyText` or `englishCurrencyText` with `CurrencyRegistry` |
| Decimal read digit by digit after the point | `thaiDecimal` |
| Fraction | `thaiFraction` |
| ID, OTP, or other digits with leading zeroes | `thaiDigits` (pass a `String`) |
| Thai or Roman numerals | `parseThaiInteger`, `arabicDigitsToThai`, `thaiNumeralsToArabic`, `parseRoman`, or `romanToThaiWords` |

## Examples (Quick Start)

See the full runnable example in [example/](example/).

### Integers:

```dart
thaiIntToWords(121); // "หนึ่งร้อยยี่สิบเอ็ด"
thaiIntToWords(2523456); // "สองล้านห้าแสนสองหมื่นสามพันสี่ร้อยห้าสิบหก"
thaiIntToWords(-1); // "ลบหนึ่ง"
```

### Currency (Baht text):

```dart
thaiBahtText(0); // "ศูนย์บาทถ้วน"
thaiBahtText(1.1); // "หนึ่งบาทสิบสตางค์"
thaiBahtText(1.005); // "หนึ่งบาทหนึ่งสตางค์" (half-up rounding)
thaiBahtText(-12.3); // "ลบสิบสองบาทสามสิบสตางค์"
thaiBahtText('1,234.56'); // "หนึ่งพันสองร้อยสามสิบสี่บาทห้าสิบหกสตางค์"

// Customize units
thaiBahtText(
	10.5,
	options: const ThaiBahtTextOptions(majorUnit: 'ดอลลาร์', minorUnit: 'เซนต์'),
); // "สิบดอลลาร์ห้าสิบเซนต์"

// Omit 'ถ้วน' for integer baht
thaiBahtText(100, options: const ThaiBahtTextOptions(useIntegerSuffix: false)); // "หนึ่งร้อยบาท"
```

Pass a decimal `String` for exact monetary input; existing `num` calls continue to work.

### Currency (English/Thai words):

Use the built-in registry for currency names and format in English or Thai.

```dart
// English words
final usd = CurrencyRegistry.byCode['USD']!;
englishCurrencyText(25, usd); // "twenty-five dollars"
englishCurrencyText(1.05, usd); // "one dollar and five cents"

// Thai words for non-THB currency (uses a space between number and unit)
thaiCurrencyText(25, usd); // "ยี่สิบห้า ดอลลาร์สหรัฐ"

// Currencies without minor units example (JPY)
final jpy = CurrencyRegistry.byCode['JPY']!;
englishCurrencyText(1250, jpy); // "one thousand two hundred fifty yen"
thaiCurrencyText(1250, jpy); // "หนึ่งพันสองร้อยห้าสิบ เยน"
englishCurrencyText(1.5, jpy); // "two yen" (JPY has no minor unit)

final kwd = CurrencyRegistry.byCode['KWD']!;
englishCurrencyText('1.2345', kwd); // "one dinar and two hundred thirty-five fils"
```

Both currency formatters also accept decimal `String` values for exact monetary input.

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

Overline note: Combining overline (U+0305) multiplies a symbol by 1,000. For example, `M̅` = 1,000,000 (write `M\u0305` in Dart).

```dart
parseRoman('M\u0305'); // 1000000
romanToThaiWords('M\u0305'); // "หนึ่งล้าน"
```

### Thai numerals utilities:

Convert between Arabic and Thai digits, and parse Thai digits to numbers.

```dart
arabicDigitsToThai('123'); // "๑๒๓"
thaiNumeralsToArabic('๑๒๓'); // "123"
parseThaiInteger('๑๒๓'); // BigInt(123)
```

### Quick table: Roman ↔ Arabic ↔ Thai words

| Roman   | Arabic    | Thai words |
| ------- | --------- | ---------- |
| I       | 1         | หนึ่ง      |
| IV      | 4         | สี่        |
| V       | 5         | ห้า        |
| IX      | 9         | เก้า       |
| X       | 10        | สิบ        |
| XL      | 40        | สี่สิบ     |
| L       | 50        | ห้าสิบ     |
| XC      | 90        | เก้าสิบ    |
| C       | 100       | หนึ่งร้อย  |
| D       | 500       | ห้าร้อย    |
| M       | 1000      | หนึ่งพัน   |
| M̅      | 1,000,000 | หนึ่งล้าน  |

## Summary: integers vs decimals/fractions

| Number | Integers | Decimals/Fractions                                               |
| ------ | -------- | ---------------------------------------------------------------- |
| 1.0    | หนึ่ง    | หนึ่ง (or "หนึ่งจุดศูนย์" with omitPointWhenFractionZero: false) |
| 0.5    | –        | ศูนย์จุดห้า (or "ศูนย์จุดห้าศูนย์" when fixedFractionDigits: 2)  |
| 1/2    | –        | หนึ่งส่วนสอง                                                     |
| 3/4    | –        | สามส่วนสี่                                                       |

## Options

```dart
// Customize negative and zero words
const numOpts = ThaiNumberOptions(negativeWord: 'ติดลบ', zeroWord: 'ศูนย์');

// Customize currency units and suffix
const bahtOpts = ThaiBahtTextOptions(
	majorUnit: 'บาท',
	integerSuffix: 'ถ้วน',
	useIntegerSuffix: true, // set to false to omit 'ถ้วน'
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

- Requires Dart `^3.8.1` (including compatible Flutter versions).
- No external runtime dependencies.

## Tips & Best Practices

- Prefer `const` options for reuse; use `BigInt` with `thaiNumberToWords` for very large integers.
- Currency rounding is half-up to 2 decimal places; pass a decimal `String` when exact input matters.

---

Thai readers: [อ่านเอกสารภาษาไทย](doc/README.th.md)
