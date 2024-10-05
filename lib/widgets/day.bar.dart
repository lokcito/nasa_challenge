import 'package:flutter/material.dart';
import 'package:nasa_challenge/models/day.model.dart';
import 'package:nasa_challenge/widgets/day.dart';

/// The home screen
class DayBarWidget extends StatelessWidget {
  /// Constructs a [PredictionScreen]
  final List<DayModel> weekDates;

  const DayBarWidget({Key? key, required this.weekDates // Valor por defecto
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 8),
      decoration: const BoxDecoration(
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
            child: DayWidget(
              active: weekDates.isNotEmpty ? weekDates[0].isCurrent() : false,
              short_day: "D",
              n_day: weekDates.isNotEmpty ? weekDates[0].date.day : 0,
            ),
          ),
          Expanded(
            child: DayWidget(
              short_day: "L",
              active: weekDates.isNotEmpty ? weekDates[1].isCurrent() : false,
              n_day: weekDates.isNotEmpty && weekDates.length > 1
                  ? weekDates[1].date.day
                  : 0,
            ),
          ),
          Expanded(
            child: DayWidget(
              short_day: "M",
              active: weekDates.isNotEmpty ? weekDates[2].isCurrent() : false,
              n_day: weekDates.isNotEmpty && weekDates.length > 2
                  ? weekDates[2].date.day
                  : 0,
            ),
          ),
          Expanded(
            child: DayWidget(
              short_day: "Mi",
              active: weekDates.isNotEmpty ? weekDates[3].isCurrent() : false,
              n_day: weekDates.isNotEmpty && weekDates.length > 3
                  ? weekDates[3].date.day
                  : 0,
            ),
          ),
          Expanded(
            child: DayWidget(
              short_day: "J",
              active: weekDates.isNotEmpty ? weekDates[4].isCurrent() : false,
              n_day: weekDates.isNotEmpty && weekDates.length > 4
                  ? weekDates[4].date.day
                  : 0,
            ),
          ),
          Expanded(
            child: DayWidget(
              short_day: "V",
              active: weekDates.isNotEmpty ? weekDates[5].isCurrent() : false,
              n_day: weekDates.isNotEmpty && weekDates.length > 5
                  ? weekDates[5].date.day
                  : 0,
            ),
          ),
          Expanded(
            child: DayWidget(
              short_day: "S",
              active: weekDates.isNotEmpty ? weekDates[6].isCurrent() : false,
              n_day: weekDates.isNotEmpty && weekDates.length > 6
                  ? weekDates[6].date.day
                  : 0,
            ),
          ),
        ],
      ),
    );
  }
}
