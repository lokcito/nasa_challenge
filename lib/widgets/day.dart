import 'package:flutter/material.dart';

/// The home screen
class DayWidget extends StatelessWidget {
  /// Constructs a [PredictionScreen]
  const DayWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(left: 8, right: 8),
        child: Container(
          padding: EdgeInsets.only(top: 8, bottom: 8),
          decoration: BoxDecoration(
            color: Color(0XFF896DE9), // Color de fondo del container
            borderRadius: BorderRadius.circular(10), // Borde redondeado
          ),
          child: Column(
            children: [
              Text(
                "D",
                style: TextStyle(color: Colors.white),
              ),
              Text("21", style: TextStyle(color: Colors.white))
            ],
          ),
        ));
  }
}
