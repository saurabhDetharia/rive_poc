import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class SpeedyAnimation extends StatelessWidget {
  const SpeedyAnimation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Custom Controller - Speed'),
      ),
      body: Center(
        child: RiveAnimation.asset(
          'assets/vehicles.riv',
          animations: const [
            'idle',
          ],
          controllers: [
            SpeedController(
              'curves',
              speedMultiplier: 3,
            ),
          ],
        ),
      ),
    );
  }
}

class SpeedController extends SimpleAnimation {
  SpeedController(
    super.animationName, {
    super.mix,
    this.speedMultiplier = 1,
  });

  final double speedMultiplier;

  @override
  void apply(RuntimeArtboard artboard, double elapsedSeconds) {
    super.apply(artboard, elapsedSeconds);
    if (instance == null || !instance!.keepGoing) {
      isActive = false;
    }
    instance!
      ..animation.apply(instance!.time, coreContext: artboard, mix: mix)
      ..advance(elapsedSeconds * speedMultiplier);
  }
}
