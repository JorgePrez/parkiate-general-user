import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:parkline/api/environment.dart';
import 'package:parkline/models/response_api.dart';
import 'package:parkline/models/parqueo.dart';
import 'package:http/http.dart' as http;

class ParqueosProvider {
  String _url = Enviroment.API_PARKIATE_KI;

  String _api = '/api/parqueos';

  BuildContext context;

  Future init(BuildContext context) {
    this.context = context;
  }


  // Obteniendo todos los parqueos


  Future<List<Parqueo>> loadParqueos() async {
  

 try {
          Uri url = Uri.http(_url, '$_api/getAll');


   
    final resp = await http.get(url);

       final data = json.decode(resp.body);
      print(data);


      Parqueo parqueo = Parqueo.fromJsonList(data);
      print(parqueo.toList);

        return parqueo.toList;
    } catch (e) {
      print('Error: $e');
      return [];
    }


  }
    
   

   


  // Obtener en base a keyword (busqueda de parqueo)
  Future<List<Parqueo>> buscar(String akeyword) async {
    akeyword = '%${akeyword}%';
    try {
      Uri url = Uri.http(_url, '$_api/search');

      String bodyParams = json.encode({
        'akeyword': akeyword,
      });

      Map<String, String> headers = {'Content-type': 'application/json'};

      final res = await http.post(url, headers: headers, body: bodyParams);
      final data = json.decode(res.body);
      print(data);

      Parqueo parqueo = Parqueo.fromJsonList(data);
      print(parqueo.toList);
      return parqueo.toList;
    } catch (e) {
      print('Error: $e');
      return [];
    }
  }

  Future<ResponseApi> getprize(String id_parqueo) async {
    try {
      Uri url = Uri.http(_url, '$_api/prize');

      String bodyParams = json.encode({
        'id_parqueo': id_parqueo,
      });

      Map<String, String> headers = {'Content-type': 'application/json'};

      final res = await http.post(url, headers: headers, body: bodyParams);
      final data = json.decode(res.body);

      ResponseApi responseApi = ResponseApi.fromJson(data);
      return responseApi;
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

  Future<ResponseApi> getslots(String id_parqueo) async {
    try {
      Uri url = Uri.http(_url, '$_api/slot');

      String bodyParams = json.encode({
        'id_parqueo': id_parqueo,
      });

      Map<String, String> headers = {'Content-type': 'application/json'};

      final res = await http.post(url, headers: headers, body: bodyParams);
      final data = json.decode(res.body);

      ResponseApi responseApi = ResponseApi.fromJson(data);
      return responseApi;
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

    Future<ResponseApi> getreviews(String id_parqueo, String nombre_usuario) async {
    try {
      Uri url = Uri.http(_url, '$_api/reviews');

      String bodyParams = json.encode({
        'id_parqueo': id_parqueo,
        'nombre_usuario': nombre_usuario
      });

      Map<String, String> headers = {'Content-type': 'application/json'};

      final res = await http.post(url, headers: headers, body: bodyParams);
      final data = json.decode(res.body);

      ResponseApi responseApi = ResponseApi.fromJson(data);
      return responseApi;
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }


}
