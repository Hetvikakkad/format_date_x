## 1.0.1

* Renamed entry files to `format_date_x.dart` and `format_date_x_bloc.dart`.
* Updated GitHub repository links to `format_date_x`.

## 1.0.0

* Renamed package and entry files to `format_date_x` (name `date_x` was already taken on pub.dev).
* Core import (`format_date_x.dart`) depends only on `intl` — no Flutter SDK required.
* BLoC import moved to `format_date_x_bloc.dart` (uses `bloc` instead of `flutter_bloc`).
* Removed `equatable` dependency; events and states use built-in equality.

## 0.1.0

* Initial release with core date conversion, format registry, extensions, and BLoC support.
