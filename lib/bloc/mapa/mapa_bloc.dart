import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:parkline/helpers/helpers.dart';
import 'package:parkline/themes/uber_map_theme.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';

part 'mapa_event.dart';
part 'mapa_state.dart';

class MapaBloc extends Bloc<MapaEvent, MapaState> {
  final nombre = "Parqueo la sexta";

  MapaBloc() : super(new MapaState());

  // Controlador del mapa

  GoogleMapController _mapController;

  // Polylines
  Polyline _miRuta = new Polyline(
      polylineId: PolylineId('mi_ruta'), width: 4, color: Colors.transparent
      // points:
      );

  Polyline _miRutaDestino = new Polyline(
      polylineId: PolylineId('mi_ruta_destino'), width: 4, color: Colors.black87
      // points:
      );

  void initMapa(GoogleMapController controller) {
    if (!state.mapaListo) {
      this._mapController = controller;
      this._mapController.setMapStyle(jsonEncode(uberMapTheme));

      add(OnMapaListo());
    } else {
      this._mapController = controller;
      this._mapController.setMapStyle(jsonEncode(uberMapTheme));

      add(OnMapaListo());
    }
  }

  void moverCamara(LatLng destino) {
    final cameraUpdate = CameraUpdate.newLatLng(destino);
    this._mapController?.animateCamera(cameraUpdate);
  }

  @override
  Stream<MapaState> mapEventToState(MapaEvent event) async* {
    if (event is OnMapaListo) {
      //   print('Mapa Listo');

      yield state.copyWith(mapaListo: true);
    } else if (event is OnNuevaUbicacion) {
      yield* this._onNuevaUbicacion(event);
    } else if (event is OnMarcarRecorrido) {
      yield* this._onMarcarRecorrido(event);
    } else if (event is OnSeguirUbicacion) {
      yield* this._onSeguirUbicacion(event);
    } else if (event is OnMovioMapa) {
      // print(event.centroMapa); // este es la LatLng que cambia cierto tiempo
      yield state.copyWith(ubicacionCentral: event.centroMapa);
    } else if (event is OnCrearRutaInicioDestino) {
      yield* this._onCrearRutaInicioDestino(event);
    }
  }

  Stream<MapaState> _onNuevaUbicacion(OnNuevaUbicacion event) async* {
    if (state.seguirUbicacion) {
      this.moverCamara(event.ubicacion);
    }

    final points = [...this._miRuta.points, event.ubicacion];
    this._miRuta = this._miRuta.copyWith(pointsParam: points);

    final currentPolylines = state.polylines;
    currentPolylines['mi_ruta'] = this._miRuta;

    yield state.copyWith(polylines: currentPolylines);
  }

  Stream<MapaState> _onMarcarRecorrido(OnMarcarRecorrido event) async* {
    if (!state.dibujarRecorrido) {
      this._miRuta = this._miRuta.copyWith(colorParam: Colors.black87);
    } else {
      this._miRuta = this._miRuta.copyWith(colorParam: Colors.transparent);
    }

    final currentPolylines = state.polylines;
    currentPolylines['mi_ruta'] = this._miRuta;

    yield state.copyWith(
        dibujarRecorrido: !state.dibujarRecorrido, polylines: currentPolylines);
  }

  Stream<MapaState> _onSeguirUbicacion(OnSeguirUbicacion event) async* {
    if (!state.seguirUbicacion) {
      this.moverCamara(this._miRuta.points[this._miRuta.points.length - 1]);
    }
    yield state.copyWith(seguirUbicacion: !state.seguirUbicacion);
  }

  Stream<MapaState> _onCrearRutaInicioDestino(
      OnCrearRutaInicioDestino event) async* {
    this._miRutaDestino =
        this._miRutaDestino.copyWith(pointsParam: event.rutaCoordenadas);

    final currentePolylines = state.polylines;

    currentePolylines['mi_ruta_destino'] = this._miRutaDestino;
    //cambio del state con las polynes
    //Emitir el nuevo estado con las nuevas Polynes

    // final iconInicio = await getMarkerInicioIcon(event.duracion.toInt());   // Marcador personalizado

    final iconDestino = await getNetworkImageMarker();
    // await getMarkerDestinoIcon(event.nombreDestino, event.distancia);   //marcador personazliazdo

    // Marcadores

    double kilometros = event.distancia / 1000;
    kilometros = (kilometros * 100).floor().toDouble();
    kilometros = kilometros / 100;

    final markerDestino = new Marker(
        markerId: MarkerId('destino'),
        position: event.rutaCoordenadas[event.rutaCoordenadas.length - 1],
        icon: iconDestino,
        // anchor: Offset(0.1, 0.90),
        visible: true,
        infoWindow: InfoWindow(
          title: 'Destino Actual',
          snippet:
              'Distancia: $kilometros Km , Tiempo: ${(event.duracion / 60).floor()} minutos ',
              
        ));

    final newMarkers = {...state.markers}; //Map.from(state.markers)
    // newMarkers['inicio'] = markerInicio;
    newMarkers['destino'] = markerDestino;

    Future.delayed(Duration(milliseconds: 300)).then((value) {
      // _mapController.showMarkerInfoWindow(MarkerId('inicio'));
      _mapController.showMarkerInfoWindow(MarkerId('destino'));
    });

    yield state.copyWith(
      polylines: currentePolylines,
      markers: newMarkers,
    ); //ceder..... y represar un nuevo estado... c
  }
}
