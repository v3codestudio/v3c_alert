import 'package:flutter/material.dart';
import 'package:v3c_alert/v3c_alert.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'V3C Alert Demo',
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      home: const V3CAlertDemoPage(),
    );
  }
}

class V3CAlertDemoPage extends StatefulWidget {
  const V3CAlertDemoPage({super.key});

  @override
  State<V3CAlertDemoPage> createState() => _V3CAlertDemoPageState();
}

class _V3CAlertDemoPageState extends State<V3CAlertDemoPage> {
  String _lastAction = 'None';

  void _showSuccessAlert() {
    V3CAlert(
      context: context,
      title: 'Success!',
      description: 'Your operation has been completed successfully.',
      alertType: V3CAlertType.success,
      okOnPress: () {
        setState(() {
          _lastAction = 'Success alert - OK pressed';
        });
      },
      cancelOnPress: () {
        setState(() {
          _lastAction = 'Success alert - Cancelled';
        });
      },
    ).show();
  }

  void _showErrorAlert() {
    V3CAlert(
      context: context,
      title: 'Error!',
      description: 'An error occurred while processing your request. Please try again.',
      alertType: V3CAlertType.error,
      okOnPress: () {
        setState(() {
          _lastAction = 'Error alert - OK pressed';
        });
      },
      cancelOnPress: () {
        setState(() {
          _lastAction = 'Error alert - Cancelled';
        });
      },
    ).show();
  }

  void _showWarningAlert() {
    V3CAlert(
      context: context,
      title: 'Warning!',
      description: 'This action cannot be undone. Are you sure you want to continue?',
      alertType: V3CAlertType.info, // Use info since warning doesn't exist
      okOnPress: () {
        setState(() {
          _lastAction = 'Warning alert - Confirmed';
        });
      },
      cancelOnPress: () {
        setState(() {
          _lastAction = 'Warning alert - Cancelled';
        });
      },
    ).show();
  }

  void _showInfoAlert() {
    V3CAlert(
      context: context,
      title: 'Information',
      description: 'This is an informational message to provide you with important details.',
      alertType: V3CAlertType.info,
      okOnPress: () {
        setState(() {
          _lastAction = 'Info alert - Acknowledged';
        });
      },
      cancelOnPress: () {
        setState(() {
          _lastAction = 'Info alert - Dismissed';
        });
      },
    ).show();
  }

  void _showCustomAlert() {
    V3CAlert(
      context: context,
      title: 'Delete File',
      description: 'Are you sure you want to delete this file? This action cannot be undone.',
      alertType: V3CAlertType.info, // Use info since warning doesn't exist
      okOnPress: () {
        setState(() {
          _lastAction = 'File deleted successfully';
        });
      },
      cancelOnPress: () {
        setState(() {
          _lastAction = 'Delete operation cancelled';
        });
      },
    ).show();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('V3C Alert Package Demo'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'V3C Alert Demo',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            const Text(
              'Tap any button below to see different alert types in action:',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 32),

            // Success Alert Button
            ElevatedButton.icon(
              onPressed: _showSuccessAlert,
              icon: const Icon(Icons.check_circle, color: Colors.green),
              label: const Text('Show Success Alert'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(16),
              ),
            ),
            const SizedBox(height: 12),

            // Error Alert Button
            ElevatedButton.icon(
              onPressed: _showErrorAlert,
              icon: const Icon(Icons.error, color: Colors.red),
              label: const Text('Show Error Alert'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(16),
              ),
            ),
            const SizedBox(height: 12),

            // Warning Alert Button
            ElevatedButton.icon(
              onPressed: _showWarningAlert,
              icon: const Icon(Icons.warning, color: Colors.orange),
              label: const Text('Show Warning Alert'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(16),
              ),
            ),
            const SizedBox(height: 12),

            // Info Alert Button
            ElevatedButton.icon(
              onPressed: _showInfoAlert,
              icon: const Icon(Icons.info, color: Colors.blue),
              label: const Text('Show Info Alert'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(16),
              ),
            ),
            const SizedBox(height: 12),

            // Custom Scenario Button
            ElevatedButton.icon(
              onPressed: _showCustomAlert,
              icon: const Icon(Icons.delete, color: Colors.redAccent),
              label: const Text('Show Custom Scenario'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(16),
              ),
            ),

            const SizedBox(height: 32),

            // Status Display
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey[300]!),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Last Action:',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 4),
                  Text(_lastAction, style: const TextStyle(fontSize: 14)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
