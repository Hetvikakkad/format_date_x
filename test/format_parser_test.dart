import 'package:format_date_x/format_date_x.dart';
import 'package:test/test.dart';

void main() {
  group('FormatParser', () {
    test('parses arrow unicode separator', () {
      final result = FormatParser.parse('iso→display');
      expect(result.inputKey, 'iso');
      expect(result.outputKey, 'display');
    });

    test('parses dash-arrow separator', () {
      final result = FormatParser.parse('us->eu');
      expect(result.inputKey, 'us');
      expect(result.outputKey, 'eu');
    });

    test('trims whitespace around keys', () {
      final result = FormatParser.parse(' iso → display ');
      expect(result.inputKey, 'iso');
      expect(result.outputKey, 'display');
    });

    test('FormatParseResult equality', () {
      const a = FormatParseResult(inputKey: 'iso', outputKey: 'us');
      const b = FormatParseResult(inputKey: 'iso', outputKey: 'us');
      const c = FormatParseResult(inputKey: 'iso', outputKey: 'eu');
      expect(a, equals(b));
      expect(a, isNot(equals(c)));
    });

    test('throws on empty string', () {
      expect(
        () => FormatParser.parse(''),
        throwsA(isA<ArgumentError>()),
      );
    });

    test('throws on missing separator', () {
      expect(
        () => FormatParser.parse('isodisplay'),
        throwsA(isA<ArgumentError>()),
      );
    });

    test('throws on multiple separators', () {
      expect(
        () => FormatParser.parse('iso→us→eu'),
        throwsA(isA<ArgumentError>()),
      );
    });

    test('throws on empty input key', () {
      expect(
        () => FormatParser.parse('→display'),
        throwsA(isA<ArgumentError>()),
      );
    });

    test('throws on empty output key', () {
      expect(
        () => FormatParser.parse('iso→'),
        throwsA(isA<ArgumentError>()),
      );
    });

    test('throws on whitespace only', () {
      expect(
        () => FormatParser.parse('   '),
        throwsA(isA<ArgumentError>()),
      );
    });
  });
}
