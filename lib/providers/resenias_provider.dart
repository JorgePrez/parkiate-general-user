import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:parkline/api/environment.dart';
import 'package:parkline/models/resenia_app.dart';
import 'package:parkline/models/response_api.dart';
import 'package:parkline/models/resenia.dart';
import 'package:http/http.dart' as http;

class ReseniasProvider {
  String _url = Enviroment.API_PARKIATE_KI;

  String _api = '/api/resenias';

  String _api2 = '/api/resenias_app';

  BuildContext context;

  Future init(BuildContext context) {
    this.context = context;
  }

  Future<ResponseApi> create(Resenia resenia) async {
    try {
      Uri url = Uri.http(_url, '$_api/create');
      String bodyParams = json.encode(resenia);
      Map<String, String> headers = {'Content-type': 'application/json'};

      final res = await http.post(url, headers: headers, body: bodyParams);
      final data = json.decode(
          res.body); //lo que nos retorna node JS, success, message, data
      ResponseApi responseApi = ResponseApi.fromJson(data);
      return responseApi;
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

  //Trayendo el listado de reseñias por parqueo

  Future<List<Resenia>> reviewsbyPark(String id_parqueo) async {
    try {
      Uri url = Uri.http(_url, '$_api/getresenias');

      String bodyParams = json.encode({
        'id_parqueo': id_parqueo,
      });

      Map<String, String> headers = {'Content-type': 'application/json'};

      final res = await http.post(url, headers: headers, body: bodyParams);
      final data = json.decode(res.body);
      print(data);

      Resenia resenia = Resenia.fromJsonList(data);
      print(resenia.toList);
      return resenia.toList;
    } catch (e) {
      print('Error: $e');
      return [];
    }
  }

  Future<List<Resenia>> reviewsbyPark2(String id_parqueo) async {
    try {
      Uri url = Uri.http(_url, '$_api2/getfullreviews');

      String bodyParams = json.encode({
        'id_parqueo': id_parqueo,
      });

      Map<String, String> headers = {'Content-type': 'application/json'};

      final res = await http.post(url, headers: headers, body: bodyParams);
      final data = json.decode(res.body);
      print(data);

      Resenia resenia = Resenia.fromJsonList(data);
      print(resenia.toList);
      return resenia.toList;
    } catch (e) {
      print('Error: $e');
      return [];
    }
  }

  Future<ResponseApi> getreview(
      String id_usuario_movil, String id_parqueo) async {
    try {
      Uri url = Uri.http(_url, '$_api2/getreview');

      String bodyParams = json.encode(
          {'id_usuario_movil': id_usuario_movil, 'id_parqueo': id_parqueo});

      Map<String, String> headers = {'Content-type': 'application/json'};

      final res = await http.post(url, headers: headers, body: bodyParams);
      final data = json.decode(
          res.body); //lo que nos retorna node JS, success, message, data
      ResponseApi responseApi = ResponseApi.fromJson(data);
      return responseApi;
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

  Future<ResponseApi> create_review(Resenia_app resenia) async {
    try {
      Uri url = Uri.http(_url, '$_api2/create');
      String bodyParams = json.encode(resenia);
      Map<String, String> headers = {'Content-type': 'application/json'};

      final res = await http.post(url, headers: headers, body: bodyParams);
      final data = json.decode(
          res.body); //lo que nos retorna node JS, success, message, data
      ResponseApi responseApi = ResponseApi.fromJson(data);
      return responseApi;
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

  Future<ResponseApi> create_update(Resenia_app resenia) async {
    try {
      Uri url = Uri.http(_url, '$_api2/updatereview');
      String bodyParams = json.encode(resenia);
      Map<String, String> headers = {'Content-type': 'application/json'};

      final res = await http.post(url, headers: headers, body: bodyParams);
      final data = json.decode(
          res.body); //lo que nos retorna node JS, success, message, data
      ResponseApi responseApi = ResponseApi.fromJson(data);
      return responseApi;
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }
}
