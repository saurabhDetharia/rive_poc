import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class RocketExample extends StatefulWidget {
  const RocketExample({super.key});

  @override
  State<RocketExample> createState() => _RocketExampleState();
}

class _RocketExampleState extends State<RocketExample> {
  SMITrigger? _eventTrigger;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rocket Example - Custom'),
      ),
      body: GestureDetector(
        onTap: () {
          _eventTrigger?.fire();
        },
        child: RiveAnimation.asset(
          'assets/custom_rocket.riv',
          stateMachines: [
            'State Machine 1',
          ],
          animations: [
            'init',
          ],
          onInit: _onRiveInit,
        ),
      ),
    );
  }

  void _onRiveInit(Artboard artboard) {
    final controller = StateMachineController.fromArtboard(
      artboard,
      'State Machine 1',
    );

    if (controller != null) {
      artboard.addController(controller);

      _eventTrigger = controller.getTriggerInput('FireUp');
    }
  }
}
