import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:format_date_x/format_date_x.dart';
import 'package:format_date_x/format_date_x_bloc.dart';

void main() {
  runApp(const DateXExampleApp());
}

class DateXExampleApp extends StatelessWidget {
  const DateXExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'format_date_x Example',
      home: BlocProvider(
        create: (_) => DateXBloc(),
        child: const DateXExamplePage(),
      ),
    );
  }
}

class DateXExamplePage extends StatefulWidget {
  const DateXExamplePage({super.key});

  @override
  State<DateXExamplePage> createState() => _DateXExamplePageState();
}

class _DateXExamplePageState extends State<DateXExamplePage> {
  final List<String> _results = [];

  @override
  void initState() {
    super.initState();
    _runExamples();
  }

  void _runExamples() {
    // DateX.convert("2024-01-15", "iso→display") → 15 Jan 2024
    _results.add(
      'iso→display: ${DateX.convert('2024-01-15', 'iso→display')}',
    );

    // DateX.convert("01/15/2024", "us→eu") → 15/01/2024
    _results.add(
      'us→eu: ${DateX.convert('01/15/2024', 'us→eu')}',
    );

    // "2024-01-15".dateX("iso→us") → 01/15/2024
    _results.add(
      'iso→us: ${'2024-01-15'.dateX('iso→us')}',
    );

    // DateTime.now().formatX("long") → January 15, 2024
    final now = DateTime(2024, 1, 15);
    _results.add(
      'formatX long: ${now.formatX('long')}',
    );

    // DateX.register("myapi", "dd-MM-yyyy")
    DateX.register('myapi', 'dd-MM-yyyy');

    // DateX.convert("15-01-2024", "myapi→display")
    _results.add(
      'myapi→display: ${DateX.convert('15-01-2024', 'myapi→display')}',
    );

    // DateX.isValid("2024-01-15", "iso") → true
    _results.add(
      'isValid iso: ${DateX.isValid('2024-01-15', 'iso')}',
    );

    // BlocProvider + BlocBuilder usage with DateXBloc
    context.read<DateXBloc>().add(
          const ConvertDateEvent(
            dateString: '2024-01-15',
            format: 'iso→display',
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('format_date_x Example')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              'Static API Results:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          ..._results.map(
            (r) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: Text(r),
            ),
          ),
          const Divider(),
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              'BLoC Result:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          BlocBuilder<DateXBloc, DateXState>(
            builder: (context, state) {
              if (state is DateXLoading) {
                return const Padding(
                  padding: EdgeInsets.all(16),
                  child: CircularProgressIndicator(),
                );
              }
              if (state is DateXSuccess) {
                return Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    '${state.inputValue} (${state.formatUsed}) → ${state.result}',
                  ),
                );
              }
              if (state is DateXError) {
                return Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text('Error: ${state.message}'),
                );
              }
              return const Padding(
                padding: EdgeInsets.all(16),
                child: Text('Waiting...'),
              );
            },
          ),
        ],
      ),
    );
  }
}
