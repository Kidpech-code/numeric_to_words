import 'package:test/test.dart';
import 'package:thai_number_words/thai_number_words.dart';

void main() {
  group('Thai Number to Words Conversion', () {
    group('Basic edge cases', () {
      test('zero', () {
        expect(thaiIntToWords(0), 'ศูนย์');
      });

      test('single digits', () {
        expect(thaiIntToWords(1), 'หนึ่ง');
      });

      test('ten', () {
        expect(thaiIntToWords(10), 'สิบ');
      });

      test('eleven (with เอ็ด)', () {
        expect(thaiIntToWords(11), 'สิบเอ็ด');
      });

      test('twenty-one (with ยี่ and เอ็ด)', () {
        expect(thaiIntToWords(21), 'ยี่สิบเอ็ด');
      });
    });

    group('Hundreds place', () {
      test('one hundred', () {
        expect(thaiIntToWords(100), 'หนึ่งร้อย');
      });

      test('one hundred and one (with เอ็ด)', () {
        expect(thaiIntToWords(101), 'หนึ่งร้อยเอ็ด');
      });

      test('one hundred and ten (with สิบ)', () {
        expect(thaiIntToWords(110), 'หนึ่งร้อยสิบ');
      });

      test('one hundred and eleven (with สิบ and เอ็ด)', () {
        expect(thaiIntToWords(111), 'หนึ่งร้อยสิบเอ็ด');
      });
    });

    group('Thousands place', () {
      test('one thousand (with พัน)', () {
        expect(thaiIntToWords(1000), 'หนึ่งพัน');
      });

      test('one thousand and one', () {
        expect(thaiIntToWords(1001), 'หนึ่งพันหนึ่ง');
      });

      test('one thousand and ten', () {
        expect(thaiIntToWords(1010), 'หนึ่งพันสิบ');
      });

      test('one thousand and eleven', () {
        expect(thaiIntToWords(1011), 'หนึ่งพันสิบเอ็ด');
      });

      test('eleven hundred', () {
        expect(thaiIntToWords(1100), 'หนึ่งพันหนึ่งร้อย');
      });

      test('eleven hundred and eleven', () {
        expect(thaiIntToWords(1111), 'หนึ่งพันหนึ่งร้อยสิบเอ็ด');
      });
    });

    group('Ten thousands and above (with หมื่น and แสน)', () {
      test('twenty thousand (with หมื่น)', () {
        expect(thaiIntToWords(20000), 'สองหมื่น');
      });

      test('twenty-one thousand', () {
        expect(thaiIntToWords(21000), 'สองหมื่นหนึ่งพัน');
      });

      test('twenty-two thousand', () {
        expect(thaiIntToWords(22000), 'สองหมื่นสองพัน');
      });

      test('twenty-three thousand', () {
        expect(thaiIntToWords(23000), 'สองหมื่นสามพัน');
      });

      test('fifty thousand', () {
        expect(thaiIntToWords(50000), 'ห้าหมื่น');
      });

      test('one hundred thousand (with แสน)', () {
        expect(thaiIntToWords(100000), 'หนึ่งแสน');
      });

      test('two hundred and twenty thousand', () {
        expect(thaiIntToWords(220000), 'ยี่สิบสองหมื่น');
      });
    });

    group('Millions (with ล้าน)', () {
      test('one million', () {
        expect(thaiIntToWords(1000000), 'หนึ่งล้าน');
      });

      test('one million and one', () {
        expect(thaiIntToWords(1000001), 'หนึ่งล้านหนึ่ง');
      });

      test('complex number with all Thai number words', () {
        expect(thaiIntToWords(12345678), 
               'สิบสองล้านสามแสนสี่หมื่นห้าพันหกร้อยเจ็ดสิบแปด');
      });
    });

    group('Negative numbers', () {
      test('negative one', () {
        expect(thaiIntToWords(-1), 'ลบหนึ่ง');
      });

      test('negative ten', () {
        expect(thaiIntToWords(-10), 'ลบสิบ');
      });

      test('negative eleven', () {
        expect(thaiIntToWords(-11), 'ลบสิบเอ็ด');
      });

      test('negative twenty-one', () {
        expect(thaiIntToWords(-21), 'ลบยี่สิบเอ็ด');
      });

      test('negative one hundred', () {
        expect(thaiIntToWords(-100), 'ลบหนึ่งร้อย');
      });

      test('negative one thousand', () {
        expect(thaiIntToWords(-1000), 'ลบหนึ่งพัน');
      });

      test('negative one million', () {
        expect(thaiIntToWords(-1000000), 'ลบหนึ่งล้าน');
      });

      test('negative complex number', () {
        expect(thaiIntToWords(-12345678), 
               'ลบสิบสองล้านสามแสนสี่หมื่นห้าพันหกร้อยเจ็ดสิบแปด');
      });
    });

    group('Special Thai number patterns', () {
      test('proper use of เอ็ด for ones place when number > 10', () {
        expect(thaiIntToWords(11), 'สิบเอ็ด');
        expect(thaiIntToWords(21), 'ยี่สิบเอ็ด');
        expect(thaiIntToWords(101), 'หนึ่งร้อยเอ็ด');
        expect(thaiIntToWords(1011), 'หนึ่งพันสิบเอ็ด');
        expect(thaiIntToWords(1000011), 'หนึ่งล้านสิบเอ็ด');
      });

      test('proper use of ยี่ for twenty', () {
        expect(thaiIntToWords(20), 'ยี่สิบ');
        expect(thaiIntToWords(21), 'ยี่สิบเอ็ด');
        expect(thaiIntToWords(22), 'ยี่สิบสอง');
        expect(thaiIntToWords(220), 'สองร้อยยี่สิบ');
        expect(thaiIntToWords(2200), 'สองพันสองร้อย');
        expect(thaiIntToWords(22000), 'สองหมื่นสองพัน');
        expect(thaiIntToWords(220000), 'ยี่สิบสองหมื่น');
      });

      test('proper use of สิบ for tens', () {
        expect(thaiIntToWords(10), 'สิบ');
        expect(thaiIntToWords(30), 'สามสิบ');
        expect(thaiIntToWords(40), 'สี่สิบ');
        expect(thaiIntToWords(50), 'ห้าสิบ');
        expect(thaiIntToWords(90), 'เก้าสิบ');
      });

      test('proper use of แสน for hundred thousands', () {
        expect(thaiIntToWords(100000), 'หนึ่งแสน');
        expect(thaiIntToWords(200000), 'สองแสน');
        expect(thaiIntToWords(500000), 'ห้าแสน');
        expect(thaiIntToWords(900000), 'เก้าแสน');
      });

      test('proper use of หมื่น for ten thousands', () {
        expect(thaiIntToWords(10000), 'หนึ่งหมื่น');
        expect(thaiIntToWords(20000), 'สองหมื่น');
        expect(thaiIntToWords(50000), 'ห้าหมื่น');
        expect(thaiIntToWords(90000), 'เก้าหมื่น');
      });

      test('proper use of พัน for thousands', () {
        expect(thaiIntToWords(1000), 'หนึ่งพัน');
        expect(thaiIntToWords(2000), 'สองพัน');
        expect(thaiIntToWords(5000), 'ห้าพัน');
        expect(thaiIntToWords(9000), 'เก้าพัน');
      });

      test('proper use of ล้าน for millions', () {
        expect(thaiIntToWords(1000000), 'หนึ่งล้าน');
        expect(thaiIntToWords(2000000), 'สองล้าน');
        expect(thaiIntToWords(5000000), 'ห้าล้าน');
        expect(thaiIntToWords(9000000), 'เก้าล้าน');
      });
    });

    group('Complex combinations', () {
      test('multiple ล้าน', () {
        expect(thaiIntToWords(12000000), 'สิบสองล้าน');
        expect(thaiIntToWords(123000000), 'หนึ่งร้อยยี่สิบสามล้าน');
      });

      test('combinations with all place values', () {
        expect(thaiIntToWords(2523456), 
               'สองล้านห้าแสนยี่สิบสามพันสี่ร้อยห้าสิบหก');
        expect(thaiIntToWords(9876543), 
               'เก้าล้านแปดแสนเจ็ดหมื่นหกพันห้าร้อยสี่สิบสาม');
      });

      test('edge cases with zeros in middle', () {
        expect(thaiIntToWords(1000011), 'หนึ่งล้านสิบเอ็ด');
        expect(thaiIntToWords(1001000), 'หนึ่งล้านหนึ่งพัน');
        expect(thaiIntToWords(1010000), 'หนึ่งล้านหนึ่งหมื่น');
        expect(thaiIntToWords(1100000), 'หนึ่งล้านหนึ่งแสน');
      });
    });
  });
}