import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class ArtBoardNestedInputs extends StatefulWidget {
  const ArtBoardNestedInputs({super.key});

  @override
  State<ArtBoardNestedInputs> createState() => _ArtBoardNestedInputsState();
}

class _ArtBoardNestedInputsState extends State<ArtBoardNestedInputs> {
  // To access the artboard
  Artboard? _artboard;

  // To access/provide the input from/to artboard
  SMIBool? _circleOuterState;
  SMIBool? _circleInnerState;

  @override
  void initState() {
    super.initState();
    loadAnimation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nested Inputs'),
      ),
      body: _artboard == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Stack(
              children: [
                Positioned.fill(
                  child: Rive(
                    artboard: _artboard!,
                  ),
                ),
                Positioned.fill(
                  bottom: 32,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          if (_circleOuterState == null) return;
                          _circleOuterState!.value = !_circleOuterState!.value;
                        },
                        child: const Text('Outer Circle'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (_circleInnerState == null) return;
                          _circleInnerState!.value = !_circleInnerState!.value;
                        },
                        child: const Text('Inner Circle'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }

  Future<void> loadAnimation() async {
    // Load the animation file
    final animationFile = await RiveFile.asset(
      'assets/runtime_nested_inputs.riv',
    );

    // The artboard is the root of the animation and gets drawn in the
    // Rive widget.
    final artboard = animationFile.artboardByName('MainArtboard')!.instance();

    // Get the controller for the state machine from the artboard.
    final controller = StateMachineController.fromArtboard(
      artboard,
      'MainStateMachine',
    );

    // Get the nested input CircleOuterState in the nested artboard CircleOut
    _circleOuterState = artboard.getBoolInput(
      'CircleOuterState',
      'CircleOuter',
    );

    // Get the nested input CircleInnerState at the nested artboard path
    // -> CircleOuter
    //    -> CircleInner
    _circleInnerState = artboard.getBoolInput(
      'CircleInnerState',
      'CircleOuter/CircleInner',
    );

    if (controller != null) {
      // Add controller to artboard.
      artboard.addController(controller);
    }

    setState(() => _artboard = artboard);
  }
}
