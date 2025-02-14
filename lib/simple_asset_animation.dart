import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class SimpleAssetAnimation extends StatelessWidget {
  const SimpleAssetAnimation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Simple Animation'),
      ),
      body: const Center(
        child: RiveAnimation.asset(
          'assets/off_road_car.riv',
        ),
      ),
    );
  }
}
