import 'package:format_date_x/date_x.dart';
import 'package:test/test.dart';

void main() {
  group('FormatRegistry', () {
    test('contains all built-in formats', () {
      final all = FormatRegistry.getAll();
      expect(all['iso'], 'yyyy-MM-dd');
      expect(all['iso8601'], "yyyy-MM-dd'T'HH:mm:ss");
      expect(all['api'], 'yyyy-MM-dd');
      expect(all['us'], 'MM/dd/yyyy');
      expect(all['eu'], 'dd/MM/yyyy');
      expect(all['display'], 'd MMM yyyy');
      expect(all['long'], 'MMMM d, yyyy');
      expect(all['short'], 'dd MMM yy');
      expect(all['time'], 'HH:mm');
      expect(all['datetime'], 'd MMM yyyy, HH:mm');
      expect(all['epoch'], 'epoch');
      expect(all['relative'], 'relative');
    });

    test('resolve returns pattern for built-in key', () {
      expect(FormatRegistry.resolve('iso'), 'yyyy-MM-dd');
      expect(FormatRegistry.resolve('display'), 'd MMM yyyy');
    });

    test('resolve returns null for unknown key', () {
      expect(FormatRegistry.resolve('nonexistent'), isNull);
    });

    test('register adds custom format', () {
      FormatRegistry.register('custom', 'dd.MM.yyyy');
      expect(FormatRegistry.resolve('custom'), 'dd.MM.yyyy');
      expect(FormatRegistry.getAll()['custom'], 'dd.MM.yyyy');
    });

    test('register overrides are additive', () {
      FormatRegistry.register('testfmt', 'yyyy/MM/dd');
      final all = FormatRegistry.getAll();
      expect(all.containsKey('iso'), isTrue);
      expect(all['testfmt'], 'yyyy/MM/dd');
    });

    test('getAll returns unmodifiable map', () {
      final all = FormatRegistry.getAll();
      expect(
        () => all['new'] = 'pattern',
        throwsA(isA<UnsupportedError>()),
      );
    });

    test('BuiltInFormats has correct count', () {
      expect(BuiltInFormats.formats.length, 12);
    });
  });
}
