import 'package:flutter/material.dart';

/// The home screen
class DayWidget extends StatelessWidget {
  /// Constructs a [PredictionScreen]
  final String short_day;
  final int n_day;
  final bool active;

  const DayWidget(
      {Key? key,
      required this.short_day,
      required this.n_day, // Valor por defecto
      required this.active})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(left: 8, right: 8),
        child: Container(
          padding: const EdgeInsets.only(top: 8, bottom: 8),
          decoration: BoxDecoration(
            color: this.active
                ? Color(0XFF896DE9)
                : Color(0XFFFEFEFE), // Color de fondo del container
            borderRadius: BorderRadius.circular(10), // Borde redondeado
          ),
          child: Column(
            children: [
              Text(
                this.short_day,
                style: this.active
                    ? TextStyle(color: Colors.white)
                    : TextStyle(color: Colors.black),
              ),
              Text('${this.n_day}',
                  style: this.active
                      ? TextStyle(color: Colors.white)
                      : TextStyle(color: Colors.black))
            ],
          ),
        ));
  }
}
