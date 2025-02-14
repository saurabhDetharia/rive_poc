import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class PlayOneShotAnimation extends StatefulWidget {
  const PlayOneShotAnimation({super.key});

  @override
  State<PlayOneShotAnimation> createState() => _PlayOneShotAnimationState();
}

class _PlayOneShotAnimationState extends State<PlayOneShotAnimation> {
  /// Controller for playback
  late RiveAnimationController _animationController;

  /// Is the animation currently playing?
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _animationController = OneShotAnimation(
      'bounce',
      autoplay: false,
      onStart: () => setState(() => _isPlaying = true),
      onStop: () => setState(() => _isPlaying = false),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('One-Shot Example'),
      ),
      body: Center(
        child: RiveAnimation.asset(
          'assets/vehicles.riv',
          animations: const [
            'idle',
            /*'curves'*/
          ],
          controllers: [
            _animationController,
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _isPlaying ? null : _animationController.isActive = true;
        },
        child: const Icon(Icons.arrow_circle_up_rounded),
      ),
    );
  }
}
