import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class LiquidDownload extends StatefulWidget {
  const LiquidDownload({super.key});

  @override
  State<LiquidDownload> createState() => _LiquidDownloadState();
}

class _LiquidDownloadState extends State<LiquidDownload> {
  // To access the animation
  Artboard? _artboard;

  // To start the animation
  SMITrigger? _startEvent;

  // To get the progress value
  SMINumber? _progressValue;

  @override
  void initState() {
    super.initState();
    loadAnimation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Liquid Download'),
      ),
      body: _artboard == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      _startEvent!.value = true;
                    },
                    child: Rive(
                      artboard: _artboard!,
                    ),
                  ),
                ),
                Slider(
                  max: 100,
                  min: 0,
                  value: _progressValue!.value,
                  onChanged: (progress) {
                    setState(() {
                      _progressValue!.value = progress;
                    });
                  },
                )
              ],
            ),
    );
  }

  Future<void> loadAnimation() async {
    // Load the animation file.
    final animationFile = await RiveFile.asset('assets/liquid_download.riv');

    // The artboard is the root of the animation and gets drawn in the
    // Rive widget.
    final artboard = animationFile.mainArtboard.instance();

    // To control the animation, events, states and inputs
    final controller = StateMachineController.fromArtboard(
      artboard,
      'Download',
    );

    if (controller != null) {
      // Attach controller with artboard
      artboard.addController(controller);

      // Get inputs
      _startEvent = controller.getTriggerInput('Download');
      _progressValue = controller.getNumberInput('Progress');
    }

    setState(() => _artboard = artboard);
  }
}
