import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:parkline/bloc/mapa/mapa_bloc.dart';
import 'package:parkline/bloc/mi_ubicacion/mi_ubicacion_bloc.dart';

import 'package:parkline/widgets/widgets.dart';

class MapaPageCopy extends StatefulWidget {

    final String id_usuario;

  const MapaPageCopy({Key key, this.id_usuario}) : super(key: key);


  @override
  _MapaPageCopyState createState() => _MapaPageCopyState();
}

class _MapaPageCopyState extends State<MapaPageCopy> {
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
                    MarcadorManual(id_usuario: widget.id_usuario,),

        ],
      ),
      /* botonezs del aldo derecho encioma del zoom
      floatingActionButton: Column(
        //esto no lo puse
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          BtnUbicacion(),
          BtnSeguirUbicacion(),
          BtnMiRuta(),
        ],
      ),*/
    );
  }

  Widget crearMapa(MiUbicacionState state) {
    if (!state.existeUbicacion) return Center(child: Text('Ubicando...'));

    final mapaBloc = BlocProvider.of<MapaBloc>(context);
    mapaBloc.add(OnNuevaUbicacion(state.ubicacion));

    final cameraPosition =
        new CameraPosition(target: state.ubicacion, zoom: 15);

    return GoogleMap(
      initialCameraPosition: cameraPosition,
      myLocationEnabled: true,
      myLocationButtonEnabled: true,
      zoomControlsEnabled: true,
      onMapCreated: mapaBloc.initMapa,
      polylines: mapaBloc.state.polylines.values.toSet(),
      onCameraMove: (cameraPosition) {
        // cameraPosition.target = LatLng central del mapa
        mapaBloc.add(OnMovioMapa(cameraPosition.target));
      },
    );
  }
}
