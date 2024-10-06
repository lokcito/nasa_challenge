// import 'dart:async';
// import 'dart:math';

// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:nasa_challenge/models/custom.marker.dart';

// class Locator {
//   late GoogleMapController mapController;
//   Position? position;
//   // Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
//   List<CustomMarker> markers = [];
//   final StreamController<Set<CustomMarker>> _streamController =
//       StreamController<Set<CustomMarker>>();
//   Stream<Set<CustomMarker>> get markerStream => _streamController.stream;

//   Future<void> _determinePosition() async {
//     bool serviceEnabled;
//     LocationPermission permission;

//     // Test if location services are enabled.
//     serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       // Location services are not enabled don't continue
//       // accessing the position and request users of the
//       // App to enable the location services.
//       return Future.error('Location services are disabled.');
//     }

//     permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//         // Permissions are denied, next time you could try
//         // requesting permissions again (this is also where
//         // Android's shouldShowRequestPermissionRationale
//         // returned true. According to Android guidelines
//         // your App should show an explanatory UI now.
//         return Future.error('Location permissions are denied');
//       }
//     }

//     if (permission == LocationPermission.deniedForever) {
//       // Permissions are denied forever, handle appropriately.
//       return Future.error(
//           'Location permissions are permanently denied, we cannot request permissions.');
//     }

//     // When we reach here, permissions are granted and we can
//     // continue accessing the position of the device.
//     //return await Geolocator.getCurrentPosition();
//     Position position = await Geolocator.getCurrentPosition();
//     this.position = position;
//     mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
//         target: LatLng(position.latitude, position.longitude), zoom: 15)));
//     markerCreate();
//     _streamController.add(markers.toSet());
//   }

//   void markerCreate() {
//     final marker = Marker(
//       markerId: MarkerId('currentLocation'),
//       position: LatLng(position!.latitude, position!.longitude),
//       icon: BitmapDescriptor.defaultMarker,
//       infoWindow: InfoWindow(title: 'Mi lugar', snippet: '$position'),
//     );
//     markers.add(CustomMarker(
//         current: marker,
//         point: null,
//         currentMarkerId: MarkerId('currentLocation'),
//         pointMarkerId: null));
//     //markers[MarkerId('place name')] = marker;
//   }

//   String generateRandomString(int length) {
//     const chars =
//         'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
//     Random random = Random();

//     return List.generate(length, (index) {
//       return chars[random.nextInt(chars.length)];
//     }).join('');
//   }

//   Future<void> onMapCreated(GoogleMapController controller) async {
//     mapController = controller;
//     _determinePosition();
//   }
// }

import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';

class Locator {
  late GoogleMapController mapController;
  String totalArea = "";
  final Polygon polygon = Polygon(
    polygonId: PolygonId('test_polygon'),
    points: [],
    strokeColor: Colors.blue,
    fillColor: Colors.blue.withOpacity(0.3),
    strokeWidth: 3,
  );

  Position? position;
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  final StreamController<Set<Marker>> _streamController =
      StreamController<Set<Marker>>();
  Stream<Set<Marker>> get markerStream => _streamController.stream;

  Future<void> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    //return await Geolocator.getCurrentPosition();
    Position position = await Geolocator.getCurrentPosition();
    this.position = position;
    mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(position.latitude, position.longitude), zoom: 15)));
    markerCreate();
    _streamController.add(markers.values.toSet());
  }

  double calculatePolygonArea(List<LatLng> points) {
    print("Número de puntos: ${points.length}");
    if (points.length < 3) return 0.0; // No se puede formar un polígono

    double area = 0.0;
    int n = points.length;

    for (int i = 0; i < n; i++) {
      int j = (i + 1) % n; // Vértice siguiente
      area += points[i].latitude * points[j].longitude;
      area -= points[j].latitude * points[i].longitude;
    }

    area = area.abs() / 2.0;

    // Convertir de grados cuadrados a metros cuadrados
    // Supongamos que tomamos la latitud media de los puntos
    double averageLatitude =
        points.map((p) => p.latitude).reduce((a, b) => a + b) / n;
    double metersPerDegreeLongitude = 111320 * cos(averageLatitude * pi / 180);
    double metersPerDegreeLatitude = 111320; // 1 grado de latitud en metros

    // Área en metros cuadrados
    double areaInSquareMeters =
        area * metersPerDegreeLongitude * metersPerDegreeLatitude;

    // Redondear y formatear el área
    String formattedArea = NumberFormat('#,##0.00').format(areaInSquareMeters);
    print('Área del polígono: $formattedArea metros cuadrados');
    totalArea = formattedArea;
    return areaInSquareMeters;
  }

  void markerCreate() {
    final marker = Marker(
      markerId: MarkerId('currentLocation'),
      position: LatLng(position!.latitude, position!.longitude),
      icon: BitmapDescriptor.defaultMarker,
      infoWindow: InfoWindow(title: 'My location', snippet: '$position'),
    );
    markers[MarkerId('place name')] = marker;
  }

  Future<void> askCreate(BuildContext context, LatLng xposition) async {
    String randomx = generateRandomString(12);

    polygon.points.add(xposition); // Punto 1

    calculatePolygonArea(polygon.points);

    BitmapDescriptor customIcon = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(size: Size(24, 24)), // Tamaño del icono
      'assets/images/icon_circulo.png', // Ruta del icono
    );

    final Marker marker = Marker(
      markerId: MarkerId(xposition.toString()),
      position: xposition,
      icon: customIcon, // Color del icono del marcador
      draggable: true,
      onTap: () => {_showDeleteDialog(context, '$xposition')},
    );

    markers[MarkerId(randomx)] = marker;
    _streamController.add(markers.values.toSet());

    // return "";
  }

  void _showDeleteDialog(BuildContext context, String markerId) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Delete Marker $markerId'),
          content: Text('Do you want to delete this marker?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                Navigator.of(context).pop(false); // Retorna false al cancelar
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                //_deleteMarker(markerId);
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Delete'),
            ),
          ],
        );
      },
    );
  }
//   String askCreate(LatLng xposition) {
//     String randomx = generateRandomString(12);
//     final marker = Marker(
//       markerId: MarkerId(randomx),
//       position: LatLng(xposition!.latitude, xposition!.longitude),
//       icon: BitmapDescriptor.defaultMarker,
//       infoWindow: InfoWindow(title: 'Punto', snippet: '$position'),
//     );
//     //markers[MarkerId(randomx)] = marker;
//     //_streamController.add(markers.values.toSet());

//     markers.add(CustomMarker(
//         current: null,
//         point: marker,
//         currentMarkerId: null,
//         pointMarkerId: MarkerId(randomx)));
//     _streamController.add(markers.toSet());
//     return randomx;
//   }

  String generateRandomString(int length) {
    const chars =
        'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    Random random = Random();

    return List.generate(length, (index) {
      return chars[random.nextInt(chars.length)];
    }).join('');
  }

  Future<void> onMapCreated(GoogleMapController controller) async {
    mapController = controller;
    _determinePosition();
  }
}
