import 'package:flutter/material.dart';

/// The home screen
class DateWidget extends StatelessWidget {
  final DateTime date;

  const DateWidget({super.key, required this.date});

  @override
  Widget build(BuildContext context) {
    const List<String> diasDeLaSemana = [
      'Sunday', // 0
      'Monday', // 1
      'Tuesday', // 2
      'Wennesday', // 3
      'Thursday', // 4
      'Friday', // 5
      'Saturday', // 6
      'Sunday', // 0
    ];
    const List<String> meses = [
      'January',
      'Febrero',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
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
