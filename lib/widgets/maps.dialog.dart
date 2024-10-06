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

class MapSample extends StatefulWidget {
  const MapSample({super.key});

  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  Completer<GoogleMapController> _controller = Completer();
  final Locator locator = Locator();
  final MapType _currentMapType = MapType.normal;
  final CameraPosition _UzhNU = const CameraPosition(
    target: LatLng(48.6075588, 22.2641117),
    zoom: 15,
  );

  void _addMarker(LatLng position) {
    locator.askCreate(context, position);
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
