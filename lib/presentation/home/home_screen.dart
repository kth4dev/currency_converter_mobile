import 'package:currency_converter/core/ui/widgets/theme_toggle.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Currency Converter'),
        actions: const [ThemeToggleButton()],
      ),
      body: const Center(child: Text('Home Screen')),
    );
  }
}
