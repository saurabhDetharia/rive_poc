import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class EventStarRating extends StatefulWidget {
  const EventStarRating({super.key});

  @override
  State<EventStarRating> createState() => _EventStarRatingState();
}

class _EventStarRatingState extends State<EventStarRating> {
  // To show the rating provided by user.
  double _rating = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Event Star Rating'),
      ),
      body: Stack(
        children: [
          // Rive animation - Star/Rating
          RiveAnimation.asset(
            'assets/rating_animation.riv',
            onInit: _onRiveInit,
          ),

          // Rating text
          Text(
            '$_rating',
            style: const TextStyle(color: Colors.white, fontSize: 20),
          ),
        ],
      ),
    );
  }

  void _onRiveInit(Artboard artboard) {
    // To access/control the Rive animation
    // Such as, handling events, inputs.
    final controller = StateMachineController.fromArtboard(
      artboard,
      'State Machine 1',
    );

    if (controller != null) {
      // Attach the controller to artboard
      artboard.addController(controller);

      controller.addEventListener(_animationEventListener);
    }
  }

  void _animationEventListener(RiveEvent event) {
    // Access custom properties defined on the event
    if (event.properties.containsKey('rating')) {
      // Schedule the setState for the next frame, as an event can be
      // triggered during a current frame update
      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() {
          _rating = event.properties['rating'] as double;
        });
      });
    }
  }
}
