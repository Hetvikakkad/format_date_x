import 'package:bloc_test/bloc_test.dart';
import 'package:format_date_x/format_date_x_bloc.dart';
import 'package:test/test.dart';

void main() {
  group('DateXBloc', () {
    blocTest<DateXBloc, DateXState>(
      'initial state is DateXInitial',
      build: DateXBloc.new,
      verify: (bloc) {
        expect(bloc.state, const DateXInitial());
      },
    );

    blocTest<DateXBloc, DateXState>(
      'ConvertDateEvent emits Loading then Success',
      build: DateXBloc.new,
      act: (bloc) => bloc.add(
        const ConvertDateEvent(
          dateString: '2024-01-15',
          format: 'iso→display',
        ),
      ),
      expect: () => [
        const DateXLoading(),
        const DateXSuccess(
          result: '15 Jan 2024',
          inputValue: '2024-01-15',
          formatUsed: 'iso→display',
        ),
      ],
    );

    blocTest<DateXBloc, DateXState>(
      'ConvertDateEvent with invalid format emits Error',
      build: DateXBloc.new,
      act: (bloc) => bloc.add(
        const ConvertDateEvent(
          dateString: '2024-01-15',
          format: 'invalid',
        ),
      ),
      expect: () => [
        const DateXLoading(),
        isA<DateXError>(),
      ],
    );

    blocTest<DateXBloc, DateXState>(
      'FormatDateTimeEvent emits Loading then Success',
      build: DateXBloc.new,
      act: (bloc) => bloc.add(
        FormatDateTimeEvent(
          date: DateTime(2024, 1, 15),
          outputKey: 'long',
        ),
      ),
      expect: () => [
        const DateXLoading(),
        const DateXSuccess(
          result: 'January 15, 2024',
          inputValue: '2024-01-15T00:00:00.000',
          formatUsed: 'long',
        ),
      ],
    );

    blocTest<DateXBloc, DateXState>(
      'FormatDateTimeEvent with unknown key emits Error',
      build: DateXBloc.new,
      act: (bloc) => bloc.add(
        FormatDateTimeEvent(
          date: DateTime(2024, 1, 15),
          outputKey: 'unknown',
        ),
      ),
      expect: () => [
        const DateXLoading(),
        isA<DateXError>(),
      ],
    );

    blocTest<DateXBloc, DateXState>(
      'ResetDateXEvent resets to Initial',
      build: DateXBloc.new,
      seed: () => const DateXSuccess(
        result: '15 Jan 2024',
        inputValue: '2024-01-15',
        formatUsed: 'iso→display',
      ),
      act: (bloc) => bloc.add(const ResetDateXEvent()),
      expect: () => [const DateXInitial()],
    );

    test('DateXEvent equality', () {
      const a = ConvertDateEvent(dateString: '2024-01-15', format: 'iso→display');
      const b = ConvertDateEvent(dateString: '2024-01-15', format: 'iso→display');
      const c = ConvertDateEvent(dateString: '2024-01-16', format: 'iso→display');
      expect(a, equals(b));
      expect(a, isNot(equals(c)));
    });

    test('DateXState equality', () {
      const a = DateXSuccess(
        result: '15 Jan 2024',
        inputValue: '2024-01-15',
        formatUsed: 'iso→display',
      );
      const b = DateXSuccess(
        result: '15 Jan 2024',
        inputValue: '2024-01-15',
        formatUsed: 'iso→display',
      );
      expect(a, equals(b));
      expect(const DateXError(message: 'err'), isNot(equals(a)));
    });

    test('ResetDateXEvent is const', () {
      expect(const ResetDateXEvent(), const ResetDateXEvent());
    });
  });
}
