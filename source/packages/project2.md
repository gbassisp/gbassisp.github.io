---
title: flutter_sane_lints
navOrder: 2
---


# flutter_sane_lints

`flutter_sane_lints` is a custom linting package for Dart and Flutter that helps developers write cleaner and more maintainable UI code. Its primary goal is to enforce best practices by flagging common issues directly in the IDE.

## The Problem: Hardcoded Strings in UI

Hardcoding strings directly into your widget tree is a common practice that can lead to significant problems down the line, especially when it comes to app maintenance and internationalization (i18n). Every hardcoded string becomes a hurdle when you need to support multiple languages or update branding text across the app.

## The Solution: A Custom Lint Rule

Inspired by native Android development, `flutter_sane_lints` introduces a new lint rule that raises a warning whenever it detects a hardcoded string literal within a widget. This encourages developers to externalize their strings from the beginning, leading to a more robust and scalable codebase.

### Key Features

*   **`no_hardcoded_strings_in_widgets`:** The core rule that identifies and warns about hardcoded strings in your UI.
*   **Easy Integration:** Simply add the package as a dev dependency and update your analysis options.
*   **Improved Code Quality:** Promotes a clean separation of concerns between your UI and your content.

## Usage

To enable the lint rule, add `flutter_sane_lints` to your `dev_dependencies` in `pubspec.yaml` and include it in your `analysis_options.yaml` file:

```yaml
include: package:flutter_lints/flutter.yaml

analyzer:
  plugins:
    - custom_lint

linter:
  rules:
    # your other rules
    - no_hardcoded_strings_in_widgets
```

## Learn More

I wrote a detailed article on Medium that walks through the process of creating this custom lint rule from scratch. You can read it here:

[How to create a custom lint rule for Flutter](https://medium.com/@gil.bassi/how-to-create-a-custom-lint-rule-for-flutter-49ce16210c28)

## pub.dev

You can find the package on pub.dev:

[https://pub.dev/packages/flutter_sane_lints](https://pub.dev/packages/flutter_sane_lints)