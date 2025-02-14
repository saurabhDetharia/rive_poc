import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:url_launcher/url_launcher.dart';

class EventOpenUrlButton extends StatefulWidget {
  const EventOpenUrlButton({super.key});

  @override
  State<EventOpenUrlButton> createState() => _EventOpenUrlButtonState();
}

class _EventOpenUrlButtonState extends State<EventOpenUrlButton> {
  late StateMachineController _controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Event Open URL'),
      ),
      body: RiveAnimation.asset(
        'assets/url_event_button.riv',
        onInit: _onRiveInit,
      ),
    );
  }

  void _onRiveInit(Artboard artboard) {
    // Create controller instance
    _controller = StateMachineController.fromArtboard(
      artboard,
      'button',
    )!;

    // Assign controller to artboard
    artboard.addController(_controller);

    _controller.addEventListener(_onRiveEvent);
  }

  /// This will be called when any event occurs
  void _onRiveEvent(RiveEvent event) {
    if (event is RiveOpenURLEvent) {
      try {
        final url = Uri.parse(event.url);
        launchUrl(url);
      } on Exception catch (e) {
        debugPrint(e.toString());
      }
    }
  }

  @override
  void dispose() {
    _controller.removeEventListener(_onRiveEvent);
    _controller.dispose();
    super.dispose();
  }
}
