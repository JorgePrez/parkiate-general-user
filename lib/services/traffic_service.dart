/* 
Cada vez que yo haga esto siempre va a recuperar la misma instancia

Singleton

final trafficService = new TrafficService()

 */
import 'dart:async';
import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:parkline/models/search_response.dart';
import 'package:parkline/models/traffic_response.dart';
import 'package:parkline/models/models.dart';
import 'package:parkline/helpers/debouncer.dart';

class TrafficService {
  TrafficService._privateConstructor();
  static final TrafficService _instance = TrafficService._privateConstructor();
  factory TrafficService() {
    return _instance;
  }

  final _dio = new Dio();
  final debouncer = Debouncer<String>(duration: Duration(milliseconds: 400));

  final StreamController<SearchResponse> _sugerenciasStreamController =
      new StreamController<SearchResponse>.broadcast();
  Stream<SearchResponse> get sugerenciasStream =>
      this._sugerenciasStreamController.stream;

  final baseUrlDir = 'https://api.mapbox.com/directions/v5';
  final baseUrlGeo = 'https://api.mapbox.com/geocoding/v5';

  final _apiKey =
      'pk.eyJ1Ijoiam9yZ2VwcmV6IiwiYSI6ImNrdmNwM3JybzBjYXoyb21sNHByYXRieTcifQ.bH-U8gRuDNY_JAAMMCr19A';

  Future<DrivingReponsde> getCoordsInicioYDestino(
      LatLng inicio, LatLng destino) async {
    print('inicio: $inicio');
    print('destino: $destino');

    // %2 C= ','  Y  %3B = ';'

    final coordString =
        '${inicio.longitude},${inicio.latitude};${destino.longitude},${destino.latitude}';

    final url = '${this.baseUrlDir}/mapbox/driving/$coordString';

    final resp = await this._dio.get(url, queryParameters: {
      'alternatives': 'true',
      'geometries': 'polyline6',
      'steps': 'false',
      'access_token': this._apiKey,
      'language': 'es',
    });

    // print(resp);
    final data = DrivingReponsde.fromMap(resp.data);

    return data;
  }

  Future<SearchResponse> getResultadosPorQuery(
      String busqueda, LatLng proximidad) async {
    // print('Buscando!!!!!');

    final url = '${this.baseUrlGeo}/mapbox.places/$busqueda.json';

    try {
      final resp = await this._dio.get(url, queryParameters: {
        'country': 'gt',
        'proximity':
            '${proximidad.longitude},${proximidad.latitude}', //Mapbox usa estos valroes al reves
        'language': 'es',
        'access_token': this._apiKey,
      });

      final searchResponse = searchResponseFromJson(resp.data);
      return searchResponse;
    } catch (e) {
      return SearchResponse(features: []);
    }
  }

  void getSugerenciasPorQuery(String busqueda, LatLng proximidad) {
    debouncer.value = '';
    debouncer.onValue = (value) async {
      final resultados = await this.getResultadosPorQuery(value, proximidad);
      this._sugerenciasStreamController.add(resultados);
    };

    final timer = Timer.periodic(Duration(milliseconds: 200), (_) {
      debouncer.value = busqueda;
    });

    Future.delayed(Duration(milliseconds: 201)).then((_) => timer.cancel());
  }

  Future<ReverseQueryResponse> getCoordenadasInfo(LatLng destinoCoords) async {
    final url =
        '${this.baseUrlGeo}/mapbox.places/${destinoCoords.longitude},${destinoCoords.latitude}.json';

    final resp = await this._dio.get(url, queryParameters: {
      'access_token': this._apiKey,
      'language': 'es',
    });

    final data = reverseQueryResponseFromJson(resp.data);

    return data;
  }
}
