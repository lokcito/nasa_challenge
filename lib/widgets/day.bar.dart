import 'package:flutter/material.dart';
import 'package:nasa_challenge/widgets/day.dart';

/// The home screen
class DayBarWidget extends StatelessWidget {
  /// Constructs a [PredictionScreen]
  const DayBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Color(0XFF896BE8), // Color del borde
            width: 2.0, // Ancho del borde
          ),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: DayWidget(),
          ),
          Expanded(child: DayWidget()),
          Expanded(child: DayWidget()),
          Expanded(child: DayWidget()),
          Expanded(child: DayWidget()),
          Expanded(child: DayWidget()),
          Expanded(child: DayWidget()),
        ],
      ),
    );
  }
}
