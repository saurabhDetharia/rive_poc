import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rive/rive.dart';

class CustomAssetsLoading extends StatefulWidget {
  const CustomAssetsLoading({super.key});

  @override
  State<CustomAssetsLoading> createState() => _CustomAssetsLoadingState();
}

class _CustomAssetsLoadingState extends State<CustomAssetsLoading> {
  // To switch between custom assets and fonts
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Custom Asset Loading',
        ),
      ),
      body: Center(
        child: Row(
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  _index -= 1;
                });
              },
              child: const Icon(Icons.arrow_back),
            ),
            Expanded(
              child: (_index % 2 == 0)
                  ? const _RiveRandomImage()
                  : const _RiveRandomText(),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  _index += 1;
                });
              },
              child: const Icon(Icons.arrow_forward),
            ),
          ],
        ),
      ),
    );
  }
}

/// This will be used to render
/// custom/random image animation.
class _RiveRandomImage extends StatefulWidget {
  const _RiveRandomImage();

  @override
  State<_RiveRandomImage> createState() => _RiveRandomImageState();
}

class _RiveRandomImageState extends State<_RiveRandomImage> {
  // Random asset file to load
  RiveFile? _riveImageSampleFile;

  @override
  void initState() {
    super.initState();
    _loadAnimation();
  }

  @override
  Widget build(BuildContext context) {
    if (_riveImageSampleFile == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return Stack(
      children: [
        RiveAnimation.direct(
          _riveImageSampleFile!,
          stateMachines: const ['State Machine 1'],
        ),
        const Positioned(
          child: Padding(
            padding: EdgeInsets.all(
              8.0,
            ),
            child: Text(
              'This example loads a random image dynamically '
              'and asynchronously.\n\nHover to zoom.',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }

  /// To load assets and listen loading assets
  Future<void> _loadAnimation() async {
    final animationFile = await RiveFile.asset(
      'assets/image_out_of_band.riv',
      assetLoader: CallbackAssetLoader(
        (asset, bytes) async {
          if (asset is ImageAsset && bytes == null) {
            final res = await http.get(
              Uri.parse('https://picsum.photos/500/500'),
            );
            await asset.decode(
              Uint8List.view(
                res.bodyBytes.buffer,
              ),
            );
            return true;
          } else {
            return false;
          }
        },
      ),
    );

    setState(() {
      _riveImageSampleFile = animationFile;
    });
  }
}

/// Loads a random font as an asset.
class _RiveRandomText extends StatefulWidget {
  const _RiveRandomText();

  @override
  State<_RiveRandomText> createState() => _RiveRandomTextState();
}

class _RiveRandomTextState extends State<_RiveRandomText> {
  // Random font file to load
  RiveFile? _riveFontSampleFile;

  @override
  void initState() {
    super.initState();
    _loadAnimation();
  }

  @override
  Widget build(BuildContext context) {
    if (_riveFontSampleFile == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return Stack(
      children: [
        RiveAnimation.direct(
          _riveFontSampleFile!,
          stateMachines: const ['State Machine 1'],
        ),
        const Positioned(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'This example loads a random font dynamically '
              'and asynchronously.\n\nClick to change drink.',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ),
      ],
    );
  }

  /// This will be used to load animation.
  Future<void> _loadAnimation() async {
    // Load animation file
    final riveAnimationFile = await RiveFile.asset(
      'assets/acqua_text_out_of_band.riv',
      assetLoader: CallbackAssetLoader(
        (asset, bytes) async {
          if (asset is FontAsset && bytes == null) {
            // Random fonts which will be loaded
            final urls = [
              'https://cdn.rive.app/runtime/flutter/IndieFlower-Regular.ttf',
              'https://cdn.rive.app/runtime/flutter/comic-neue.ttf',
              'https://cdn.rive.app/runtime/flutter/inter.ttf',
              'https://cdn.rive.app/runtime/flutter/inter-tight.ttf',
              'https://cdn.rive.app/runtime/flutter/josefin-sans.ttf',
              'https://cdn.rive.app/runtime/flutter/send-flowers.ttf',
            ];

            // Download font style
            final res = await http.get(
              // pick a random url from the list of fonts
              Uri.parse(urls[Random().nextInt(urls.length)]),
            );

            // Load font style to asset
            await asset.decode(Uint8List.view(res.bodyBytes.buffer));
            return true;
          } else {
            return false; // Use default asset loading
          }
        },
      ),
    );

    setState(() {
      _riveFontSampleFile = riveAnimationFile;
    });
  }
}
