import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rive/rive.dart';

class CustomCachedAssetLoading extends StatefulWidget {
  const CustomCachedAssetLoading({super.key});

  @override
  State<CustomCachedAssetLoading> createState() =>
      _CustomCachedAssetLoadingState();
}

class _CustomCachedAssetLoadingState extends State<CustomCachedAssetLoading> {
  /// To load images and fonts
  final _imageCache = [];
  final _fontCache = [];

  /// To check whether the data initialise
  /// and ready to load animations without wait
  bool _isReady = false;

  /// Indicates current position from the list
  int _index = 0;

  @override
  void initState() {
    super.initState();
    _updateCachedData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Custom Cached Asset Loading'),
      ),
      body: _isReady ? _getAnimationWidget() : _getLoaderWidget(),
    );
  }

  /// This will be used to load all the fonts
  /// and images prior before displaying the
  /// Rive animation widget.
  Future<void> _updateCachedData() async {
    /// To handle Future tasks in parallel.
    final futures = <Future>[];

    /// Get network images
    loadImage() async {
      final res = await http.get(Uri.parse('https://picsum.photos/500/500'));
      final body = Uint8List.view(res.bodyBytes.buffer);
      final image = await ImageAsset.parseBytes(body);
      if (image != null) {
        _imageCache.add(image);
      }
    }

    /// Get fonts from network
    loadFont(url) async {
      final res = await http.get(Uri.parse(url));
      final body = Uint8List.view(res.bodyBytes.buffer);
      final font = await FontAsset.parseBytes(body);

      if (font != null) {
        _fontCache.add(font);
      }
    }

    /// As the URL is randomly giving images,
    /// called function n-times.
    for (var i = 0; i <= 10; i++) {
      futures.add(loadImage());
    }

    /// To fetch fonts from the URL,
    /// add fonts to the futures list.
    for (var url in [
      'https://cdn.rive.app/runtime/flutter/IndieFlower-Regular.ttf',
      'https://cdn.rive.app/runtime/flutter/comic-neue.ttf',
      'https://cdn.rive.app/runtime/flutter/inter.ttf',
      'https://cdn.rive.app/runtime/flutter/inter-tight.ttf',
      'https://cdn.rive.app/runtime/flutter/josefin-sans.ttf',
      'https://cdn.rive.app/runtime/flutter/send-flowers.ttf',
    ]) {
      futures.add(loadFont(url));
    }

    /// Call all the future tasks.
    await Future.wait(futures);

    setState(() => _isReady = true);
  }

  /// To load either image or font
  void _next() {
    setState(() => _index += 1);
  }

  /// To load either image or font
  void _previous() {
    setState(() => _index -= 1);
  }

  /// To display the progress indicator while
  /// fetching the data.
  Widget _getLoaderWidget() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  /// To display the animation
  Widget _getAnimationWidget() {
    return Center(
      child: Row(
        children: [
          // Previous icon
          GestureDetector(
            onTap: _previous,
            child: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),

          // Animation view
          Expanded(
            child: _index % 2 == 0
                ? _RiveRandomCachedImage(
                    imageCache: _imageCache,
                  )
                : _RiveRandomCachedFonts(
                    fontsCache: _fontCache,
                  ),
          ),

          // Next icon
          GestureDetector(
            onTap: _next,
            child: const Icon(
              Icons.arrow_forward,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

/// To show the image animation
class _RiveRandomCachedImage extends StatefulWidget {
  const _RiveRandomCachedImage({
    required this.imageCache,
  });

  final List imageCache;

  @override
  State<_RiveRandomCachedImage> createState() => _RiveRandomCachedImageState();
}

class _RiveRandomCachedImageState extends State<_RiveRandomCachedImage> {
  // To get images
  List get _imageCache => widget.imageCache;

  // Rive animation
  RiveFile? _riveImageSampleFile;

  // A reference to the Rive image. Can be use to swap out the image at any
  // point.
  ImageAsset? _imageAsset;

  @override
  void initState() {
    super.initState();
    loadAnimation();
  }

  @override
  Widget build(BuildContext context) {
    return _riveImageSampleFile == null
        // Shows loading indicator while image is preparing
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Column(
            children: [
              // Animation file
              Expanded(
                child: RiveAnimation.direct(
                  _riveImageSampleFile!,
                  stateMachines: const ['State Machine 1'],
                ),
              ),

              // Random image button
              ElevatedButton(
                onPressed: () {
                  _imageAsset?.image = _imageCache[Random().nextInt(
                    _imageCache.length,
                  )];
                },
                child: const Text('Random Image'),
              ),
            ],
          );
  }

  Future<void> loadAnimation() async {
    final file = await RiveFile.asset(
      'assets/image_out_of_band.riv',
      assetLoader: CallbackAssetLoader(
        (asset, bytes) async {
          if (asset is ImageAsset) {
            asset.image = _imageCache[Random().nextInt(
              _imageCache.length,
            )];
            _imageAsset = asset;
            return true;
          } else {
            return false;
          }
        },
      ),
    );
    setState(() {
      _riveImageSampleFile = file;
    });
  }
}

/// To show the fonts animation
class _RiveRandomCachedFonts extends StatefulWidget {
  const _RiveRandomCachedFonts({
    required this.fontsCache,
  });

  final List fontsCache;

  @override
  State<_RiveRandomCachedFonts> createState() => _RiveRandomCachedFontsState();
}

class _RiveRandomCachedFontsState extends State<_RiveRandomCachedFonts> {
  // To get images
  List get _fontsCache => widget.fontsCache;

  // Rive animation
  RiveFile? _riveFontSampleFile;

  // A reference to the Rive image. Can be use to swap out the image at any
  // point.
  final List<FontAsset?> _fontsAssets = [];

  @override
  void initState() {
    super.initState();
    loadAnimation();
  }

  @override
  Widget build(BuildContext context) {
    return _riveFontSampleFile == null
        // Loading view while fonts are preparing
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Column(
            children: [
              // Animation view
              Expanded(
                child: RiveAnimation.direct(
                  _riveFontSampleFile!,
                  stateMachines: const ['State Machine 1'],
                ),
              ),

              // Random button
              ElevatedButton(
                onPressed: () {
                  for (var element in _fontsAssets) {
                    element?.font = _fontsCache[Random().nextInt(
                      _fontsCache.length,
                    )];
                  }
                },
                child: const Text('Random font'),
              ),
            ],
          );
  }

  Future<void> loadAnimation() async {
    final fontsFile = await RiveFile.asset(
      'assets/acqua_text_out_of_band.riv',
      assetLoader: CallbackAssetLoader(
        (asset, bytes) async {
          if (asset is FontAsset) {
            asset.font = _fontsCache[Random().nextInt(
              _fontsCache.length,
            )];
            _fontsAssets.add(asset);
            return true;
          } else {
            return false;
          }
        },
      ),
    );

    setState(() {
      _riveFontSampleFile = fontsFile;
    });
  }
}
