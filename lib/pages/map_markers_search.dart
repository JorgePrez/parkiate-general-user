import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:parkline/bloc/mapa/mapa_bloc.dart';
import 'package:parkline/models/models.dart';
import 'package:parkline/models/parqueo.dart';
import 'package:parkline/services/services.dart';
import 'package:parkline/screens/parking_point_details_screen.dart';
import 'package:parkline/widgets/widgets.dart';
import 'package:provider/provider.dart';
import 'package:parkline/helpers/helpers.dart';
import 'package:parkline/bloc/mi_ubicacion/mi_ubicacion_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parkline/themes/uber_map_theme.dart';
import 'dart:convert';
import 'package:parkline/providers/resenias_provider.dart';
import 'package:parkline/models/resenia.dart';
import 'package:parkline/providers/parqueos_provider.dart';
import 'package:parkline/models/espacios.dart';
import 'package:parkline/models/response_api.dart';

////AGREGANDO MARCARDAORES

class MapMarkersSearch extends StatefulWidget {
  final String idusuario, nombreusuario, telefono, modelo_auto, placa_auto;
  final String imagen_usuario;

  final List<Parqueo> listadito;

  MapMarkersSearch({
    Key key,
    this.idusuario,
    this.nombreusuario,
    this.telefono,
    this.modelo_auto,
    this.placa_auto,
    this.imagen_usuario,
    this.listadito,
  }) : super(key: key);

  @override
  _MapMarkersSearchState createState() => _MapMarkersSearchState();
}

class _MapMarkersSearchState extends State<MapMarkersSearch> {
  BitmapDescriptor customIcon;

  final ReseniasProvider reseniasProvider = new ReseniasProvider();

  GoogleMapController mapController; //contrller for Google map
  final Set<Marker> markers = new Set(); //markers for google map
  static const LatLng showLocation = const LatLng(14.6411, -90.5171);

  ///ubicacion inicial porque aqui hay varios parqueos

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

  //CREANDO MARCADOR PERSONALIZADO
  createMarker(context) {
    if (customIcon == null) {
      ImageConfiguration configuration = createLocalImageConfiguration(context);
      BitmapDescriptor.fromAssetImage(configuration, 'assets/p4.png')
          .then((icon) {
        setState(() {
          customIcon = icon;
        });
      });
    }
  }

  void marcador_personalizado(context) async {
    customIcon = await getMarkerDestinoIcon("parqueo generico", 1000);
  }

  /* void marcador_personalizado(String nombre, double distancia) async {
    customIcon = await getMarkerDestinoIcon(nombre, distancia);
  }*/

  void crear_icono(context) async {
    customIcon = await getNetworkImageMarker();
  }

  void crear_icono_asset(context) async {
    customIcon = await getAssetImageMarker();
  }

  @override
  Widget build(BuildContext context) {
    crear_icono_asset(context);

    return Scaffold(
      body: Stack(
        children: [
          BlocBuilder<MiUbicacionBloc, MiUbicacionState>(
              //en cualquier momento que la ubicacion cambie ese bloc builder se va disparar con los nuevos datos deel state
              builder: (_, state) => crearMapa(state)),
          // MarcadorManual(),
          //     MarcadorManualRuta(),
          // Positioned(top: 15, child: SearchBar()),
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          //  BtnUbicacion(),
          //BtnSeguirUbicacion(),
          //BtnMiRuta(),
        ],
      ),
    );

    /* return Scaffold(
      body: GoogleMap(
        //Map widget from google_maps_flutter package
        zoomGesturesEnabled: true, //enable Zoom in, out on map
        myLocationEnabled: true,
        initialCameraPosition: CameraPosition(
          //innital position in map
         target:  state.ubicacion, //initial position
          zoom: 15.0, //initial zoom level
        ),
        markers: getmarkers(), //markers to show on map
        mapType: MapType.normal, //map type
        onMapCreated: (controller) {
          //method called when map is created
          setState(() {
            mapController = controller;
            mapController.setMapStyle(jsonEncode(uberMapTheme));
            //mapController.showMarkerInfoWindow(MarkerId('destino'));
          });
        },
      ),
    );*/
  }

