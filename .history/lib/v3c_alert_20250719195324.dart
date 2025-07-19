// /// A Calculator.
// class Calculator {
//   /// Returns [value] plus 1.
//   int addOne(int value) => value + 1;
// }
import 'package:flutter/material.dart';

enum V3CAlertType { error, warning, success, info }

class V3CAlertDialog extends StatefulWidget {
  final String title;
  final String description;
  final V3CAlertType alertType;
  final VoidCallback? onCancelPressed;
  final VoidCallback onOkPressed;
  final VoidCallback? onDialogClosed;

  const V3CAlertDialog({
    super.key,
    required this.title,
    required this.description,
    required this.alertType,
    this.onCancelPressed,
    required this.onOkPressed,
    this.onDialogClosed,
  });

  @override
  State<V3CAlertDialog> createState() => _V3CAlertDialogState();
}

class _V3CAlertDialogState extends State<V3CAlertDialog> {
  Color _getAlertColor() {
    switch (widget.alertType) {
      case V3CAlertType.error:
        return Colors.red;
      case V3CAlertType.warning:
        return Colors.orange;
      case V3CAlertType.success:
        return Colors.green;
      case V3CAlertType.info:
        return Colors.blue;
    }
  }

  @override
  void dispose() {
    widget.onDialogClosed?.call();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.info, color: _getAlertColor(), size: 48),
          const SizedBox(height: 16),
          Text(widget.description),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            widget.onCancelPressed?.call();
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            widget.onOkPressed();
            Navigator.of(context).pop();
          },
          child: const Text('OK'),
        ),
      ],
    );
  }
}
