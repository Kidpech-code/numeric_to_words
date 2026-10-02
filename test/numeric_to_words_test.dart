import 'package:test/test.dart';
import 'package:thai_number_words/thai_number_words.dart';

void main() {
  group('BAHTTEXT/Office standard edge cases', () {
    test('BAHTTEXT/Office examples', () {
      expect(thaiBahtText(0), 'ศูนย์บาทถ้วน');
      expect(thaiBahtText(1), 'หนึ่งบาทถ้วน');
      expect(thaiBahtText(5), 'ห้าบาทถ้วน');
      expect(thaiBahtText(10), 'สิบบาทถ้วน');
      expect(thaiBahtText(11), 'สิบเอ็ดบาทถ้วน');
      expect(thaiBahtText(21.25), 'ยี่สิบเอ็ดบาทยี่สิบห้าสตางค์');
      expect(thaiBahtText(12345), 'หนึ่งหมื่นสองพันสามร้อยสี่สิบห้าบาทถ้วน');
      expect(
        thaiBahtText(12345.67),
        'หนึ่งหมื่นสองพันสามร้อยสี่สิบห้าบาทหกสิบเจ็ดสตางค์',
      );
      expect(thaiBahtText(0.004), 'ศูนย์บาทถ้วน');
      expect(thaiBahtText(1.004), 'หนึ่งบาทถ้วน');
      expect(thaiBahtText(1.005), 'หนึ่งบาทหนึ่งสตางค์');
      expect(thaiBahtText(0.995), 'หนึ่งบาทถ้วน');
      expect(thaiBahtText(1.994), 'หนึ่งบาทเก้าสิบเก้าสตางค์');
      expect(thaiBahtText(1.995), 'สองบาทถ้วน');
      expect(thaiBahtText(100001), 'หนึ่งแสนเอ็ดบาทถ้วน');
      expect(thaiBahtText(1000001), 'หนึ่งล้านเอ็ดบาทถ้วน');
      expect(thaiBahtText(1001000001), 'หนึ่งพันหนึ่งล้านเอ็ดบาทถ้วน');
      expect(
        thaiBahtText(1001001000001),
        'หนึ่งล้านหนึ่งพันหนึ่งล้านเอ็ดบาทถ้วน',
      );
      expect(thaiBahtText(9009009000000), 'เก้าล้านเก้าพันเก้าล้านบาทถ้วน');
      expect(
        thaiBahtText(9998830750500),
        'เก้าล้านเก้าแสนเก้าหมื่นแปดพันแปดร้อยสามสิบล้านเจ็ดแสนห้าหมื่นห้าร้อยบาทถ้วน',
      );
      // 220,000 = สองแสนสองหมื่น
      expect(thaiIntToWords(220000), 'สองแสนสองหมื่น');
      // 1,000,001 = หนึ่งล้านเอ็ด
      expect(thaiIntToWords(1000001), 'หนึ่งล้านเอ็ด');
      // 1,001,000,001 = หนึ่งพันหนึ่งล้านเอ็ด
      expect(thaiIntToWords(1001000001), 'หนึ่งพันหนึ่งล้านเอ็ด');
      // 9,998,830,750,501 = เก้าล้านเก้าแสนเก้าหมื่นแปดพันแปดร้อยสามสิบล้านเจ็ดแสนห้าหมื่นห้าร้อยเอ็ด
      expect(
        thaiIntToWords(9998830750501),
        'เก้าล้านเก้าแสนเก้าหมื่นแปดพันแปดร้อยสามสิบล้านเจ็ดแสนห้าหมื่นห้าร้อยเอ็ด',
      );
    });
  });
  group('thaiIntToWords', () {
    test('zero and negatives', () {
      expect(thaiIntToWords(0), 'ศูนย์');
      expect(thaiIntToWords(-1), 'ลบหนึ่ง');
    });

    test('basic numbers', () {
      expect(thaiIntToWords(1), 'หนึ่ง');
      expect(thaiIntToWords(2), 'สอง');
      expect(thaiIntToWords(10), 'สิบ');
      expect(thaiIntToWords(11), 'สิบเอ็ด');
      expect(thaiIntToWords(21), 'ยี่สิบเอ็ด');
      expect(thaiIntToWords(101), 'หนึ่งร้อยเอ็ด');
      expect(thaiIntToWords(121), 'หนึ่งร้อยยี่สิบเอ็ด');
      expect(thaiIntToWords(1000), 'หนึ่งพัน');
      expect(thaiIntToWords(1000000), 'หนึ่งล้าน');
      expect(thaiIntToWords(1000001), 'หนึ่งล้านเอ็ด');
      expect(thaiIntToWords(1000011), 'หนึ่งล้านสิบเอ็ด');
      expect(thaiIntToWords(2000000), 'สองล้าน');
      expect(thaiIntToWords(2500000), 'สองล้านห้าแสน');
      expect(
        thaiIntToWords(2523456),
        'สองล้านห้าแสนสองหมื่นสามพันสี่ร้อยห้าสิบหก',
      );
    });
  });

  group('thaiBahtText', () {
    test('integer amounts', () {
      expect(thaiBahtText(0), 'ศูนย์บาทถ้วน');
      expect(thaiBahtText(1), 'หนึ่งบาทถ้วน');
      expect(thaiBahtText(11), 'สิบเอ็ดบาทถ้วน');
      expect(thaiBahtText(21), 'ยี่สิบเอ็ดบาทถ้วน');
    });

    test('satang amounts', () {
      expect(thaiBahtText(0.25), 'ศูนย์บาทยี่สิบห้าสตางค์');
      expect(thaiBahtText(1.01), 'หนึ่งบาทหนึ่งสตางค์');
      expect(thaiBahtText(1.1), 'หนึ่งบาทสิบสตางค์');
      expect(thaiBahtText(1.11), 'หนึ่งบาทสิบเอ็ดสตางค์');
    });

    test('rounding', () {
      expect(thaiBahtText(1.005), 'หนึ่งบาทหนึ่งสตางค์'); // 1.005 -> 1.01
      expect(thaiBahtText(2.999), 'สามบาทถ้วน'); // 299.9 -> 300 satang
      expect(
        thaiBahtText(1234.567),
        'หนึ่งพันสองร้อยสามสิบสี่บาทห้าสิบเจ็ดสตางค์',
      );
    });

    test('negative amounts', () {
      expect(thaiBahtText(-12.3), 'ลบสิบสองบาทสามสิบสตางค์');
    });

    test('custom units', () {
      const opts = ThaiBahtTextOptions(
        majorUnit: 'ดอลลาร์',
        minorUnit: 'เซนต์',
        integerSuffix: 'ถ้วน',
      );
      expect(thaiBahtText(10.5, options: opts), 'สิบดอลลาร์ห้าสิบเซนต์');
    });

    test('can omit the integer suffix as documented', () {
      expect(
        thaiBahtText(
          100,
          options: const ThaiBahtTextOptions(useIntegerSuffix: false),
        ),
        'หนึ่งร้อยบาท',
      );
    });

    test('reads exact decimal strings and scientific notation', () {
      expect(
        thaiBahtText('1,234.56'),
        'หนึ่งพันสองร้อยสามสิบสี่บาทห้าสิบหกสตางค์',
      );
      expect(thaiBahtText(1e-7), 'ศูนย์บาทถ้วน');
    });

    test('accepts exact negative strings and BigInt amounts', () {
      expect(thaiBahtText('-0.005'), 'ลบศูนย์บาทหนึ่งสตางค์');
      expect(thaiBahtText(BigInt.from(-12)), 'ลบสิบสองบาทถ้วน');
    });

    test('rejects malformed money strings', () {
      expect(() => thaiBahtText('12,34.56'), throwsFormatException);
    });

    test('rounds only once at the satang boundary', () {
      expect(thaiBahtText(1.0049), 'หนึ่งบาทถ้วน');
      final usd = CurrencyRegistry.byCode['USD']!;
      expect(englishCurrencyText(1.0049, usd), 'one dollar');
      expect(thaiCurrencyText(1.0049, usd), 'หนึ่ง ดอลลาร์สหรัฐ');
    });

    test('accepts exact decimal strings for other currencies', () {
      final usd = CurrencyRegistry.byCode['USD']!;
      expect(
        englishCurrencyText('25.05', usd),
        'twenty-five dollars and five cents',
      );
      expect(thaiCurrencyText('25.05', usd), 'ยี่สิบห้า ดอลลาร์สหรัฐห้าเซนต์');
    });

    test('rounds JPY to a whole yen without inventing cents', () {
      final jpy = CurrencyRegistry.byCode['JPY']!;
      expect(englishCurrencyText(1.499, jpy), 'one yen');
      expect(englishCurrencyText(1.5, jpy), 'two yen');
      expect(thaiCurrencyText(1.5, jpy), 'สอง เยน');
    });

    test('uses the registered minor units and precision', () {
      expect(
        englishCurrencyText(1.5, CurrencyRegistry.byCode['KRW']!),
        'two won',
      );
      expect(
        englishCurrencyText(1.5, CurrencyRegistry.byCode['VND']!),
        'two dong',
      );
      final kwd = CurrencyRegistry.byCode['KWD']!;
      expect(
        englishCurrencyText('1.2345', kwd),
        'one dinar and two hundred thirty-five fils',
      );
      expect(
        thaiCurrencyText('1.2345', kwd),
        'หนึ่ง ดีนาร์คูเวตสองร้อยสามสิบห้าฟิลส์',
      );
      expect(
        englishCurrencyText(1.01, CurrencyRegistry.byCode['CNY']!),
        'one renminbi and one fen',
      );
      expect(
        englishCurrencyText(1.01, CurrencyRegistry.byCode['LAK']!),
        'one kip and one aht',
      );
      expect(
        englishCurrencyText(1.01, CurrencyRegistry.byCode['SAR']!),
        'one riyal and one halala',
      );
    });
  });

  group('thaiDecimal', () {
    test('basic decimals', () {
      expect(thaiDecimal(0.5), 'ศูนย์จุดห้า');
      expect(thaiDecimal(-0.5), 'ลบศูนย์จุดห้า');
      expect(thaiDecimal(1.0), 'หนึ่ง'); // default omit when .0
      expect(
        thaiDecimal(
          1.0,
          options: ThaiDecimalOptions(omitPointWhenFractionZero: false),
        ),
        'หนึ่งจุดศูนย์',
      );
    });

    test('fixed fraction digits', () {
      expect(
        thaiDecimal(0.5, options: ThaiDecimalOptions(fixedFractionDigits: 2)),
        'ศูนย์จุดห้าศูนย์',
      );
      expect(
        thaiDecimal(1.2, options: ThaiDecimalOptions(fixedFractionDigits: 3)),
        'หนึ่งจุดสองศูนย์ศูนย์',
      );
    });

    test('reads small numbers shown in scientific notation', () {
      expect(thaiDecimal(1e-7), 'ศูนย์จุดศูนย์ศูนย์ศูนย์ศูนย์ศูนย์ศูนย์หนึ่ง');
    });

    test('includes a zero after the point when requested for integers', () {
      expect(
        thaiDecimal(
          1,
          options: const ThaiDecimalOptions(omitPointWhenFractionZero: false),
        ),
        'หนึ่งจุดศูนย์',
      );
    });
  });

  group('thaiFraction', () {
    test('basic fractions', () {
      expect(thaiFraction(BigInt.one, BigInt.two), 'หนึ่งส่วนสอง');
      expect(thaiFraction(BigInt.from(3), BigInt.from(4)), 'สามส่วนสี่');
    });

    test('negative fractions', () {
      expect(thaiFraction(BigInt.from(-1), BigInt.from(2)), 'ลบหนึ่งส่วนสอง');
      expect(thaiFraction(BigInt.from(1), BigInt.from(-2)), 'ลบหนึ่งส่วนสอง');
    });

    test('zero denominator throws', () {
      expect(() => thaiFraction(BigInt.one, BigInt.zero), throwsArgumentError);
    });
  });

  group('thaiDigits', () {
    test('basic digits', () {
      expect(thaiDigits('12345'), 'หนึ่งสองสามสี่ห้า');
      expect(thaiDigits('-007'), 'ลบศูนย์ศูนย์เจ็ด');
    });

    test('with decimal point and separator', () {
      expect(
        thaiDigits(
          '12.30',
          options: const ThaiDigitsOptions(
            includeDecimalPoint: true,
            separator: ' ',
          ),
        ),
        'หนึ่ง สอง จุด สาม ศูนย์',
      );
    });

    test('uses the configured word for zero', () {
      expect(
        thaiDigits('007', options: const ThaiDigitsOptions(zeroWord: 'ซีโร่')),
        'ซีโร่ซีโร่เจ็ด',
      );
    });
  });

  group('thai numerals parsing', () {
    test('normalize Thai numerals', () {
      expect(thaiDigits('๑๒๓๔๕'), 'หนึ่งสองสามสี่ห้า');
      expect(thaiDigits('-๐๐๗'), 'ลบศูนย์ศูนย์เจ็ด');
    });

    test('parses the documented Unicode minus sign', () {
      expect(parseThaiInteger('−๑๒๓'), BigInt.from(-123));
    });
  });

  group('roman numerals', () {
    test('basic and subtractive', () {
      expect(parseRoman('I'), BigInt.one);
      expect(parseRoman('II'), BigInt.from(2));
      expect(parseRoman('IV'), BigInt.from(4));
      expect(parseRoman('IX'), BigInt.from(9));
      expect(parseRoman('X'), BigInt.from(10));
      expect(parseRoman('XV'), BigInt.from(15));
      expect(parseRoman('LXXX'), BigInt.from(80));
      expect(parseRoman('MMDCCCLXII'), BigInt.from(2862));
      expect(parseRoman('CM'), BigInt.from(900));
    });

    test('romanToThaiWords and advanced', () {
      expect(romanToThaiWords('IV'), 'สี่');
      expect(romanToThaiWords('XV'), 'สิบห้า');
      expect(romanToThaiWords('LXXX'), 'แปดสิบ');
      // Overline combining test if environment supports combining; value check only
      expect(parseRoman('M\u0305'), BigInt.from(1000000));
    });
  });
}
