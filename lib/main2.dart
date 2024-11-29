import 'package:flutter/material.dart';
import 'screens/homescreen.dart';

void main() {
  runApp(const FaithfulReader());
}

class FaithfulReader extends StatelessWidget {
  const FaithfulReader({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Faithful Reader',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF2D4356),
          background: const Color(0xFF2D4356),
        ),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}
