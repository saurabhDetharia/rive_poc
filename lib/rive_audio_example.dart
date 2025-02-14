import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class RiveAudioExample extends StatefulWidget {
  const RiveAudioExample({super.key});

  @override
  State<RiveAudioExample> createState() => _RiveAudioExampleState();
}

class _RiveAudioExampleState extends State<RiveAudioExample> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF000000),
      appBar: AppBar(
        title: const Text('Audio Example'),
      ),
      body: const Center(
        child: RiveAnimation.asset(
          'assets/lip-sync.riv',
          artboard: 'Lip_sync_2',
          stateMachines: ['State Machine 1'],
        ),
      ),
    );
  }
}
