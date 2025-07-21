// Created by: V3 Code Studio
// Email: v3codestudio@gmail.com

/// A library providing a customizable alert dialog component for Flutter applications.
library v3c_alert;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Defines the type of alert dialog to display, such as success, error, info, or warning.
enum V3CAlertType { success, error, info, warning }

/// A customizable alert dialog widget for Flutter applications.
///
/// This widget displays an alert dialog with a title, description, and customizable
/// buttons based on the specified [alertType]. It supports optional callbacks for
/// button presses and customizable button text.
class V3CAlert extends StatefulWidget {
  /// The build context used to show the dialog.
  final BuildContext context;

  /// The type of alert to display, determining the icon and color scheme.
  final V3CAlertType alertType;

  /// The title text displayed at the top of the alert dialog.
  final String title;

  /// The description text displayed in the body of the alert dialog.
  final String description;

  /// The text for the OK button. If empty, the OK button is not shown.
  final String okButtonText;

  /// The text for the cancel button. If empty, defaults to "Close".
  final String cancelButtonText;

  /// Callback function invoked when the OK button is pressed.
  final VoidCallback? okOnPress;

  /// Callback function invoked when the cancel button is pressed.
  final VoidCallback? cancelOnPress;

  /// Whether the dialog can be dismissed by tapping outside of it.
  final bool barrierDismissible;

  /// Whether the dialog can be dismissed by pressing the back key.
  final bool dismissOnBackKeyPress;

  /// Creates a [V3CAlert] widget.
  ///
  /// The [context], [title], [description], and [alertType] parameters are required.
  /// The [okOnPress] and [cancelOnPress] callbacks are optional, as are [okButtonText]
  /// and [cancelButtonText]. The [barrierDismissible] and [dismissOnBackKeyPress]
  /// parameters default to `false`.
  const V3CAlert({
    super.key,
    required this.context,
    required this.title,
    required this.description,
    required this.alertType,
    this.okOnPress,
    required this.cancelOnPress,
    this.okButtonText = "",
    this.cancelButtonText = "",
    this.barrierDismissible = false,
    this.dismissOnBackKeyPress = false,
  });

  @override
  State<V3CAlert> createState() => _V3CAlertState();

  /// Displays the alert dialog in the provided [context].
  void show() {
    showDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (BuildContext context) {
        return PopScope(canPop: dismissOnBackKeyPress, child: this);
      },
    );
  }
}

class _V3CAlertState extends State<V3CAlert> {
  Color alertColorSuccess = Colors.green[700]!;
  Color alertColorError = Colors.red;
  Color alertColorWarning = Colors.yellow[800]!;
  Color alertColorInfo = Colors.blue[800]!;

  // focus node to capture keyboard events
  final FocusNode _focusNode = FocusNode();

  IconData iconCheckBox = Icons.check_circle_rounded;
  IconData iconInfo = Icons.info;
  IconData iconWarning = Icons.warning;
  IconData iconError = Icons.bug_report;

  // Method of Success
  IconData getAlertTopIcon() {
    // Set Default Color
    IconData prepareIcon = iconCheckBox;

    // Find the color based on Alert Type
    switch (widget.alertType) {
      case V3CAlertType.success:
        {
          prepareIcon = iconCheckBox;
        }
        break;
      case V3CAlertType.error:
        {
          prepareIcon = iconError;
        }
        break;
      case V3CAlertType.info:
        {
          prepareIcon = iconInfo;
        }
        break;
      case V3CAlertType.warning:
        {
          prepareIcon = iconWarning;
        }
        break;
    }
    return prepareIcon;
  }

  // Method of Success
  Color getAlertColor() {
    // Set Default Color
    Color prepareAlertColor = alertColorSuccess;

    // Find the color based on Alert Type
    switch (widget.alertType) {
      case V3CAlertType.success:
        {
          prepareAlertColor = alertColorSuccess;
        }
        break;
      case V3CAlertType.error:
        {
          prepareAlertColor = alertColorError;
        }
        break;
      case V3CAlertType.info:
        {
          prepareAlertColor = alertColorInfo;
        }
        break;
      case V3CAlertType.warning:
        {
          prepareAlertColor = alertColorWarning;
        }
        break;
    }
    return prepareAlertColor;
  }

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        FocusScope.of(context).requestFocus(_focusNode);
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    FocusScope.of(
      context,
    ).requestFocus(_focusNode); // Now called after initState
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardListener(
      focusNode: _focusNode,
      onKeyEvent: (event) {
        if (event is KeyDownEvent &&
            (event.logicalKey == LogicalKeyboardKey.enter ||
                event.logicalKey == LogicalKeyboardKey.numpadEnter)) {
          // ... // your action here
          Navigator.of(context).pop();
          widget.cancelOnPress!();
        }
      },
      child: AlertDialog(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(28),
          side: BorderSide(color: getAlertColor(), width: 2),
        ),
        titlePadding: const EdgeInsets.only(
          top: 0,
          left: 0,
          right: 0,
          bottom: 0,
        ),
        // titlePadding
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(color: getAlertColor()),
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 24,
                  right: 24,
                  top: 16,
                  bottom: 16,
                ),
                child: Column(
                  children: [
                    Icon(getAlertTopIcon(), size: 60, color: Colors.white),
                    const SizedBox(height: 8),
                    Text(
                      widget.title,
                      style: Theme.of(
                        context,
                      ).textTheme.displaySmall!.copyWith(color: Colors.white),
                      // const TextStyle(color: Colors.white
                      // alertColor.isDarkColor()
                      //     ? Colors.white
                      //     : Colors.black
                      // )
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        content: Text(
          widget.description,
          style: Theme.of(
            context,
          ).textTheme.bodyMedium!.apply(color: Colors.black),
        ),
        actions: <Widget>[
          Visibility(
            visible: widget.okButtonText.isNotEmpty,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: getAlertColor()),
              child: const Text('Ok', style: TextStyle(color: Colors.white)),
              onPressed: () async {
                // Close the alert
                Navigator.of(context).pop();
                widget.okOnPress!();
                // Close the current screen.
                // Navigator.of(context).pop();
                // Perform logout action here
              },
            ),
          ),
          Visibility(
            visible: true,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: getAlertColor()),
              child: const Text('Close', style: TextStyle(color: Colors.white)),
              onPressed: () async {
                // Close the alert
                Navigator.of(context).pop();
                widget.cancelOnPress!();
                // Close the current screen.
                // Navigator.of(context).pop();
                // Perform logout action here
              },
            ),
          ),
        ],
      ),
    );
  }
}
