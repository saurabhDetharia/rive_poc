import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class SimpleStateMachine extends StatefulWidget {
  const SimpleStateMachine({super.key});

  @override
  State<SimpleStateMachine> createState() => _SimpleStateMachineState();
}

class _SimpleStateMachineState extends State<SimpleStateMachine> {
  SMITrigger? _bump;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Simple State Machine'),
      ),
      body: GestureDetector(
        onTap: _hitBump,
        child: Center(
          child: RiveAnimation.asset(
            'assets/vehicles.riv',
            onInit: _onRiveInit,
          ),
        ),
      ),
    );
  }

  void _onRiveInit(Artboard artboard) {
    final controller = StateMachineController.fromArtboard(
      artboard,
      'bumpy',
    );

    artboard.addController(controller!);

    _bump = controller.getTriggerInput('bump');
  }

  void _hitBump() => _bump?.fire();
}
