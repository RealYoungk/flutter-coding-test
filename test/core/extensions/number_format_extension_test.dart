import 'package:flutter_coding_test/core/extensions/number_format_extension.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('IntFormatExtension', () {
    test('1000 미만은 콤마 없이 반환해야 한다', () {
      expect(0.formattedPrice, '0');
      expect(999.formattedPrice, '999');
    });

    test('1000 이상은 천 단위 콤마를 포함해야 한다', () {
      expect(1000.formattedPrice, '1,000');
      expect(72500.formattedPrice, '72,500');
      expect(1234567.formattedPrice, '1,234,567');
    });

    test('큰 숫자도 올바르게 포맷해야 한다', () {
      expect(1000000000.formattedPrice, '1,000,000,000');
    });
  });

  group('DoubleFormatExtension', () {
    test('양수는 + 기호와 함께 반환해야 한다', () {
      expect(1.25.formattedChangeRate, '+1.25%');
      expect(0.10.formattedChangeRate, '+0.10%');
    });

    test('음수는 - 기호와 함께 반환해야 한다', () {
      expect((-2.50).formattedChangeRate, '-2.50%');
    });

    test('0은 + 기호와 함께 반환해야 한다', () {
      expect(0.0.formattedChangeRate, '+0.00%');
    });

    test('소수점 2자리로 반올림해야 한다', () {
      expect(1.256.formattedChangeRate, '+1.26%');
      expect((-0.004).formattedChangeRate, '-0.00%');
    });
  });
}
