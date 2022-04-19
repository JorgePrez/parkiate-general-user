import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:parkline/utils/dimensions.dart';

List<Marker> _markers = <Marker>[];

class CustomGoogleMap {
  static var map = GoogleMap(
    initialCameraPosition: CameraPosition(
      target: LatLng(Dimensions.latitude, Dimensions.longitude),
      zoom: 17.0,
    ),
    mapType: MapType.normal,
    markers: Set<Marker>.of(_markers),
    onMapCreated: (GoogleMapController controller) {
      //_controller.complete(controller);
    },
  );
}
