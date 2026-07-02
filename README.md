# format_date_x

A flexible date formatting and conversion package with optional BLoC support.

## Features

- Built-in date formats (ISO, US, EU, display, long, short, time, datetime, epoch, relative)
- Custom format registration
- Two-word format conversion (`iso→display`, `us→eu`)
- String and DateTime extensions
- Optional BLoC integration (import separately to avoid dependency conflicts)

## Installation

Add to your `pubspec.yaml`:

```yaml
dependencies:
  format_date_x: ^1.0.0
```

For date conversion only, that is all you need. The core package depends only on `intl` and works in Dart or Flutter apps without pulling in BLoC or Flutter SDK constraints.

## Usage

### Date conversion (recommended import)

```dart
import 'package:format_date_x/format_date_x.dart';

// Core API
DateX.convert('2024-01-15', 'iso→display'); // 15 Jan 2024
DateX.convert('01/15/2024', 'us→eu');       // 15/01/2024

// Extensions
'2024-01-15'.dateX('iso→us');               // 01/15/2024
DateTime.now().formatX('long');             // January 15, 2024

// Custom formats
DateX.register('myapi', 'dd-MM-yyyy');
DateX.convert('15-01-2024', 'myapi→display');

// Validation
DateX.isValid('2024-01-15', 'iso');         // true
```

### BLoC (optional, separate import)

Only import BLoC when you need reactive date operations. Your app already uses `flutter_bloc` for UI — `format_date_x` does not force a conflicting version.

```dart
import 'package:format_date_x/format_date_x_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

BlocProvider(
  create: (_) => DateXBloc(),
  child: BlocBuilder<DateXBloc, DateXState>(
    builder: (context, state) { /* ... */ },
  ),
);
```

## Avoiding package conflicts

| Goal | Import |
|------|--------|
| Convert / format dates only | `package:format_date_x/format_date_x.dart` |
| BLoC state management | `package:format_date_x/format_date_x_bloc.dart` |

Importing only `format_date_x.dart` keeps your dependency tree minimal (`intl` only) and avoids version clashes with `flutter_bloc`, `equatable`, or other packages in your app.

## License

MIT
