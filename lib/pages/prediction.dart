import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// The home screen
class PredictionScreen extends StatelessWidget {
  /// Constructs a [PredictionScreen]
  const PredictionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Prediction Screen')),
      body: Center(
        child: ElevatedButton(
          onPressed: () => context.go('/details'),
          child: const Text('Go to the Details screen'),
        ),
      ),
    );
  }
}