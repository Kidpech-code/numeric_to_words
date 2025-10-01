## 0.2.2

- Feature: Add `useIntegerSuffix` option to `ThaiBahtTextOptions` for controlling whether to append 'ถ้วน' for integer baht (default true).
- Docs: Overhaul all documentation and examples to strictly match BAHTTEXT/Office standard and correct Thai number reading rules.
- Fix: All examples and tests now use the correct Thai phrasing for all edge cases (e.g., 2523456 = "สองล้านห้าแสนสองหมื่นสามพันสี่ร้อยห้าสิบหก").
- Polish: README (EN/TH) and example/main.dart updated for clarity and accuracy.

## 0.1.0

- Initial release as a pure Dart package.
- Thai integer to words with correct phrasing rules.

## 0.2.1

- Style: Run dart format across sources to satisfy pub.dev static analysis formatting check.

## 0.1.3

- Docs polish for pub points: move full Thai-language section to `doc/README.th.md` and keep main README primarily English.
- Fixed an unclosed code block in README.

## 0.2.0

- Feature: English currency words with pluralization and half-up rounding to cents.
- Feature: Thai currency words for non-THB units using registry-based names (spacing rules applied).
- Add DDD-style structure: domain (CurrencyUnit), infrastructure (CurrencyRegistry), application (currency_format).
- Update example to show "twenty-five dollars" and Thai "ยี่สิบห้า ดอลลาร์สหรัฐ" outputs.
- Baht text with half-up rounding to 2 decimals and customizable units.
- Decimals (digit-by-digit after point) and Fractions utilities.
- Digit-by-digit reading helper with options.
- Thai numerals normalization and parsing; Arabic↔Thai digits.
- Roman numerals parsing (incl. subtractive) and direct Thai words output; overline ×1000 support.

## 0.1.1

- Rename package to `thai_number_words` for pub.dev availability.
- Update README badges and imports accordingly.

## 0.1.2

- Add package-matching entrypoint `lib/thai_number_words.dart` (keeps legacy entrypoint too).
- README: add English summary and prefer new entrypoint import.
- Formatting polish to satisfy pub score.
