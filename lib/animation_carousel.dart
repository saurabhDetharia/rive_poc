import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class AnimationCarousel extends StatefulWidget {
  const AnimationCarousel({super.key});

  @override
  State<AnimationCarousel> createState() => _AnimationCarouselState();
}

class _AnimationCarouselState extends State<AnimationCarousel> {
  final riveAnimations = [
    const RiveCustomAnimationData(
      name: 'assets/liquid_download.riv',
    ),
    const RiveCustomAnimationData(
      name: 'assets/little_machine.riv',
      stateMachines: ['State Machine 1'],
    ),
    const RiveCustomAnimationData(
      name: 'assets/off_road_car.riv',
    ),
    const RiveCustomAnimationData(
      name: 'assets/rocket.riv',
      stateMachines: ['Button'],
      animations: ['Roll_over'],
    ),
    const RiveCustomAnimationData(
      name: 'assets/skills.riv',
      stateMachines: ['Designer\'s Test'],
    ),
    // not a pretty out of the box example
    const RiveCustomAnimationData(
      name: 'assets/light_switch.riv',
      stateMachines: ['Switch'],
    ),
    // v6.0 file,
    // 'assets/teeny_tiny.riv',
    // const RiveCustomAnimationData(name: 'assets/teeny_tiny.riv'),
  ];

  /// Current index of the carousel
  var _index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Animation Carousel'),
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          RiveAnimation.asset(
            riveAnimations[_index].name,
            animations: riveAnimations[_index].animations,
            stateMachines: riveAnimations[_index].stateMachines,
          ),
          Positioned(
            left: 0,
            child: IconButton(
              onPressed: () {
                setState(() {
                  if (_index == 0) {
                    _index = riveAnimations.length - 1;
                  } else {
                    _index -= 1;
                  }
                });
              },
              icon: const Icon(
                Icons.arrow_back,
              ),
            ),
          ),
          Positioned(
            right: 0,
            child: IconButton(
              onPressed: () {
                setState(() {
                  if (_index == riveAnimations.length - 1) {
                    _index = 0;
                  } else {
                    _index += 1;
                  }
                });
              },
              icon: const Icon(
                Icons.arrow_forward,
              ),
            ),
          )
        ],
      ),
    );
  }
}

@immutable
class RiveCustomAnimationData {
  final String name;
  final List<String> animations;
  final List<String> stateMachines;

  const RiveCustomAnimationData({
    required this.name,
    this.animations = const [],
    this.stateMachines = const [],
  });
}
