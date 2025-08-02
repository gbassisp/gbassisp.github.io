# any_date

`any_date` is a popular Dart package, currently in the top decile of most-used packages on pub.dev (about 94% popularity using a similar metric to the old one), that simplifies one common but often complex task: parsing a `String` into a `DateTime` object.

## The Problem

Parsing dates from various string formats can be a tedious and error-prone process. Developers often have to write complex logic or use bulky libraries to handle the variety of date formats found in real-world applications.

## The Solution

`any_date` solves this problem by providing a simple, lightweight, and powerful API that can parse a date from almost any string format without requiring you to specify the format. It does one thing, and it does it well.

### Key Features

*   **Simple API:** A single function call is all you need.
*   **No new types:** It returns a standard `DateTime` object, so you can seamlessly integrate it into your existing code.
*   **Lightweight:** It has a minimal footprint and no unnecessary dependencies.
*   **Versatile:** It can handle a wide variety of date and time formats.

## Usage

Here's how simple it is to use `any_date`:

```dart
import 'package:any_date/any_date.dart';

void main() {
  // Create a parser
  final anyDate = AnyDate();

  // Parse a date from a string
  final date = anyDate.tryParse('2024-08-02');

  print(date); // 2024-08-02 00:00:00.000
}
```

## pub.dev

You can find the package on pub.dev:

[https://pub.dev/packages/any_date](https://pub.dev/packages/any_date)