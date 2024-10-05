import 'package:flutter/material.dart';

/// The home screen
class WeatherCardWidget extends StatelessWidget {
  /// Constructs a [PredictionScreen]
  const WeatherCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 8, bottom: 8),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0XFF5925DC), Color(0XFF6636df)],
          stops: [0.5, 0.5], // 50% para cada color
        ),
        color: Color(0XFF896DE9), // Color de fondo del container
        borderRadius: BorderRadius.circular(20), // Borde redondeado
      ),
      child: Column(
        children: [
          Text(
            "190",
            style: TextStyle(color: Colors.white),
          ),
          Text(
            "Soleados",
            style: TextStyle(color: Colors.white),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Max 12",
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(
                width: 24,
              ),
              Text(
                "Min 23",
                style: TextStyle(color: Colors.white),
              )
            ],
          )
        ],
      ),
    );
  }
}
