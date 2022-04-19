import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:parkline/bloc/mapa/mapa_bloc.dart';
import 'package:parkline/bloc/mi_ubicacion/mi_ubicacion_bloc.dart';

import 'package:parkline/widgets/widgets.dart';

class MapaPageRutaDir extends StatefulWidget {
  final double latitude, longitude;

  MapaPageRutaDir({
    Key key,
    this.latitude,
    this.longitude,
  }) : super(key: key);

  @override
  _MapaPageRutaDirState createState() => _MapaPageRutaDirState();
}

class _MapaPageRutaDirState extends State<MapaPageRutaDir> {
  @override
  void initState() {
    context.bloc<MiUbicacionBloc>().iniciarSeguimiento();

    super.initState();
  }

  @override
  void dispose() {
    context.bloc<MiUbicacionBloc>().cancelarSeguimiento();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          BlocBuilder<MiUbicacionBloc, MiUbicacionState>(
              //en cualquier momento que la ubicacion cambie ese bloc builder se va disparar con los nuevos datos deel state
              builder: (_, state) => crearMapa(state)),
          //MarcadorManual(),
          MarcadorManualRuta2(
              latitude: widget.latitude, longitude: widget.longitude),
          // Positioned(top: 15, child: SearchBar()),
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        /*   children: [
          BtnUbicacion(),
          BtnSeguirUbicacion(),
          BtnMiRuta(),
        ], */
      ),
    );
  }

  Widget crearMapa(MiUbicacionState state) {
    if (!state.existeUbicacion) return Center(child: Text('Ubicando...'));

    final mapaBloc = BlocProvider.of<MapaBloc>(context);
    mapaBloc.add(OnNuevaUbicacion(state.ubicacion));

    final cameraPosition =
        new CameraPosition(target: state.ubicacion, zoom: 15.0);

    //redibujar si el bloc del mapa cambia

    return BlocBuilder<MapaBloc, MapaState>(
      builder: (context, _) {
        //(context,state)
        return GoogleMap(
          initialCameraPosition: cameraPosition,
          myLocationEnabled: true,
          myLocationButtonEnabled: true,
          zoomControlsEnabled: true,
          mapToolbarEnabled: false,
          onMapCreated: mapaBloc.initMapa,
          polylines: mapaBloc.state.polylines.values.toSet(),
          markers: mapaBloc.state.markers.values.toSet(),
          onCameraMove: (cameraPosition) {
            // cameraPosition.target = LatLng central del mapa
            mapaBloc.add(OnMovioMapa(cameraPosition.target));
          },
        );
      },
    );
  }
}
