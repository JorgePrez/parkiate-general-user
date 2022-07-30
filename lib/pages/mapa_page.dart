import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:parkline/bloc/mapa/mapa_bloc.dart';
import 'package:parkline/bloc/mi_ubicacion/mi_ubicacion_bloc.dart';
import 'package:parkline/models/models.dart';
import 'package:parkline/services/services.dart';
import 'package:parkline/screens/parking_point_details_screen.dart';
import 'package:provider/provider.dart';

class MapaPage extends StatefulWidget {
  @override
  _MapaPageState createState() => _MapaPageState();
}

class _MapaPageState extends State<MapaPage> {
  final Set<Marker> markers = new Set(); //markers for google map
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
          // MarcadorManual(),
          //     MarcadorManualRuta(),
          //    Positioned(top: 15, child: SearchBar()),
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          //    BtnUbicacion(),
          //  BtnSeguirUbicacion(),
          //  BtnMiRuta(),
        ],
      ),
    );
  }

  Set<Marker> getmarkers() {
    final parqueosService = Provider.of<ParqueosService>(context);

    //markers to place on map
    setState(() {
      for (var i = 0; i < parqueosService.parqueos.length; i++) {
        Parqueos parkingPoint = parqueosService.parqueos[i];

        // crear_icono_asset(context);

        var longlatitud = double.parse(parkingPoint.latitude);
        var longlongitud = double.parse(parkingPoint.longitude);
        var arr = parkingPoint.detalles.split(' ');
        var det1;
        var det2;
        var det3;
        var det4;

        // String identificador = index;

        markers.add(Marker(
          markerId: MarkerId(parkingPoint.idParqueo),
          position: LatLng(longlatitud, longlongitud),
          infoWindow: InfoWindow(
            //popup info
            title: parkingPoint.nombreParqueo,
            snippet: parkingPoint.direccion,
          ),
          icon: BitmapDescriptor.defaultMarker, //Icon for Marker

          onTap: () {
            print('Infor window tap');
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ParkingPointDetailsScreen(
                      idpark: parkingPoint.idParqueo,
                      name: parkingPoint
                          .nombreParqueo, //        name: parkingPoint.name,
                      amount: parkingPoint.capacidad,
                      image: parkingPoint.imagenes,
                      address: parkingPoint.direccion,
                      slots: parkingPoint.capacidad,
                      mediahora: parkingPoint.mediaHora,
                      hora: parkingPoint.hora,
                      dia: parkingPoint.dia,
                      mes: parkingPoint.mes,
                      lunesEntrada: parkingPoint.lunesEntrada,
                      lunesCierre: parkingPoint.lunesCierre,
                      martesEntrada: parkingPoint.martesEntrada,
                      martesSalida: parkingPoint.martesSalida,
                      detalles: arr,
                      detalles1: det1,
                      detalles2: det2,
                      detalles3: det3,
                      detalles4: det4,
                      latitude: longlatitud,
                      longitude: longlongitud,
                      miercolesEntrada: parkingPoint.miercolesEntrada,
                      miercolesSalida: parkingPoint.miercolesSalida,
                      juevesEntrada: parkingPoint.juevesEntrada,
                      juevesSalida: parkingPoint.juevesSalida,
                      viernesEntrada: parkingPoint.viernesEntrada,
                      viernesSalida: parkingPoint.viernesSalida,
                      sabadoEntrada: parkingPoint.sabadoEntrada,
                      sabadoSalida: parkingPoint.sabadoSalida,
                      domingoEntrada: parkingPoint.domingoApertura,
                      domingoSalida: parkingPoint.domingoCierre,
                      controlPagos: parkingPoint.controlPagos,
                    )));
          },
        ));
      }
      ;
    });

    return markers;
  }

  Widget crearMapa(MiUbicacionState state) {
    if (!state.existeUbicacion) return Center(child: Text('Ubicando...'));

    final mapaBloc = BlocProvider.of<MapaBloc>(context);
    mapaBloc.add(OnNuevaUbicacion(state.ubicacion));

    final cameraPosition =
        new CameraPosition(target: state.ubicacion, zoom: 15);

    //redibujar si el bloc del mapa cambia

    return BlocBuilder<MapaBloc, MapaState>(
      builder: (context, _) {
        //(context,state)
        return GoogleMap(
          initialCameraPosition: cameraPosition,
          myLocationEnabled: true,
          myLocationButtonEnabled: true,
          zoomControlsEnabled: true,
          onMapCreated: mapaBloc.initMapa,
          polylines: mapaBloc.state.polylines.values.toSet(),
          markers: mapaBloc.state.markers.values.toSet(),
          //markers: getmarkers(),
          onCameraMove: (cameraPosition) {
            // cameraPosition.target = LatLng central del mapa
            mapaBloc.add(OnMovioMapa(cameraPosition.target));
          },
        );
      },
    );
  }
}
