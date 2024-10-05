import 'package:flutter/material.dart';
import 'package:nasa_challenge/widgets/day.dart';
import 'package:nasa_challenge/widgets/weather.card.dart';

/// The home screen
class DaySliderWidget extends StatelessWidget {
  /// Constructs a [PredictionScreen]
  const DaySliderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Container(),
          ),
          Expanded(
            flex: 3,
            child: WeatherCardWidget(),
          ),
          Expanded(flex: 3, child: Container())
        ],
      ),
    );
  }
}