  Set<Marker> getmarkers() {
    //  final parqueosService = Provider.of<ParqueosService>(context);
    final ParqueosProvider parqueosProvider = new ParqueosProvider();

    //markers to place on map
    // setState(() {
    for (var i = 0; i < widget.listadito.length; i++) {
      Parqueo parkingPoint = widget.listadito[i];

      print(parkingPoint);

      // marcador_personalizado(context);
      //crear_icono_asset(context);

      var longlatitud = double.parse(parkingPoint.latitude);
      var longlongitud = double.parse(parkingPoint.longitude);
      var arr = parkingPoint.detalles.split(' ');

      //  print("el arreglo es $arr");

      var det1 = '';
      var det2 = '';
      var det3 = '';
      var det4 = '';

      markers.add(Marker(
        markerId: MarkerId(parkingPoint.idParqueo),
        position: LatLng(longlatitud, longlongitud),
        infoWindow: InfoWindow(
          //popup info
          title: parkingPoint.nombreEmpresa,
          snippet: parkingPoint.direccion,
        ),
        // icon: BitmapDescriptor.defaultMarker, //Icon for Marker
        icon: customIcon, //Icon for Marker

        onTap: () async {
          List<Resenia> listar =
              await reseniasProvider.reviewsbyPark2(parkingPoint.idParqueo);

          print('Infor window tap');
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => ParkingPointDetailsScreen(
                  idpark: parkingPoint.idParqueo,
                  name: parkingPoint
                      .nombreEmpresa, //        name: parkingPoint.name,
                  amount: parkingPoint.capacidadMaxima,
                  image: parkingPoint.imagenes,
                  address: parkingPoint.direccion,
                  slots: parkingPoint.capacidadMaxima,
                  mediahora: parkingPoint.mediaHora,
                  hora: parkingPoint.hora,
                  dia: parkingPoint.dia,
                  mes: parkingPoint.mes,
                  lunesEntrada: parkingPoint.lunesApertura,
                  lunesCierre: parkingPoint.lunesCierre,
                  martesEntrada: parkingPoint.lunesApertura,
                  martesSalida: parkingPoint.lunesCierre,
                  detalles: arr,
                  cantidad_detalles: arr.length,
                  detalles1: det1,
                  detalles2: det2,
                  detalles3: det3,
                  detalles4: det4,
                  latitude: longlatitud,
                  longitude: longlongitud,
                  miercolesEntrada: parkingPoint.miercolesApertura,
                  miercolesSalida: parkingPoint.martesCierre,
                  juevesEntrada: parkingPoint.juevesApertura,
                  juevesSalida: parkingPoint.juevesCierre,
                  viernesEntrada: parkingPoint.viernesApertura,
                  viernesSalida: parkingPoint.viernesCierre,
                  sabadoEntrada: parkingPoint.sabadoApertura,
                  sabadoSalida: parkingPoint.sabadoCierre,
                  domingoEntrada: parkingPoint.domingoApertura,
                  domingoSalida: parkingPoint.domingoCierre,
                  controlPagos: parkingPoint.controlPagos,
                  idusuario: widget.idusuario,
                  nombreusuario: widget.nombreusuario,
                  telefono: widget.telefono,
                  modelo_auto: widget.modelo_auto,
                  placa_auto: widget.placa_auto,
                  imagen_usuario: widget.imagen_usuario,
                  listaresenias: listar)));
        },
      ));
    }
    ;
    //});

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
          // polylines: mapaBloc.state.polylines.values.toSet(),
          //  markers: mapaBloc.state.markers.values.toSet(),
          markers: getmarkers(),
          onCameraMove: (cameraPosition) {
            // cameraPosition.target = LatLng central del mapa
            mapaBloc.add(OnMovioMapa(cameraPosition.target));
          },
        );
      },
    );
  }
}
