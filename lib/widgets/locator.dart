import 'dart:async';
import 'dart:math';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:nasa_challenge/models/custom.marker.dart';

class Locator {
  late GoogleMapController mapController;
  Position? position;
  // Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  List<CustomMarker> markers = [];
  final StreamController<Set<CustomMarker>> _streamController =
      StreamController<Set<CustomMarker>>();
  Stream<Set<CustomMarker>> get markerStream => _streamController.stream;

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
    _streamController.add(markers.toSet());
  }

  void markerCreate() {
    final marker = Marker(
      markerId: MarkerId('currentLocation'),
      position: LatLng(position!.latitude, position!.longitude),
      icon: BitmapDescriptor.defaultMarker,
      infoWindow: InfoWindow(title: 'Mi lugar', snippet: '$position'),
    );
    markers.add(CustomMarker(
        current: marker,
        point: null,
        currentMarkerId: MarkerId('currentLocation'),
        pointMarkerId: null));
    //markers[MarkerId('place name')] = marker;
  }

  String generateRandomString(int length) {
    const chars =
        'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    Random random = Random();

    return List.generate(length, (index) {
      return chars[random.nextInt(chars.length)];
    }).join('');
  }

  String askCreate(LatLng xposition) {
    String randomx = generateRandomString(12);
    final marker = Marker(
      markerId: MarkerId(randomx),
      position: LatLng(xposition!.latitude, xposition!.longitude),
      icon: BitmapDescriptor.defaultMarker,
      infoWindow: InfoWindow(title: 'Punto', snippet: '$position'),
    );
    //markers[MarkerId(randomx)] = marker;
    //_streamController.add(markers.values.toSet());

    markers.add(CustomMarker(
        current: null,
        point: marker,
        currentMarkerId: null,
        pointMarkerId: MarkerId(randomx)));
    _streamController.add(markers.toSet());
    return randomx;
  }

  Future<void> onMapCreated(GoogleMapController controller) async {
    mapController = controller;
    _determinePosition();
  }
}
