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

class WeatherScreen extends StatefulWidget {
  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  DateTime? selectedDate;

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
          child: SizedBox(
            width: double.infinity,
            height: 400,
            child: SizedBox(
              child: MapSample(),
            ),
          ),
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
                    DateWidget(
                      n_day: this.selectedDate == null
                          ? 0
                          : this.selectedDate!.day,
                    ),
                    ElevatedButton(
                        onPressed: () => {_selectDate(context)},
                        child: Text(selectedDate == null
                            ? "Seleccione una fecha"
                            : '${DateFormat('yyyy-MM-dd').format(selectedDate!)}')),
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
}

class MapSample extends StatefulWidget {
  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  Completer<GoogleMapController> _controller = Completer();
  final Locator locator = Locator();

  MapType _currentMapType = MapType.normal;

  static final CameraPosition _UzhNU = CameraPosition(
    target: LatLng(48.6075588, 22.2641117),
    zoom: 15,
  );

  //MapType _currentMapType = MapType.normal;

  void _addMarker(LatLng position) {
    locator.askCreate(context, position);
    setState(() {
      // markers.add(
      //   Marker(
      //     markerId: MarkerId(position.toString()),
      //     position: position,
      //     infoWindow: InfoWindow(title: 'Ubicación seleccionada'),
      //   ),
      // );
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: const Text('Seleccione una localizacion: '),
        backgroundColor: const Color(0XFF896DE9),
      ),
      body: Stack(
        children: [
          StreamBuilder<Set<Marker>>(
              stream: locator.markerStream,
              builder: (context, snapshot) {
                return GoogleMap(
                  mapType: _currentMapType,
                  onTap: _addMarker,
                  initialCameraPosition: _UzhNU,
                  onMapCreated: (GoogleMapController e) {
                    locator.onMapCreated(e);
                  },
                  markers: snapshot.data ?? {},
                  polygons: {locator.polygon},
                );
              }),
          Padding(
            padding: EdgeInsets.all(18),
            child: Align(
                alignment: Alignment.topRight,
                child: Container(
                  child: Column(
                    children: [
                      FloatingActionButton(
                        onPressed: () => {},
                        materialTapTargetSize: MaterialTapTargetSize.padded,
                        backgroundColor: Colors.purple,
                        child: Text("Analizar"),
                      ),
                      Container(
                        width: 192,
                        color: Colors.white,
                        child: Text("Area: ${locator.totalArea} metros"),
                      ),
                    ],
                  ),
                )),
          ),
          /*Padding(
            padding: EdgeInsets.all(18),
            child: Align(
              alignment: Alignment.topRight,
              child: FloatingActionButton(
                onPressed: _onMapType,
                materialTapTargetSize: MaterialTapTargetSize.padded,
                backgroundColor: Colors.purple,
                child: Icon(Icons.map, size: 36),
              ),
            ),
          ),*/
        ],
      ),
    );
  }
}
