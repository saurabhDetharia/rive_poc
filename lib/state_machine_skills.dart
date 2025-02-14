import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class StateMachineSkills extends StatefulWidget {
  const StateMachineSkills({super.key});

  @override
  State<StateMachineSkills> createState() => _StateMachineSkillsState();
}

class _StateMachineSkillsState extends State<StateMachineSkills> {
  Artboard? artboard;

  SMINumber? _levelInput;

  @override
  void initState() {
    super.initState();
    loadAnimation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Skills Machine'),
      ),
      body: Center(
        child: artboard == null
            ? const CircularProgressIndicator()
            : GestureDetector(
                onTap: () {
                  if (_levelInput?.value == 2) {
                    _levelInput?.value = 0;
                  } else {
                    _levelInput?.value++;
                  }
                },
                child: Rive(
                  artboard: artboard!,
                ),
              ),
      ),
    );
  }

  Future<void> loadAnimation() async {
    // Create a local artboard instance
    final animationFile = await RiveFile.asset('assets/skills.riv');

    // The artboard is the root of the animation and gets drawn in the
    // Rive widget.
    final ab = animationFile.mainArtboard.instance();

    // Create controller
    final controller = StateMachineController.fromArtboard(
      ab,
      'Designer\'s Test',
    );

    if (controller != null) {
      // Assign controller to artboard.
      ab.addController(controller);

      // To access the `Level` param.
      _levelInput = controller.getNumberInput('Level');
    }

    setState(() {
      artboard = ab;
    });
  }
}
