---
title: lean_extensions
navOrder: 3
---


# lean_extensions

`lean_extensions` is my personal and ever-evolving toolbox for Dart. It's a collection of extension methods, helper classes, and top-level functions that I've found myself needing across various projects. The goal is to make Dart development faster and more expressive by borrowing powerful concepts from other languages.

## Inspired by the Best

This package draws heavy inspiration from the standard libraries of Python and C#. If you're coming from those languages, you'll find some familiar and convenient tools:

*   **Python Built-ins:** Enjoy functions like `range()`, `zip()`, and `enumerate()` that make iterating and combining collections a breeze.
*   **C# LINQ-style Methods:** Work with collections in a more declarative way with powerful extension methods inspired by C#'s LINQ and Dart's own `collection` package.


---

## Example

```dart

// some python-like functionality
for (final i in range(10)) {
  await sleep(i);
}

// some converters for easy (de)serialization
const converter = AnyDateConverter();
final date1 = converter.fromJson('25 Nov 2023');
if (date1 == DateTime(2023, 11, 25)) {
  // easily deserializes common types
}

// some extensions with common functionality
final anInt = '1'.toInt(); // resolves to 1

// and a touch of magic
final anotherInt = 'one'.toInt(); // resolves to 1 as well

```


## pub.dev

You can find the package on pub.dev:

[https://pub.dev/packages/lean_extensions](https://pub.dev/packages/lean_extensions)