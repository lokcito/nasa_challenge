import 'package:google_maps_flutter/google_maps_flutter.dart';

class CustomMarker {
  Marker? current;
  MarkerId? currentMarkerId;
  Polygon? polygon;
  PolygonId? polygonId;

  // Constructor
  CustomMarker(
      {required this.current,
      required this.polygon, // Estado por defecto es false
      required this.currentMarkerId,
      required this.polygonId});
}
