import 'package:flutter/material.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:smart_home_app/presentation%20/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize RevenueCat with your API key
  // ignore: deprecated_member_use
  await Purchases.setDebugLogsEnabled(true);
  // ignore: deprecated_member_use
  await Purchases.setup("sk_xEhbcuUbghYmVVZaegEUCJxRfEjTX");

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Homepage(
        body: Center(
          child: Text('Hello World!'),
        ),
      ),
    );
  }
}
