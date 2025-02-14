import 'package:flutter/material.dart';
import 'package:rive_poc/rive_audio_example.dart';
import 'package:rive_poc/rive_audio_out_of_band.dart';
import 'package:rive_poc/rocket_example.dart';
import 'package:rive_poc/sahil_custom_text.dart';

import 'animation_carousel.dart';
import 'art_board_nested_inputs.dart';
import 'basic_text.dart';
import 'custom_assets_loading.dart';
import 'custom_cached_asset_loading.dart';
import 'event_open_url_button.dart';
import 'event_star_rating.dart';
import 'example_state_machine.dart';
import 'liquid_download.dart';
import 'little_machine.dart';
import 'play_one_shot_animation.dart';
import 'play_pause_animation.dart';
import 'simple_asset_animation.dart';
import 'simple_network_animation.dart';
import 'simple_state_machine.dart';
import 'skinning_demo.dart';
import 'speedy_animation.dart';
import 'state_machine_listener.dart';
import 'state_machine_skills.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rive Animation Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFF082738),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(
            0xFF082738,
          ),
        ),
        useMaterial3: false,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // Examples
  final _pages = [
    const _Page('Simple Animation - Asset', SimpleAssetAnimation()),
    const _Page('Simple Animation - Network', SimpleNetworkAnimation()),
    const _Page('Play/Pause Animation', PlayPauseAnimation()),
    const _Page('Play One-Shot Animation', PlayOneShotAnimation()),
    const _Page('Button State Machine', ExampleStateMachine()),
    const _Page('Skills Machine', StateMachineSkills()),
    const _Page('Little Machine', LittleMachine()),
    const _Page('Nested Inputs', ArtBoardNestedInputs()),
    const _Page('Liquid Download', LiquidDownload()),
    const _Page('Custom Controller - Speed', SpeedyAnimation()),
    const _Page('Simple State Machine', SimpleStateMachine()),
    const _Page('State Machine with Listener', StateMachineListener()),
    const _Page('Skinning Demo', SkinningDemo()),
    const _Page('Animation Carousel', AnimationCarousel()),
    const _Page('Basic Text', BasicText()),
    const _Page('Asset Loading', CustomAssetsLoading()),
    const _Page('Cached Asset Loading', CustomCachedAssetLoading()),
    const _Page('Event Open URL Button', EventOpenUrlButton()),
    const _Page('Event Star Rating', EventStarRating()),
    const _Page('Rive Audio', RiveAudioExample()),
    const _Page('Rive Audio [Out-of-Band]', RiveAudioOutOfBandExample()),
    const _Page('Rocket Demo', RocketExample()),
    const _Page('SahilCustomText', SahilCustomText()),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rive animation'),
      ),
      body: SafeArea(
        child: Center(
          child: ListView.separated(
            itemBuilder: (context, index) => _NavButton(page: _pages[index]),
            separatorBuilder: (context, index) => const SizedBox(
              height: 16,
            ),
            itemCount: _pages.length,
            shrinkWrap: true,
          ),
        ),
      ),
    );
  }
}

/// Class used to organize demo pages.
class _Page {
  final String name;
  final Widget page;

  const _Page(this.name, this.page);
}

/// Button to navigate to demo pages.
class _NavButton extends StatelessWidget {
  const _NavButton({required this.page});

  final _Page page;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        child: SizedBox(
          width: 250,
          child: Center(
            child: Text(
              page.name,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute<void>(
              builder: (context) => page.page,
            ),
          );
        },
      ),
    );
  }
}
