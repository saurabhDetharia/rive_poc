import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class ExampleStateMachine extends StatefulWidget {
  const ExampleStateMachine({super.key});

  @override
  State<ExampleStateMachine> createState() => _ExampleStateMachineState();
}

class _ExampleStateMachineState extends State<ExampleStateMachine> {
  Artboard? _artboard;
  SMIBool? _pressInput;

  @override
  void initState() {
    super.initState();
    loadAnimation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Button State Machine'),
      ),
      body: Center(
        child: _artboard == null
            ? const CircularProgressIndicator()
            : GestureDetector(
                onTapDown: (details) => _pressInput?.value = true,
                onTapUp: (details) => _pressInput?.value = false,
                onTapCancel: () => _pressInput?.value = false,
                child: Rive(
                  artboard: _artboard!,
                ),
              ),
      ),
    );
  }

  Future<void> loadAnimation() async {
    // Load rive animation file
    final riveFile = await RiveFile.asset(
      'assets/rocket.riv',
    );

    // Get local artboard instance
    final ab = riveFile.mainArtboard.instance();

    // Access animation controller from artboard
    final controller = StateMachineController.fromArtboard(
      ab,
      'Button',
    );

    if (controller != null) {
      // Assign animation controller
      ab.addController(controller);

      // Get bool input for `Press` event.
      _pressInput = controller.getBoolInput('Press');
    }
    setState(() {
      _artboard = ab;
    });
  }
}
