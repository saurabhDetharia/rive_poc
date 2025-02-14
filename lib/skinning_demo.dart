import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class SkinningDemo extends StatefulWidget {
  const SkinningDemo({super.key});

  @override
  State<SkinningDemo> createState() => _SkinningDemoState();
}

class _SkinningDemoState extends State<SkinningDemo> {
  /// To handle the event trigger.
  SMITrigger? _skinInput;

  /// Available skins
  static const _skinMapping = {
    "Skin_0": "Plain",
    "Skin_1": "Summer",
    "Skin_2": "Elvis",
    "Skin_3": "Superhero",
    "Skin_4": "Astronaut"
  };

  /// The current selected state/skin
  String _currentSkin = 'Plain';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Skinning Demo'),
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Positioned.fill(
            child: GestureDetector(
              onTap: _swapSkin,
              child: Center(
                child: RiveAnimation.asset(
                  'assets/skins_demo.riv',
                  onInit: _onRiveInit,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 50,
            child: Text(
              _currentSkin,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// This will be called once the rive animation
  /// will be initialised. It is responsible to
  /// create controller and listen state changes.
  void _onRiveInit(Artboard artboard) {
    // Create controller instance.
    final controller = StateMachineController.fromArtboard(
      artboard,
      'Motion',
      onStateChange: _onStateChange,
    );

    // Assign controller to artboard
    artboard.addController(controller!);

    // Listen input/events
    _skinInput = controller.getTriggerInput('Skin');
  }

  /// This will be called when the rive animation
  /// changes state.
  void _onStateChange(
    String stateMachineName,
    String stateName,
  ) {
    if (stateName.contains('Skin_')) {
      setState(() {
        _currentSkin = _skinMapping[stateName] ?? 'Plain';
      });
    }
  }

  /// This will be used to swap the skin.
  void _swapSkin() {
    _skinInput?.fire();
  }
}
