## 1.0.0

* Renamed package to `format_date_x` (name `date_x` was already taken on pub.dev).
* Split core and BLoC exports to reduce dependency conflicts when importing alongside other packages.
* Core import (`date_x.dart`) depends only on `intl` — no Flutter SDK required.
* BLoC import moved to `date_x_bloc.dart` (uses `bloc` instead of `flutter_bloc`).
* Removed `equatable` dependency; events and states use built-in equality.

## 0.1.0

* Initial release with core date conversion, format registry, extensions, and BLoC support.
