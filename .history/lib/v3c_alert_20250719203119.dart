import 'package:flutter/material.dart';

/// Enum defining the types of alerts available
enum V3CAlertType { error, warning, success, info }

/// A customizable alert dialog widget for Flutter with different alert types
class V3CAlertDialog extends StatefulWidget {
  /// The title text displayed at the top of the dialog
  final String title;

  /// The description/message text displayed in the dialog body
  final String description;

  /// The type of alert (error, warning, success, info) which determines color and icon
  final V3CAlertType alertType;

  /// Optional callback function called when the cancel button is pressed
  final VoidCallback? onCancelPressed;

  /// Callback function called when the OK button is pressed
  final VoidCallback onOkPressed;

  /// Optional callback function called when the dialog is closed
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
  /// Returns the appropriate color based on alert type
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

  /// Returns the appropriate icon based on alert type
  IconData _getAlertIcon() {
    switch (widget.alertType) {
      case V3CAlertType.error:
        return Icons.error;
      case V3CAlertType.warning:
        return Icons.warning;
      case V3CAlertType.success:
        return Icons.check_circle;
      case V3CAlertType.info:
        return Icons.info;
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
          Icon(_getAlertIcon(), color: _getAlertColor(), size: 48),
          const SizedBox(height: 16),
          Text(widget.description),
        ],
      ),
      actions: [
        if (widget.onCancelPressed != null)
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
