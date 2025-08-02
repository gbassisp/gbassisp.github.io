# lean_extensions

`lean_extensions` is my personal and ever-evolving toolbox for Dart. It's a collection of extension methods, helper classes, and top-level functions that I've found myself needing across various projects. The goal is to make Dart development faster and more expressive by borrowing powerful concepts from other languages.

## Inspired by the Best

This package draws heavy inspiration from the standard libraries of Python and C#. If you're coming from those languages, you'll find some familiar and convenient tools:

*   **Python Built-ins:** Enjoy functions like `range()`, `zip()`, and `enumerate()` that make iterating and combining collections a breeze.
*   **C# LINQ-style Methods:** Work with collections in a more declarative way with powerful extension methods inspired by C#'s LINQ and Dart's own `collection` package.

### Key Features

*   **Rich Collection Extensions:** A wide array of methods for filtering, mapping, and manipulating lists, maps, and iterables.
*   **String Utilities:** Helpers for common string operations.
*   **Convenience Functions:** Top-level functions for tasks that don't neatly fit into a class.

## Usage

Here is a small taste of what you can do with `lean_extensions`:

```dart
import 'package:lean_extensions/lean_extensions.dart';

void main() {
  // Use range() to create a list of numbers
  final numbers = range(5).toList(); // [0, 1, 2, 3, 4]

  // Use enumerate() to get index-value pairs
  for (final (index, value) in enumerate(numbers)) {
    print('Index: $index, Value: $value');
  }

  // Use zip() to combine two lists
  final letters = ['a', 'b', 'c'];
  final zipped = zip([numbers, letters]);
  print(zipped); // [[0, 'a'], [1, 'b'], [2, 'c']]
}
```

## pub.dev

You can find the package on pub.dev:

[https://pub.dev/packages/lean_extensions](https://pub.dev/packages/lean_extensions)