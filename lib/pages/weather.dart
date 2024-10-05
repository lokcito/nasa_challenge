import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:nasa_challenge/models/day.model.dart';
import 'package:nasa_challenge/widgets/date.dart';
import 'package:nasa_challenge/widgets/day.bar.dart';
import 'package:nasa_challenge/widgets/day.slider.dart';

class WeatherScreen extends StatefulWidget {
  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  DateTime? selectedDate;
  List<DayModel> weekDates = [];
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });

      weekDates = getWeekDates(picked);
    }
  }

  _selectLocation(BuildContext context) {
    print("local");
  }

  List<DayModel> getWeekDates(DateTime date) {
    // Calcular el inicio de la semana (domingo)
    int daysToSubtract =
        date.weekday % 7; // Domingo es 0, Lunes es 1, ..., Sábado es 6
    DateTime startOfWeek = date.subtract(Duration(days: daysToSubtract));

    // Generar las fechas desde el domingo hasta el sábado
    return List.generate(
        7,
        (index) => DayModel(
            date: startOfWeek.add(Duration(days: index)),
            label: "xx",
            current: date));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Clima Actual',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          backgroundColor: const Color(0XFFF0F9FF),
        ),
        body: Container(
            color: const Color(0xFFF0F9FF),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(
                      width: 8,
                    ),
                    ElevatedButton(
                        onPressed: () => {_selectLocation(context)},
                        child: Text("Seleccione localidad")),
                    DateWidget(),
                    ElevatedButton(
                        onPressed: () => {_selectDate(context)},
                        child: Text(selectedDate == null
                            ? "Seleccione una fecha"
                            : '${DateFormat('yyyy-MM-dd').format(selectedDate!)}')),
                    SizedBox(
                      width: 8,
                    ),
                  ],
                ),
                DayBarWidget(weekDates: weekDates),
                const SizedBox(
                  height: 24,
                ),
                DaySliderWidget()
              ],
            )),
        bottomNavigationBar: BottomAppBar(
          color: Colors.white,
          shape: const CircularNotchedRectangle(),
          notchMargin: 8.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              IconButton(
                icon: const Icon(Icons.home),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.settings),
                onPressed: () {},
              ),
            ],
          ),
        ));
  }

  @override
  Widget buixld(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Selector de Fecha'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              selectedDate == null
                  ? 'No has seleccionado ninguna fecha.'
                  : 'Fecha seleccionada: ${selectedDate!.toLocal()}'
                      .split(' ')[0],
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _selectDate(context),
              child: Text('Seleccionar fecha'),
            ),
          ],
        ),
      ),
    );
  }
}



// /// The home screen
// class WeatherScreen extends StatelessWidget {
//   // DateTime selectedDate = DateTime.now();
//   /// Constructs a [WeatherScreen]
//   const WeatherScreen({super.key});

//   _selectDate(BuildContext context) async {
//     DateTime selectedDate = DateTime.now();
//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: selectedDate, // Refer step 1
//       firstDate: DateTime(2000),
//       lastDate: DateTime(2025),
//     );
//     if (picked != null && picked != selectedDate) {}
//     // setState(() {
//     //   selectedDate = picked;
//     // });
//   }

  
// }
