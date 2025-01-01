# Loggycian Flutter

[![style: very good analysis][very_good_analysis_badge]][very_good_analysis_link]
[![Powered by Mason](https://img.shields.io/endpoint?url=https%3A%2F%2Ftinyurl.com%2Fmason-badge)](https://github.com/felangel/mason)

A powerful logging and debugging toolkit for Flutter applications. Currently featuring network logging capabilities with support for navigation, analytics, and more debugging tools coming soon.

## Features 🚀

- 📊 Network Logging
  - View HTTP requests and responses in real-time
  - Support for Dio, HTTP package, and GraphQL
  - Filter and search capabilities
  - Copy request/response data and cURL commands
- 🔜 Coming Soon
  - Navigation logging
  - Analytics events tracking
  - Performance metrics
  - State management debugging

## Installation 💻

**❗ In order to start using Loggycian Flutter you must have the [Flutter SDK][flutter_install_link] installed on your machine.**

Install via `flutter pub add`:

```sh
dart pub add loggycian_flutter
```

---

## Basic Usage 📱

1. Wrap your app with `Loggycian`:

```dart
void main() {
  runApp(
    Loggycian(
      app: MyApp(),
      visible: !kReleaseMode, // Optional: Only show in debug mode
    ),
  );
}
```

2. Add interceptors to your HTTP clients:

```dart
// For Dio
final dio = Dio()..interceptors.add(DioInterceptor());

// For HTTP package
final client = HttpInterceptor(http.Client());

// For GraphQL
final link = GqlInterceptor(HttpLink('YOUR_GRAPHQL_ENDPOINT'));
```

3. That's it! The debug button will appear on your screen. Tap it to view logs.

---

[flutter_install_link]: https://docs.flutter.dev/get-started/install
[github_actions_link]: https://docs.github.com/en/actions/learn-github-actions
[license_badge]: https://img.shields.io/badge/license-MIT-blue.svg
[license_link]: https://opensource.org/licenses/MIT
[logo_black]: https://raw.githubusercontent.com/VGVentures/very_good_brand/main/styles/README/vgv_logo_black.png#gh-light-mode-only
[logo_white]: https://raw.githubusercontent.com/VGVentures/very_good_brand/main/styles/README/vgv_logo_white.png#gh-dark-mode-only
[mason_link]: https://github.com/felangel/mason
[very_good_analysis_badge]: https://img.shields.io/badge/style-very_good_analysis-B22C89.svg
[very_good_analysis_link]: https://pub.dev/packages/very_good_analysis
[very_good_cli_link]: https://pub.dev/packages/very_good_cli
[very_good_coverage_link]: https://github.com/marketplace/actions/very-good-coverage
[very_good_ventures_link]: https://verygood.ventures
[very_good_ventures_link_light]: https://verygood.ventures#gh-light-mode-only
[very_good_ventures_link_dark]: https://verygood.ventures#gh-dark-mode-only
[very_good_workflows_link]: https://github.com/VeryGoodOpenSource/very_good_workflows
