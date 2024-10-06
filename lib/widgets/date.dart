import 'package:flutter/material.dart';

/// The home screen
class DateWidget extends StatelessWidget {
  final DateTime date;

  const DateWidget({super.key, required this.date});

  @override
  Widget build(BuildContext context) {
    const List<String> diasDeLaSemana = [
      'domingo', // 0
      'lunes', // 1
      'martes', // 2
      'miércoles', // 3
      'jueves', // 4
      'viernes', // 5
      'sábado', // 6
      'domingo', // 0
    ];
    const List<String> meses = [
      'enero',
      'febrero',
      'marzo',
      'abril',
      'mayo',
      'junio',
      'julio',
      'agosto',
      'septiembre',
      'octubre',
      'noviembre',
      'diciembre'
    ];

    return Row(children: [
      Text(
        "${date.day}",
        style: const TextStyle(fontSize: 48),
      ),
      const SizedBox(
        width: 8,
      ),
      Column(
        children: [
          Text(diasDeLaSemana[date.weekday]),
          Text("${meses[date.month - 1]} ${date.year}")
        ],
      )
    ]);
  }
}
