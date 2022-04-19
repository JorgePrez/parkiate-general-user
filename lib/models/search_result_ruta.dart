import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;
import 'package:meta/meta.dart';

class SearchResultRuta {
  //extrar valores del appi de mapbox

  final bool cancelo;
  final bool manual;
  final LatLng position;
  final String nombreDestino;
  final String descripcion;

  SearchResultRuta(
      {@required this.cancelo,
      this.manual,
      this.position,
      this.nombreDestino,
      this.descripcion});
}
