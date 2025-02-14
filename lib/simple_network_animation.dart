import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class SimpleNetworkAnimation extends StatelessWidget {
  const SimpleNetworkAnimation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Simple Animation'),
      ),
      body: const Center(
        child: RiveAnimation.network(
          'https://cdn.rive.app/animations/vehicles.riv',
          placeHolder: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
