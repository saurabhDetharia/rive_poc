import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class LittleMachine extends StatefulWidget {
  const LittleMachine({super.key});

  @override
  State<LittleMachine> createState() => _LittleMachineState();
}

class _LittleMachineState extends State<LittleMachine> {
  Artboard? _artboard;

  // To handle trigger input
  SMITrigger? _triggerInput;

  // To listen the state change
  String stateChangeMessage = '';

  @override
  void initState() {
    super.initState();
    loadAnimation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Little Machine'),
      ),
      body: Center(
        child: _artboard == null
            ? const CircularProgressIndicator()
            : Stack(
                children: [
                  GestureDetector(
                    onTap: () => _triggerInput?.fire(),
                    child: Rive(
                      artboard: _artboard!,
                    ),
                  ),
                  Text(
                    stateChangeMessage,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  Future<void> loadAnimation() async {
    // Load animation file
    final file = await RiveFile.asset('assets/little_machine.riv');

    // Get local artboard instance
    final artboard = file.mainArtboard.instance();

    // To control the animation
    final controller = StateMachineController.fromArtboard(
      artboard,
      'State Machine 1',
      onStateChange: _onStateChanged,
    );

    if (controller != null) {
      artboard.addController(controller);

      // Listen the event triggered.
      _triggerInput = controller.getTriggerInput('Trigger 1');
    }

    setState(() {
      _artboard = artboard;
    });
  }

  /// This will be used to listen the state related changes.
  void _onStateChanged(
    String stateMachineName,
    String stateName,
  ) =>
      setState(
        () => stateChangeMessage =
            'State Changed in $stateMachineName to $stateName',
      );
}
