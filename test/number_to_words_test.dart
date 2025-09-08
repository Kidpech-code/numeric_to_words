import 'package:test/test.dart';
import 'package:thai_number_words/thai_number_words.dart';

void main() {
  group('Thai Number to Words - Comprehensive Tests', () {
    group('Basic edge cases', () {
      test('zero', () {
        expect(thaiIntToWords(0), 'ศูนย์');
      });

      test('single digits', () {
        expect(thaiIntToWords(1), 'หนึ่ง');
        expect(thaiIntToWords(2), 'สอง');
        expect(thaiIntToWords(3), 'สาม');
        expect(thaiIntToWords(4), 'สี่');
        expect(thaiIntToWords(5), 'ห้า');
        expect(thaiIntToWords(6), 'หก');
        expect(thaiIntToWords(7), 'เจ็ด');
        expect(thaiIntToWords(8), 'แปด');
        expect(thaiIntToWords(9), 'เก้า');
      });

      test('ten and teens', () {
        expect(thaiIntToWords(10), 'สิบ');
        expect(thaiIntToWords(11), 'สิบเอ็ด');
        expect(thaiIntToWords(12), 'สิบสอง');
        expect(thaiIntToWords(13), 'สิบสาม');
        expect(thaiIntToWords(14), 'สิบสี่');
        expect(thaiIntToWords(15), 'สิบห้า');
        expect(thaiIntToWords(16), 'สิบหก');
        expect(thaiIntToWords(17), 'สิบเจ็ด');
        expect(thaiIntToWords(18), 'สิบแปด');
        expect(thaiIntToWords(19), 'สิบเก้า');
      });

      test('twenties - correct use of ยี่', () {
        expect(thaiIntToWords(20), 'ยี่สิบ');
        expect(thaiIntToWords(21), 'ยี่สิบเอ็ด');
        expect(thaiIntToWords(22), 'ยี่สิบสอง');
        expect(thaiIntToWords(23), 'ยี่สิบสาม');
        expect(thaiIntToWords(24), 'ยี่สิบสี่');
        expect(thaiIntToWords(25), 'ยี่สิบห้า');
        expect(thaiIntToWords(26), 'ยี่สิบหก');
        expect(thaiIntToWords(27), 'ยี่สิบเจ็ด');
        expect(thaiIntToWords(28), 'ยี่สิบแปด');
        expect(thaiIntToWords(29), 'ยี่สิบเก้า');
      });

      test('other tens', () {
        expect(thaiIntToWords(30), 'สามสิบ');
        expect(thaiIntToWords(40), 'สี่สิบ');
        expect(thaiIntToWords(50), 'ห้าสิบ');
        expect(thaiIntToWords(60), 'หกสิบ');
        expect(thaiIntToWords(70), 'เจ็ดสิบ');
        expect(thaiIntToWords(80), 'แปดสิบ');
        expect(thaiIntToWords(90), 'เก้าสิบ');
      });
    });

    group('Hundreds - correct use of ร้อย', () {
      test('hundreds', () {
        expect(thaiIntToWords(100), 'หนึ่งร้อย');
        expect(thaiIntToWords(200), 'สองร้อย');
        expect(thaiIntToWords(300), 'สามร้อย');
        expect(thaiIntToWords(900), 'เก้าร้อย');
      });

      test('hundreds with ones - correct use of เอ็ด', () {
        expect(thaiIntToWords(101), 'หนึ่งร้อยเอ็ด');
        expect(thaiIntToWords(201), 'สองร้อยเอ็ด');
        expect(thaiIntToWords(301), 'สามร้อยเอ็ด');
        expect(thaiIntToWords(901), 'เก้าร้อยเอ็ด');
      });

      test('hundreds with tens', () {
        expect(thaiIntToWords(110), 'หนึ่งร้อยสิบ');
        expect(thaiIntToWords(120), 'หนึ่งร้อยยี่สิบ');
        expect(thaiIntToWords(130), 'หนึ่งร้อยสามสิบ');
        expect(thaiIntToWords(190), 'หนึ่งร้อยเก้าสิบ');
      });

      test('hundreds with tens and ones - correct use of เอ็ด', () {
        expect(thaiIntToWords(111), 'หนึ่งร้อยสิบเอ็ด');
        expect(thaiIntToWords(121), 'หนึ่งร้อยยี่สิบเอ็ด');
        expect(thaiIntToWords(131), 'หนึ่งร้อยสามสิบเอ็ด');
        expect(thaiIntToWords(191), 'หนึ่งร้อยเก้าสิบเอ็ด');
      });
    });

    group('Thousands - correct use of พัน', () {
      test('thousands', () {
        expect(thaiIntToWords(1000), 'หนึ่งพัน');
        expect(thaiIntToWords(2000), 'สองพัน');
        expect(thaiIntToWords(3000), 'สามพัน');
        expect(thaiIntToWords(9000), 'เก้าพัน');
      });

      test('thousands with ones - correct use of เอ็ด', () {
        expect(thaiIntToWords(1001), 'หนึ่งพันเอ็ด');
        expect(thaiIntToWords(2001), 'สองพันเอ็ด');
        expect(thaiIntToWords(3001), 'สามพันเอ็ด');
      });

      test('thousands with tens', () {
        expect(thaiIntToWords(1010), 'หนึ่งพันสิบ');
        expect(thaiIntToWords(1020), 'หนึ่งพันยี่สิบ');
        expect(thaiIntToWords(1030), 'หนึ่งพันสามสิบ');
      });

      test('thousands with tens and ones - correct use of เอ็ด', () {
        expect(thaiIntToWords(1011), 'หนึ่งพันสิบเอ็ด');
        expect(thaiIntToWords(1021), 'หนึ่งพันยี่สิบเอ็ด');
        expect(thaiIntToWords(1031), 'หนึ่งพันสามสิบเอ็ด');
      });

      test('thousands with hundreds', () {
        expect(thaiIntToWords(1100), 'หนึ่งพันหนึ่งร้อย');
        expect(thaiIntToWords(1200), 'หนึ่งพันสองร้อย');
        expect(thaiIntToWords(1900), 'หนึ่งพันเก้าร้อย');
      });

      test('thousands with hundreds and ones - correct use of เอ็ด', () {
        expect(thaiIntToWords(1101), 'หนึ่งพันหนึ่งร้อยเอ็ด');
        expect(thaiIntToWords(1201), 'หนึ่งพันสองร้อยเอ็ด');
        expect(thaiIntToWords(1901), 'หนึ่งพันเก้าร้อยเอ็ด');
      });

      test('thousands with hundreds, tens, and ones - correct use of เอ็ด', () {
        expect(thaiIntToWords(1111), 'หนึ่งพันหนึ่งร้อยสิบเอ็ด');
        expect(thaiIntToWords(1121), 'หนึ่งพันหนึ่งร้อยยี่สิบเอ็ด');
        expect(thaiIntToWords(1131), 'หนึ่งพันหนึ่งร้อยสามสิบเอ็ด');
      });
    });

    group('Ten thousands - correct use of หมื่น', () {
      test('ten thousands', () {
        expect(thaiIntToWords(10000), 'หนึ่งหมื่น');
        expect(thaiIntToWords(20000), 'สองหมื่น');
        expect(thaiIntToWords(30000), 'สามหมื่น');
        expect(thaiIntToWords(50000), 'ห้าหมื่น');
        expect(thaiIntToWords(90000), 'เก้าหมื่น');
      });

      test('ten thousands with thousands', () {
        expect(thaiIntToWords(21000), 'สองหมื่นหนึ่งพัน');
        expect(thaiIntToWords(22000), 'สองหมื่นสองพัน');
        expect(thaiIntToWords(23000), 'สองหมื่นสามพัน');
      });
    });

    group('Hundred thousands - correct use of แสน', () {
      test('hundred thousands', () {
        expect(thaiIntToWords(100000), 'หนึ่งแสน');
        expect(thaiIntToWords(200000), 'สองแสน');
        expect(thaiIntToWords(300000), 'สามแสน');
        expect(thaiIntToWords(900000), 'เก้าแสน');
      });

      test('hundred thousands with ten thousands', () {
        expect(thaiIntToWords(220000), 'สองแสนสองหมื่น');
        expect(thaiIntToWords(230000), 'สองแสนสามหมื่น');
        expect(thaiIntToWords(250000), 'สองแสนห้าหมื่น');
      });
    });

    group('Millions - correct use of ล้าน', () {
      test('millions', () {
        expect(thaiIntToWords(1000000), 'หนึ่งล้าน');
        expect(thaiIntToWords(2000000), 'สองล้าน');
        expect(thaiIntToWords(10000000), 'สิบล้าน');
      });

      test('millions with ones - correct use of เอ็ด', () {
        expect(thaiIntToWords(1000001), 'หนึ่งล้านหนึ่ง');
        // Note: when it's millions + 1, it's หนึ่ง not เอ็ด because 
        // เอ็ด is only used when there are tens place digits
      });

      test('millions with tens - correct use of เอ็ด', () {
        expect(thaiIntToWords(1000011), 'หนึ่งล้านสิบเอ็ด');
        expect(thaiIntToWords(1000021), 'หนึ่งล้านยี่สิบเอ็ด');
      });
    });

    group('Complex large numbers', () {
      test('multi-million complex number', () {
        expect(
          thaiIntToWords(12345678),
          'สิบสองล้านสามแสนสี่หมื่นห้าพันหกร้อยเจ็ดสิบแปด',
        );
      });

      test('various complex combinations', () {
        expect(thaiIntToWords(123456), 'หนึ่งแสนสองหมื่นสามพันสี่ร้อยห้าสิบหก');
        expect(thaiIntToWords(654321), 'หกแสนห้าหมื่นสี่พันสามร้อยยี่สิบเอ็ด');
        expect(thaiIntToWords(987654), 'เก้าแสนแปดหมื่นเจ็ดพันหกร้อยห้าสิบสี่');
      });
    });

    group('Required specific test cases', () {
      test('specific required numbers', () {
        expect(thaiIntToWords(0), 'ศูนย์');
        expect(thaiIntToWords(1), 'หนึ่ง');
        expect(thaiIntToWords(10), 'สิบ');
        expect(thaiIntToWords(11), 'สิบเอ็ด');
        expect(thaiIntToWords(21), 'ยี่สิบเอ็ด');
        expect(thaiIntToWords(100), 'หนึ่งร้อย');
        expect(thaiIntToWords(101), 'หนึ่งร้อยเอ็ด');
        expect(thaiIntToWords(110), 'หนึ่งร้อยสิบ');
        expect(thaiIntToWords(111), 'หนึ่งร้อยสิบเอ็ด');
        expect(thaiIntToWords(1000), 'หนึ่งพัน');
        expect(thaiIntToWords(1001), 'หนึ่งพันเอ็ด');
        expect(thaiIntToWords(1010), 'หนึ่งพันสิบ');
        expect(thaiIntToWords(1011), 'หนึ่งพันสิบเอ็ด');
        expect(thaiIntToWords(1100), 'หนึ่งพันหนึ่งร้อย');
        expect(thaiIntToWords(1111), 'หนึ่งพันหนึ่งร้อยสิบเอ็ด');
        expect(thaiIntToWords(20000), 'สองหมื่น');
        expect(thaiIntToWords(21000), 'สองหมื่นหนึ่งพัน');
        expect(thaiIntToWords(22000), 'สองหมื่นสองพัน');
        expect(thaiIntToWords(23000), 'สองหมื่นสามพัน');
        expect(thaiIntToWords(50000), 'ห้าหมื่น');
        expect(thaiIntToWords(100000), 'หนึ่งแสน');
        expect(thaiIntToWords(220000), 'สองแสนสองหมื่น');
        expect(thaiIntToWords(1000000), 'หนึ่งล้าน');
        expect(thaiIntToWords(1000001), 'หนึ่งล้านหนึ่ง');
        expect(thaiIntToWords(12345678), 'สิบสองล้านสามแสนสี่หมื่นห้าพันหกร้อยเจ็ดสิบแปด');
      });
    });

    group('Negative numbers', () {
      test('negative single digits', () {
        expect(thaiIntToWords(-1), 'ลบหนึ่ง');
        expect(thaiIntToWords(-5), 'ลบห้า');
        expect(thaiIntToWords(-9), 'ลบเก้า');
      });

      test('negative tens and teens', () {
        expect(thaiIntToWords(-10), 'ลบสิบ');
        expect(thaiIntToWords(-11), 'ลบสิบเอ็ด');
        expect(thaiIntToWords(-21), 'ลบยี่สิบเอ็ด');
      });

      test('negative hundreds', () {
        expect(thaiIntToWords(-100), 'ลบหนึ่งร้อย');
        expect(thaiIntToWords(-101), 'ลบหนึ่งร้อยเอ็ด');
        expect(thaiIntToWords(-111), 'ลบหนึ่งร้อยสิบเอ็ด');
      });

      test('negative thousands', () {
        expect(thaiIntToWords(-1000), 'ลบหนึ่งพัน');
        expect(thaiIntToWords(-1001), 'ลบหนึ่งพันเอ็ด');
        expect(thaiIntToWords(-1111), 'ลบหนึ่งพันหนึ่งร้อยสิบเอ็ด');
      });

      test('negative large numbers', () {
        expect(thaiIntToWords(-10000), 'ลบหนึ่งหมื่น');
        expect(thaiIntToWords(-100000), 'ลบหนึ่งแสน');
        expect(thaiIntToWords(-1000000), 'ลบหนึ่งล้าน');
        expect(thaiIntToWords(-12345678), 'ลบสิบสองล้านสามแสนสี่หมื่นห้าพันหกร้อยเจ็ดสิบแปด');
      });
    });

    group('Thai number word usage verification', () {
      test('correct usage of เอ็ด (only when there are higher place values)', () {
        // เอ็ด should appear in ones place only when there are tens or higher
        expect(thaiIntToWords(1), 'หนึ่ง'); // not เอ็ด
        expect(thaiIntToWords(11), 'สิบเอ็ด'); // เอ็ด because there's tens
        expect(thaiIntToWords(21), 'ยี่สิบเอ็ด'); // เอ็ด because there's tens
        expect(thaiIntToWords(101), 'หนึ่งร้อยเอ็ด'); // เอ็ด because there's hundreds
        expect(thaiIntToWords(1001), 'หนึ่งพันเอ็ด'); // เอ็ด because there's thousands
        expect(thaiIntToWords(1000001), 'หนึ่งล้านหนึ่ง'); // หนึ่ง not เอ็ด because no tens
      });

      test('correct usage of ยี่ (only for twenties)', () {
        expect(thaiIntToWords(20), 'ยี่สิบ');
        expect(thaiIntToWords(21), 'ยี่สิบเอ็ด');
        expect(thaiIntToWords(29), 'ยี่สิบเก้า');
        expect(thaiIntToWords(120), 'หนึ่งร้อยยี่สิบ');
        expect(thaiIntToWords(1020), 'หนึ่งพันยี่สิบ');
        // Not ยี่ for other numbers
        expect(thaiIntToWords(30), 'สามสิบ'); // not ยี่สามสิบ
        expect(thaiIntToWords(12), 'สิบสอง'); // not ยี่
      });

      test('correct usage of สิบ', () {
        expect(thaiIntToWords(10), 'สิบ');
        expect(thaiIntToWords(11), 'สิบเอ็ด');
        expect(thaiIntToWords(30), 'สามสิบ');
        expect(thaiIntToWords(110), 'หนึ่งร้อยสิบ');
      });

      test('correct usage of แสน (hundred thousands)', () {
        expect(thaiIntToWords(100000), 'หนึ่งแสน');
        expect(thaiIntToWords(200000), 'สองแสน');
        expect(thaiIntToWords(500000), 'ห้าแสน');
      });

      test('correct usage of หมื่น (ten thousands)', () {
        expect(thaiIntToWords(10000), 'หนึ่งหมื่น');
        expect(thaiIntToWords(20000), 'สองหมื่น');
        expect(thaiIntToWords(50000), 'ห้าหมื่น');
      });

      test('correct usage of พัน (thousands)', () {
        expect(thaiIntToWords(1000), 'หนึ่งพัน');
        expect(thaiIntToWords(2000), 'สองพัน');
        expect(thaiIntToWords(5000), 'ห้าพัน');
      });

      test('correct usage of ล้าน (millions)', () {
        expect(thaiIntToWords(1000000), 'หนึ่งล้าน');
        expect(thaiIntToWords(2000000), 'สองล้าน');
        expect(thaiIntToWords(10000000), 'สิบล้าน');
      });
    });
  });
}