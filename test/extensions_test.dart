import 'package:format_date_x/format_date_x.dart';
import 'package:test/test.dart';

void main() {
  group('StringDateX', () {
    test('dateX converts iso to display', () {
      expect('2024-01-15'.dateX('iso→display'), '15 Jan 2024');
    });

    test('dateX converts iso to us', () {
      expect('2024-01-15'.dateX('iso→us'), '01/15/2024');
    });

    test('dateX supports dash-arrow separator', () {
      expect('2024-01-15'.dateX('iso->eu'), '15/01/2024');
    });

    test('toDateX parses iso date', () {
      final date = '2024-01-15'.toDateX('iso');
      expect(date.year, 2024);
      expect(date.month, 1);
      expect(date.day, 15);
    });

    test('toDateX parses us date', () {
      final date = '01/15/2024'.toDateX('us');
      expect(date.year, 2024);
      expect(date.month, 1);
      expect(date.day, 15);
    });

    test('isValidDateX returns true for valid date', () {
      expect('2024-01-15'.isValidDateX('iso'), isTrue);
    });

    test('isValidDateX returns false for invalid date', () {
      expect('invalid'.isValidDateX('iso'), isFalse);
    });
  });

  group('DateTimeX', () {
    test('formatX with display key', () {
      final date = DateTime(2024, 1, 15);
      expect(date.formatX('display'), '15 Jan 2024');
    });

    test('formatX with long key', () {
      final date = DateTime(2024, 1, 15);
      expect(date.formatX('long'), 'January 15, 2024');
    });

    test('formatX with us key', () {
      final date = DateTime(2024, 1, 15);
      expect(date.formatX('us'), '01/15/2024');
    });

    test('formatX with eu key', () {
      final date = DateTime(2024, 1, 15);
      expect(date.formatX('eu'), '15/01/2024');
    });

    test('formatX with time key', () {
      final date = DateTime(2024, 1, 15, 14, 30);
      expect(date.formatX('time'), '14:30');
    });

    test('formatX with epoch key', () {
      final date = DateTime(2024, 1, 15);
      expect(date.formatX('epoch'), date.millisecondsSinceEpoch.toString());
    });
  });
}
