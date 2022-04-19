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

        if (arr[0] == '1') {
          det1 =
              'https://res.cloudinary.com/parkiate-ki/image/upload/v1634373789/detalles/1_riqfzd.png';
        } else if (arr[0] == '2') {
          det1 =
              'https://res.cloudinary.com/parkiate-ki/image/upload/v1634373789/detalles/2_v2zem3.png';
        } else if (arr[0] == '3') {
          det1 =
              'https://res.cloudinary.com/parkiate-ki/image/upload/v1634373789/detalles/3_dfxgfo.png';
        } else if (arr[0] == '4') {
          det1 =
              'https://res.cloudinary.com/parkiate-ki/image/upload/v1634373789/detalles/4_odwmz9.png';
        } else if (arr[0] == '5') {
          det1 =
              'https://res.cloudinary.com/parkiate-ki/image/upload/v1634373790/detalles/5_gkazjl.png';
        } else if (arr[0] == '6') {
          det1 =
              'https://res.cloudinary.com/parkiate-ki/image/upload/v1634373790/detalles/6_olkgog.png';
        } else if (arr[0] == '7') {
          det1 =
              'https://res.cloudinary.com/parkiate-ki/image/upload/v1634373790/detalles/7_mvggpw.png';
        } else if (arr[0] == '8') {
          det1 =
              'https://res.cloudinary.com/parkiate-ki/image/upload/v1634373790/detalles/8_ondlpp.png';
        } else if (arr[0] == '9') {
          det1 =
              'https://res.cloudinary.com/parkiate-ki/image/upload/v1634373790/detalles/9_lhsh3d.png';
        } else if (arr[0] == 'A') {
          det1 =
              'https://res.cloudinary.com/parkiate-ki/image/upload/v1634373790/detalles/A_xzyu9l.png';
        } else if (arr[0] == 'B') {
          det1 =
              'https://res.cloudinary.com/parkiate-ki/image/upload/v1634373790/detalles/B_e7xfxj.png';
        } else if (arr[0] == 'C') {
          det1 =
              'https://res.cloudinary.com/parkiate-ki/image/upload/v1634373790/detalles/C_rz6hde.png';
        } else {
          det1 =
              'https://res.cloudinary.com/parkiate-ki/image/upload/v1638389304/detalles/pngwing.com_1_f0125w.png';
        }

        if (arr[1] == '1') {
          det2 =
              'https://res.cloudinary.com/parkiate-ki/image/upload/v1634373789/detalles/1_riqfzd.png';
        } else if (arr[1] == '2') {
          det2 =
              'https://res.cloudinary.com/parkiate-ki/image/upload/v1634373789/detalles/2_v2zem3.png';
        } else if (arr[1] == '3') {
          det2 =
              'https://res.cloudinary.com/parkiate-ki/image/upload/v1634373789/detalles/3_dfxgfo.png';
        } else if (arr[1] == '4') {
          det2 =
              'https://res.cloudinary.com/parkiate-ki/image/upload/v1634373789/detalles/4_odwmz9.png';
        } else if (arr[1] == '5') {
          det2 =
              'https://res.cloudinary.com/parkiate-ki/image/upload/v1634373790/detalles/5_gkazjl.png';
        } else if (arr[1] == '6') {
          det2 =
              'https://res.cloudinary.com/parkiate-ki/image/upload/v1634373790/detalles/6_olkgog.png';
        } else if (arr[1] == '7') {
          det2 =
              'https://res.cloudinary.com/parkiate-ki/image/upload/v1634373790/detalles/7_mvggpw.png';
        } else if (arr[1] == '8') {
          det2 =
              'https://res.cloudinary.com/parkiate-ki/image/upload/v1634373790/detalles/8_ondlpp.png';
        } else if (arr[1] == '9') {
          det2 =
              'https://res.cloudinary.com/parkiate-ki/image/upload/v1634373790/detalles/9_lhsh3d.png';
        } else if (arr[1] == 'A') {
          det2 =
              'https://res.cloudinary.com/parkiate-ki/image/upload/v1634373790/detalles/A_xzyu9l.png';
        } else if (arr[1] == 'B') {
          det2 =
              'https://res.cloudinary.com/parkiate-ki/image/upload/v1634373790/detalles/B_e7xfxj.png';
        } else if (arr[1] == 'C') {
          det2 =
              'https://res.cloudinary.com/parkiate-ki/image/upload/v1634373790/detalles/C_rz6hde.png';
        } else {
          det2 =
              'https://res.cloudinary.com/parkiate-ki/image/upload/v1638389304/detalles/pngwing.com_1_f0125w.png';
        }

        if (arr[2] == '1') {
          det3 =
              'https://res.cloudinary.com/parkiate-ki/image/upload/v1634373789/detalles/1_riqfzd.png';
        } else if (arr[2] == '2') {
          det3 =
              'https://res.cloudinary.com/parkiate-ki/image/upload/v1634373789/detalles/2_v2zem3.png';
        } else if (arr[2] == '3') {
          det3 =
              'https://res.cloudinary.com/parkiate-ki/image/upload/v1634373789/detalles/3_dfxgfo.png';
        } else if (arr[2] == '4') {
          det3 =
              'https://res.cloudinary.com/parkiate-ki/image/upload/v1634373789/detalles/4_odwmz9.png';
        } else if (arr[2] == '5') {
          det3 =
              'https://res.cloudinary.com/parkiate-ki/image/upload/v1634373790/detalles/5_gkazjl.png';
        } else if (arr[2] == '6') {
          det3 =
              'https://res.cloudinary.com/parkiate-ki/image/upload/v1634373790/detalles/6_olkgog.png';
        } else if (arr[2] == '7') {
          det3 =
              'https://res.cloudinary.com/parkiate-ki/image/upload/v1634373790/detalles/7_mvggpw.png';
        } else if (arr[2] == '8') {
          det3 =
              'https://res.cloudinary.com/parkiate-ki/image/upload/v1634373790/detalles/8_ondlpp.png';
        } else if (arr[2] == '9') {
          det3 =
              'https://res.cloudinary.com/parkiate-ki/image/upload/v1634373790/detalles/9_lhsh3d.png';
        } else if (arr[2] == 'A') {
          det3 =
              'https://res.cloudinary.com/parkiate-ki/image/upload/v1634373790/detalles/A_xzyu9l.png';
        } else if (arr[2] == 'B') {
          det3 =
              'https://res.cloudinary.com/parkiate-ki/image/upload/v1634373790/detalles/B_e7xfxj.png';
        } else if (arr[2] == 'C') {
          det3 =
              'https://res.cloudinary.com/parkiate-ki/image/upload/v1634373790/detalles/C_rz6hde.png';
        } else {
          det3 =
              'https://res.cloudinary.com/parkiate-ki/image/upload/v1638389304/detalles/pngwing.com_1_f0125w.png';
        }

        if (arr[3] == '1') {
          det4 =
              'https://res.cloudinary.com/parkiate-ki/image/upload/v1634373789/detalles/1_riqfzd.png';
        } else if (arr[3] == '2') {
          det4 =
              'https://res.cloudinary.com/parkiate-ki/image/upload/v1634373789/detalles/2_v2zem3.png';
        } else if (arr[3] == '3') {
          det4 =
              'https://res.cloudinary.com/parkiate-ki/image/upload/v1634373789/detalles/3_dfxgfo.png';
        } else if (arr[3] == '4') {
          det4 =
              'https://res.cloudinary.com/parkiate-ki/image/upload/v1634373789/detalles/4_odwmz9.png';
        } else if (arr[3] == '5') {
          det4 =
              'https://res.cloudinary.com/parkiate-ki/image/upload/v1634373790/detalles/5_gkazjl.png';
        } else if (arr[3] == '6') {
          det4 =
              'https://res.cloudinary.com/parkiate-ki/image/upload/v1634373790/detalles/6_olkgog.png';
        } else if (arr[3] == '7') {
          det4 =
              'https://res.cloudinary.com/parkiate-ki/image/upload/v1634373790/detalles/7_mvggpw.png';
        } else if (arr[3] == '8') {
          det4 =
              'https://res.cloudinary.com/parkiate-ki/image/upload/v1634373790/detalles/8_ondlpp.png';
        } else if (arr[3] == '9') {
          det4 =
              'https://res.cloudinary.com/parkiate-ki/image/upload/v1634373790/detalles/9_lhsh3d.png';
        } else if (arr[3] == 'A') {
          det4 =
              'https://res.cloudinary.com/parkiate-ki/image/upload/v1634373790/detalles/A_xzyu9l.png';
        } else if (arr[3] == 'B') {
          det4 =
              'https://res.cloudinary.com/parkiate-ki/image/upload/v1634373790/detalles/B_e7xfxj.png';
        } else if (arr[3] == 'C') {
          det4 =
              'https://res.cloudinary.com/parkiate-ki/image/upload/v1634373790/detalles/C_rz6hde.png';
        } else {
          det4 =
              'https://res.cloudinary.com/parkiate-ki/image/upload/v1638389304/detalles/pngwing.com_1_f0125w.png';
        }

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
                      slots: "0",
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
