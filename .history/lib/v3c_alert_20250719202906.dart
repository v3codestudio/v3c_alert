// /// A Calculator.
// class Calculator {
//   /// Returns [value] plus 1.
//   int addOne(int value) => value + 1;
// }
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// The VVAlertDialog class defines a customizable alert dialog component.
/// It requires parameters for the build context,
/// title,
/// description, and alert type.
///
/// Optional parameters include methods to handle button presses (okOnPress and cancelOnPress),
/// as well as custom button text (okButtonText and cancelButtonText).
enum VVAlertType { success, error, info }

class V3CAlert extends StatefulWidget {
  final BuildContext context;

  // Alert Type
  final VVAlertType alertType;

  // Title and Description
  final String title;
  final String description;

  // Button Text
  final String okButtonText;
  final String cancelButtonText;

  // Callback
  final VoidCallback? okOnPress;
  final VoidCallback? cancelOnPress;

  final bool barrierDismissible;
  final bool dismissOnBackKeyPress;

  const V3CAlert({
    super.key,
    required this.context,
    required this.title,
    required this.description,
    required this.alertType,
    // On Pressed Method
    this.okOnPress,
    required this.cancelOnPress,
    // Button Text
    this.okButtonText = "",
    this.cancelButtonText = "",
    this.barrierDismissible = false,
    this.dismissOnBackKeyPress = false,
  });

  @override
  State<V3CAlert> createState() => _V3CAlertState();

  // Method to show the dialog
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
  Color alertColorInfo = Colors.yellow[800]!;

  // focus node to capture keyboard events
  final FocusNode _focusNode = FocusNode();

  IconData iconCheckBox = Icons.check_circle_rounded;
  IconData iconInfo = Icons.info;
  IconData iconError = Icons.bug_report;

  // Method of Success
  IconData getAlertTopIcon() {
    // Set Default Color
    IconData prepareIcon = iconCheckBox;

    // Find the color based on Alert Type
    switch (widget.alertType) {
      case VVAlertType.success:
        {
          prepareIcon = iconCheckBox;
        }
        break;
      case VVAlertType.error:
        {
          prepareIcon = iconError;
        }
        break;
      case VVAlertType.info:
        {
          prepareIcon = iconInfo;
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
      case VVAlertType.success:
        {
          prepareAlertColor = alertColorSuccess;
        }
        break;
      case VVAlertType.error:
        {
          prepareAlertColor = alertColorError;
        }
        break;
      case VVAlertType.info:
        {
          prepareAlertColor = alertColorInfo;
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
