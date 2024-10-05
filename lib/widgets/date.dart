import 'package:flutter/material.dart';

/// The home screen
class DateWidget extends StatelessWidget {
  final int n_day;

  const DateWidget({Key? key, required this.n_day}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Text(
        "${this.n_day}",
        style: TextStyle(fontSize: 48),
      ),
      SizedBox(
        width: 8,
      ),
      Column(
        children: [Text("Miercoles"), Text("21 Septiembre")],
      )
    ]);
  }
}
