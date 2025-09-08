import 'package:test/test.dart';
import 'package:numeric_to_words/src/core/number_to_words.dart';

void main() {
  group('thaiNumberToWords / thaiIntToWords basic numbers', () {
    test('zero', () => expect(thaiIntToWords(0), 'ศูนย์'));
    test('one', () => expect(thaiIntToWords(1), 'หนึ่ง'));
    test('two', () => expect(thaiIntToWords(2), 'สอง'));
    test('ten', () => expect(thaiIntToWords(10), 'สิบ'));
    test('eleven', () => expect(thaiIntToWords(11), 'สิบเอ็ด'));
    test('twenty one', () => expect(thaiIntToWords(21), 'ยี่สิบเอ็ด'));
    test('hundred and one', () => expect(thaiIntToWords(101), 'หนึ่งร้อยหนึ่ง'));
  });

  group('thaiNumberToWords large & million recursion', () {
    test('one million', () => expect(thaiIntToWords(1000000), 'หนึ่งล้าน'));
    test('one million and one', () => expect(thaiIntToWords(1000001), 'หนึ่งล้านเอ็ด'));
    test('two million', () => expect(thaiIntToWords(2000000), 'สองล้าน'));
    test('123,456,789', () => expect(thaiIntToWords(123456789), 'หนึ่งร้อยยี่สิบสามล้านสี่แสนห้าหมื่นหกพันเจ็ดร้อยแปดสิบเก้า'));
  });

  group('thaiBahtText integer amounts', () {
    test('0', () => expect(thaiBahtText(0), 'ศูนย์บาทถ้วน'));
    test('1', () => expect(thaiBahtText(1), 'หนึ่งบาทถ้วน'));
    test('1 (BigInt)', () => expect(thaiBahtText(BigInt.one), 'หนึ่งบาทถ้วน'));
    test('1 (String)', () => expect(thaiBahtText('1'), 'หนึ่งบาทถ้วน'));
    test('1000000', () => expect(thaiBahtText(1000000), 'หนึ่งล้านบาทถ้วน'));
  });

  group('thaiBahtText fractional rounding', () {
    test('1.01', () => expect(thaiBahtText(1.01), 'หนึ่งบาทหนึ่งสตางค์'));
    test('1.1 -> 1.10', () => expect(thaiBahtText(1.1), 'หนึ่งบาทสิบสตางค์'));
    test('1.005 rounds up', () => expect(thaiBahtText(1.005), 'หนึ่งบาทหนึ่งสตางค์'));
    test('1.004 rounds down', () => expect(thaiBahtText(1.004), 'หนึ่งบาทถ้วน'));
    test('string long fraction rounds (123.4567891234567899)', () => expect(thaiBahtText('123.4567891234567899'), 'หนึ่งร้อยยี่สิบสามบาทสี่สิบหกสตางค์'));
    test('0.995 -> 1.00', () => expect(thaiBahtText(0.995), 'หนึ่งบาทถ้วน'));
  });

  group('thaiBahtText negative', () {
    test('-2.5', () => expect(thaiBahtText(-2.5), 'ลบสองบาทห้าสิบสตางค์'));
    test('-0.005 -> -0.01', () => expect(thaiBahtText(-0.005), 'ลบหนึ่งสตางค์'));
  });
}