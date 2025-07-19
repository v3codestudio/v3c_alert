# V3C Alert

A customizable Flutter alert dialog widget supporting success, warning, error, and info alerts.

## Features
- Different alert types with unique styles and icons: Success, Error, Warning, and Info.
- Fully customizable with callbacks for OK and Cancel buttons.
- Animation support when displaying alerts.

## Installation

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  v3c_alert: ^1.0.0
```

Run `flutter pub get` to install the package.

## Usage
Import the package in your Dart code:

```dart
import 'package:v3c_alert/v3c_alert.dart';
```

## Example
Here's how you can use the `V3CAlertDialog` in your app:

```dart
void _showAlert(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return V3CAlertDialog(
        title: 'Alert Title',
        description: 'This is an alert description.',
        alertType: V3CAlertType.success, // Choose alert type
        onOkPressed: () {
          // Handle OK pressed
          Navigator.of(context).pop();
        },
        onCancelPressed: () {
          // Handle Cancel pressed
          Navigator.of(context).pop();
        },
      );
    },
  );
}
```

For a complete example, see the `example` project.

## Roadmap
- **Custom themes:** Allow users to customize the look and feel of alerts completely.
- **Additional animations:** Provide more built-in animations options.

## Contributing
Contributions are welcome! Please see [CONTRIBUTING.md](CONTRIBUTING.md) for details.

## License
Distributed under the MIT License. See `LICENSE` for more information.
