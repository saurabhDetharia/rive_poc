import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class BasicText extends StatelessWidget {
  const BasicText({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Basic Text'),
      ),
      body: const Center(
        child: RiveAnimation.asset(
          'assets/text_flutter.riv',
        ),
      ),
    );
  }
}
