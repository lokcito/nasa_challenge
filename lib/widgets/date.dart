import 'package:flutter/material.dart';

/// The home screen
class DateWidget extends StatelessWidget {
  /// Constructs a [PredictionScreen]
  const DateWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Text("24", style: TextStyle(fontSize: 48),),
      SizedBox(width: 8,),
      Column(
        children: [Text("Miercoles"), Text("21 Septiembre")],
      )
    ]);
  }
}
