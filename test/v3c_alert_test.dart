import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:v3c_alert/v3c_alert.dart';

void main() {
  group('V3CAlert Tests', () {
    testWidgets('V3CAlert displays correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              return Scaffold(
                body: Center(
                  child: ElevatedButton(
                    onPressed: () {
                      V3CAlert(
                        context: context,
                        title: 'Test Alert',
                        description: 'This is a test alert',
                        alertType: V3CAlertType.success,
                        okButtonText: 'OK',
                        cancelOnPress: () {},
                      ).show();
                    },
                    child: const Text('Show Alert'),
                  ),
                ),
              );
            },
          ),
        ),
      );

      // Tap button to show dialog
      await tester.tap(find.text('Show Alert'));
      await tester.pumpAndSettle();

      // Verify the dialog content
      expect(find.text('Test Alert'), findsOneWidget);
      expect(find.text('This is a test alert'), findsOneWidget);
    });

    testWidgets('Alert shows with different types', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              return Scaffold(
                body: Center(
                  child: ElevatedButton(
                    onPressed: () {
                      V3CAlert(
                        context: context,
                        title: 'Info Alert',
                        description: 'This is an info alert',
                        alertType: V3CAlertType.info,
                        okButtonText: 'OK',
                        cancelOnPress: () {},
                      ).show();
                    },
                    child: const Text('Show Info Alert'),
                  ),
                ),
              );
            },
          ),
        ),
      );

      // Tap button to show dialog
      await tester.tap(find.text('Show Info Alert'));
      await tester.pumpAndSettle();

      // Verify the dialog content
      expect(find.text('Info Alert'), findsOneWidget);
      expect(find.text('This is an info alert'), findsOneWidget);
    });

    testWidgets('Alert shows with error type', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              return Scaffold(
                body: Center(
                  child: ElevatedButton(
                    onPressed: () {
                      V3CAlert(
                        context: context,
                        title: 'Error Alert',
                        description: 'This is an error alert',
                        alertType: V3CAlertType.error,
                        okButtonText: 'OK',
                        cancelOnPress: () {},
                      ).show();
                    },
                    child: const Text('Show Error Alert'),
                  ),
                ),
              );
            },
          ),
        ),
      );

      // Tap button to show dialog
      await tester.tap(find.text('Show Error Alert'));
      await tester.pumpAndSettle();

      // Verify the dialog content
      expect(find.text('Error Alert'), findsOneWidget);
      expect(find.text('This is an error alert'), findsOneWidget);
    });
  });
}
