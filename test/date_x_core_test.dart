import 'package:format_date_x/format_date_x.dart';
import 'package:test/test.dart';

void main() {
  group('DateX', () {
    test('convert iso to display', () {
      expect(
        DateX.convert('2024-01-15', 'iso→display'),
        '15 Jan 2024',
      );
    });

    test('convert us to eu', () {
      expect(
        DateX.convert('01/15/2024', 'us→eu'),
        '15/01/2024',
      );
    });

    test('convert with arrow separator', () {
      expect(
        DateX.convert('2024-01-15', 'iso->us'),
        '01/15/2024',
      );
    });

    test('format returns formatted date', () {
      final date = DateTime(2024, 1, 15);
      expect(DateX.format(date, 'long'), 'January 15, 2024');
    });

    test('parse iso date', () {
      final date = DateX.parse('2024-01-15', 'iso');
      expect(date.year, 2024);
      expect(date.month, 1);
      expect(date.day, 15);
    });

    test('register and convert custom format', () {
      DateX.register('myapi', 'dd-MM-yyyy');
      expect(
        DateX.convert('15-01-2024', 'myapi→display'),
        '15 Jan 2024',
      );
    });

    test('isValid returns true for valid iso date', () {
      expect(DateX.isValid('2024-01-15', 'iso'), isTrue);
    });

    test('isValid returns false for invalid date', () {
      expect(DateX.isValid('not-a-date', 'iso'), isFalse);
    });

    test('isValid returns false for wrong format', () {
      expect(DateX.isValid('01/15/2024', 'iso'), isFalse);
    });

    test('convert epoch to iso', () {
      final ms = DateTime(2024, 1, 15).millisecondsSinceEpoch.toString();
      expect(DateX.convert(ms, 'epoch→iso'), '2024-01-15');
    });

    test('format to epoch', () {
      final date = DateTime(2024, 1, 15);
      final result = DateX.format(date, 'epoch');
      expect(int.parse(result), date.millisecondsSinceEpoch);
    });

    test('parse relative date', () {
      final result = DateX.parse('2 days ago', 'relative');
      final expected = DateTime.now().subtract(const Duration(days: 2));
      expect(result.year, expected.year);
      expect(result.month, expected.month);
      expect(result.day, expected.day);
    });

    test('format relative date', () {
      final date = DateTime.now().subtract(const Duration(days: 3));
      final result = DateX.format(date, 'relative');
      expect(result, '3 days ago');
    });

    test('throws on unknown format key', () {
      expect(
        () => DateX.format(DateTime.now(), 'unknown'),
        throwsA(isA<ArgumentError>()),
      );
    });

    test('throws on invalid two-word format', () {
      expect(
        () => DateX.convert('2024-01-15', 'invalid'),
        throwsA(isA<ArgumentError>()),
      );
    });
  });
}
