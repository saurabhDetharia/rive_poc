import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class SahilCustomText extends StatefulWidget {
  const SahilCustomText({super.key});

  @override
  State<SahilCustomText> createState() => _SahilCustomTextState();
}

class _SahilCustomTextState extends State<SahilCustomText> {
  // SMITrigger? triggerInput;

  /// Controller for playback
  late RiveAnimationController _animationController;

  /// Is the animation currently playing?
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _animationController = OneShotAnimation(
      'Timeline 1',
      autoplay: false,
      onStart: () => setState(() => _isPlaying = true),
      onStop: () => setState(() => _isPlaying = false),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // triggerInput?.fire();
          _isPlaying ? null : _animationController.isActive = true;
        },
        child: const Icon(
          Icons.play_arrow_rounded,
        ),
      ),
      body: Center(
        child: SizedBox(
          height: 200,
          width: 200,
          child: RiveAnimation.asset(
            'assets/sahil_custom_text.riv',
            controllers: [
              _animationController,
            ],
          ),
        ),
      ),
    );
  }
}
