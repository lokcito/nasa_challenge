import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:nasa_challenge/models/day.model.dart';
import 'package:nasa_challenge/widgets/date.dart';
import 'package:nasa_challenge/widgets/day.bar.dart';
import 'package:nasa_challenge/widgets/day.slider.dart';
import 'dart:html' as html;
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:nasa_challenge/widgets/locator.dart';
import 'package:nasa_challenge/widgets/maps.dialog.dart';

class WeatherScreen extends StatefulWidget {
  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  DateTime? selectedDate;
  String landArea = "0.00";
  void _handleMessage(String newMessage) {
    Navigator.pop(context);

    setState(() {
      landArea = newMessage;
    });
  }

  @override
  void initState() {
    super.initState();

    setState(() {
      selectedDate = DateTime.now();
      weekDates = getWeekDates(selectedDate!);
    });
  }

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

  void _showMapDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: SizedBox(
                width: double.infinity,
                height: 400,
                child: SizedBox(
                  child: MapSample(
                    onMessageSend: _handleMessage,
                  ),
                ),
              )),
        );
      },
    );
  }

  _selectLocation(BuildContext context) {
    _showMapDialog(context);
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
          title: Container(
            padding: EdgeInsets.only(top: 10),
            alignment: Alignment.center,
            child: Image.asset(
              "images/logo.png",
              width: 200,
            ),
          ),
          backgroundColor: const Color(0XFFF0F9FF),
        ),
        body: Container(
            color: const Color(0xFFF0F9FF),
            child: SingleChildScrollView(
                child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          flex: 3,
                          child: Container(
                            padding: const EdgeInsets.only(top: 8, bottom: 8),
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black
                                      .withOpacity(0.5), // Color de la sombra
                                  spreadRadius: 2, // Radio de expansión
                                  blurRadius: 10, // Radio de difuminado
                                  offset: Offset(
                                      0, 4), // Desplazamiento de la sombra
                                ),
                              ],
                              color: const Color(
                                  0XFF896DE9), // Color de fondo del container
                              borderRadius:
                                  BorderRadius.circular(10), // Borde redondeado
                            ),
                            child: Column(
                              children: [
                                const Text(
                                  "Step 1",
                                  style: TextStyle(
                                      color: Color(0XFF2E073F),
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold),
                                ),
                                ElevatedButton(
                                    onPressed: () => {_selectLocation(context)},
                                    child: Text("Seleccione localidad")),
                                Text(
                                  '$landArea m²',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          )),
                      SizedBox(
                        width: 16,
                      ),
                      Expanded(
                          flex: 3,
                          child: Container(
                            padding: const EdgeInsets.only(top: 8, bottom: 8),
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black
                                      .withOpacity(0.5), // Color de la sombra
                                  spreadRadius: 2, // Radio de expansión
                                  blurRadius: 10, // Radio de difuminado
                                  offset: Offset(
                                      0, 4), // Desplazamiento de la sombra
                                ),
                              ],
                              color: const Color(
                                  0XFF3737c8), // Color de fondo del container
                              borderRadius:
                                  BorderRadius.circular(20), // Borde redondeado
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment
                                  .center, // Centrar horizontalmente

                              children: [
                                const Text(
                                  "Step 2",
                                  style: TextStyle(
                                      color: Color(0XFFFFFFFF),
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold),
                                ),
                                const Text(
                                  "Select the date",
                                  style: TextStyle(color: Colors.white),
                                ),
                                const Text(
                                  "you plan to grow.",
                                  style: TextStyle(color: Colors.white),
                                ),
                                ElevatedButton(
                                    onPressed: () => {_selectDate(context)},
                                    child: Text(selectedDate == null
                                        ? "Choose date"
                                        : '${DateFormat('yyyy-MM-dd').format(selectedDate!)}')),
                              ],
                            ),
                          )),
                      SizedBox(
                        width: 16,
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          flex: 3,
                          child: Container(
                            padding: const EdgeInsets.only(top: 8, bottom: 8),
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black
                                      .withOpacity(0.5), // Color de la sombra
                                  spreadRadius: 2, // Radio de expansión
                                  blurRadius: 10, // Radio de difuminado
                                  offset: Offset(
                                      0, 4), // Desplazamiento de la sombra
                                ),
                              ],
                              color: const Color(
                                  0XFF896DE9), // Color de fondo del container
                              borderRadius:
                                  BorderRadius.circular(10), // Borde redondeado
                            ),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      "Forecast according to NASA",
                                      style: TextStyle(
                                          color: Color(0XFF2E073F),
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Image.asset("images/drop.png"),
                                    const Text(
                                      "Accumulated Precipitation 2281.17 mm",
                                      style: TextStyle(
                                          color: Color(0XFF2E073F),
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Image.asset("images/sun.png"),
                                    const Text(
                                      "Average Temp: 21.0 °C - 27.0 °C",
                                      style: TextStyle(
                                          color: Color(0XFF2E073F),
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          flex: 3,
                          child: Container(
                            padding: const EdgeInsets.only(top: 8, bottom: 8),
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black
                                      .withOpacity(0.5), // Color de la sombra
                                  spreadRadius: 2, // Radio de expansión
                                  blurRadius: 10, // Radio de difuminado
                                  offset: Offset(
                                      0, 4), // Desplazamiento de la sombra
                                ),
                              ],
                              color: const Color(
                                  0XFFD91656), // Color de fondo del container
                              borderRadius:
                                  BorderRadius.circular(10), // Borde redondeado
                            ),
                            child: Column(
                              children: [
                                const Text(
                                  "Suggestions",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold),
                                ),
                                Center(
                                    child: const Text(
                                  "Under climatic projected conditions it is",
                                  style: TextStyle(
                                      color: Color(0XFFFFFFFF),
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold),
                                )),
                                Center(
                                    child: const Text(
                                  "not suggested to seed quinoa in that",
                                  style: TextStyle(
                                      color: Color(0XFFFFFFFF),
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold),
                                )),
                                Center(
                                    child: const Text(
                                  "location and season.",
                                  style: TextStyle(
                                      color: Color(0XFFFFFFFF),
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold),
                                ))
                              ],
                            ),
                          )),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(
                      width: 8,
                    ),
                    DateWidget(
                        date: selectedDate == null
                            ? DateTime.now()
                            : selectedDate!),
                    const SizedBox(
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
            ))),
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
}
