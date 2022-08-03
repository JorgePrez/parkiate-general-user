import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:parkline/api/environment.dart';
import 'package:parkline/models/response_api.dart';
import 'package:parkline/models/visita.dart';
import 'package:http/http.dart' as http;
import 'package:parkline/models/visita_actual.dart';

class VisitasProvider {
  String _url = Enviroment.API_PARKIATE_KI;

  String _api = '/api/visitas_app';

  BuildContext context;

  Future init(BuildContext context) {
    this.context = context;
  }

  //Trayendo el listado de reseñias por parqueo

  Future<List<Visita>> getbyuser(String id_usuario) async {
    try {
      Uri url = Uri.http(_url, '$_api/getbyuser');

      String bodyParams = json.encode({
        'id_usuario': id_usuario,
      });

      Map<String, String> headers = {'Content-type': 'application/json'};

      final res = await http.post(url, headers: headers, body: bodyParams);
      final data = json.decode(res.body);
      print(data);

      Visita visita = Visita.fromJsonList(data);
      print(visita.toList);
      return visita.toList;
    } catch (e) {
      print('Error: $e');
      return [];
    }
  }

  Future<List<Visita>> getbypark(String id_parqueo) async {
    try {
      Uri url = Uri.http(_url, '$_api/getbypark');

      String bodyParams = json.encode({
        'id_parqueo': id_parqueo,
      });

      Map<String, String> headers = {'Content-type': 'application/json'};

      final res = await http.post(url, headers: headers, body: bodyParams);
      final data = json.decode(res.body);
      print(data);

      Visita visita = Visita.fromJsonList(data);
      print(visita.toList);
      return visita.toList;
    } catch (e) {
      print('Error: $e');
      return [];
    }
  }

  Future<Visitactual> getById(String id_usuario, String id_visita) async {
    try {
      Uri url = Uri.http(_url, '$_api/getactual');

      String bodyParams =
          json.encode({'id_usuario': id_usuario, 'id_visita': id_visita});

      Map<String, String> headers = {'Content-type': 'application/json'};

      final res = await http.post(url, headers: headers, body: bodyParams);
      final data = json.decode(res.body);

      Visitactual visitactual = Visitactual.fromJson(data);
      return visitactual;
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }
}
