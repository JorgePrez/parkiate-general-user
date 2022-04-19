import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:parkline/api/environment.dart';
import 'package:parkline/models/response_api.dart';
import 'package:parkline/models/servicioadmin.dart';
import 'package:http/http.dart' as http;

class ServiciosadminProvider {
  String _url = Enviroment.API_PARKIATE_KI;

  String _api = '/api/adminservicios';

  BuildContext context;

  Future init(BuildContext context) {
    this.context = context;
  }

  Future<ResponseApi> create(Servicioadmin servicioadmin) async {
    try {
      Uri url = Uri.http(_url, '$_api/create');
      String bodyParams = json.encode(servicioadmin);
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

  Future<ResponseApi> getById(String id_servicio) async {
    try {
      Uri url = Uri.http(_url, '$_api/getById');

      String bodyParams = json.encode({
        'id_servicio': id_servicio,
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
  //ACTUALIZAR CAMPSO hora de saldia y precio
  Future<ResponseApi> update(
      String id_servicio, String hora_desalida, String precio) async {
    try {
      Uri url = Uri.http(_url, '$_api/update');

      /*
        "id_servicio": "ABCA322" ,
	 "hora_desalida": "12:000000",
	 "precio": "300" */

      String bodyParams = json.encode({
        'id_servicio': id_servicio,
        'hora_desalida': hora_desalida,
        'precio': precio
      });

      //<llave, valoir>
      Map<String, String> headers = {'Content-type': 'application/json'};

      final res = await http.put(url, headers: headers, body: bodyParams);
      final data = json.decode(res.body);

      ResponseApi responseApi = ResponseApi.fromJson(data);
      return responseApi;
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

   // Actualizar (crear) la informacion del servicio cuando ya fue registrado por medio deL QR


   Future<ResponseApi> updateqr(
      String id_servicio,
     String id_parqueo,
     String direccion,
     String nombre_parqueo,
     String imagenes, 
     String id_usuario,
     String nombre_usuario,
     String telefono,
     String modelo_auto,
     String placa_auto,
     String fecha,
	   String hora_deentrada,
	   String hora_desalida,
	   String precio,
	   String parqueo_control_pagos

       ) async {
    try {
      Uri url = Uri.http(_url, '$_api/updateqr');

      /*
        {
     "id_servicio": "ABCA322" ,
     "id_parqueo": "ACTALIZADO",
     "direccion": "ACTUALIZADO",
     "nombre_parqueo": "AC",
     "imagenes": "AC", 
     "id_usuario": "AC",
     "nombre_usuario": "AC",
     "telefono": "AC",
     "modelo_auto": "AC",
     "placa_auto": "AC",
     "fecha": "AC",
	 "hora_deentrada": "AC",
	 "hora_desalida": "AC",
	 "precio": "AC",
	 "parqueo_control_pagos": "AC"
}
         */

      String bodyParams = json.encode({
        'id_servicio': id_servicio,
        'id_parqueo': id_parqueo,
        'direccion': direccion,
        'nombre_parqueo': nombre_parqueo,
        'imagenes': imagenes, 
        'id_usuario': id_usuario,
        'nombre_usuario': nombre_usuario,
        'telefono': telefono,
        'modelo_auto': modelo_auto,
        'placa_auto': placa_auto,
        'fecha': fecha,
	      'hora_deentrada': hora_deentrada,
	      'hora_desalida': hora_desalida,
	      'precio': precio,
        'parqueo_control_pagos': parqueo_control_pagos
      });

      //<llave, valoir>
      Map<String, String> headers = {'Content-type': 'application/json'};

      final res = await http.put(url, headers: headers, body: bodyParams);
      final data = json.decode(res.body);

      ResponseApi responseApi = ResponseApi.fromJson(data);
      return responseApi;
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

   






  // Obtener historial de servicios
  Future<List<Servicioadmin>> userhistory(String id_usuario) async {
    try {
      Uri url = Uri.http(_url, '$_api/history');

      String bodyParams = json.encode({
        'id_usuario': id_usuario,
      });

      Map<String, String> headers = {'Content-type': 'application/json'};

      final res = await http.post(url, headers: headers, body: bodyParams);
      final data = json.decode(res.body);
      print(data);

      Servicioadmin servicio = Servicioadmin.fromJsonList(data);
      print(servicio.toList);
      return servicio.toList;
    } catch (e) {
      print('Error: $e');
      return [];
    }
  }




   //


    Future<ResponseApi> getservicebool(String id_servicio) async {
    try {
      Uri url = Uri.http(_url, '$_api/servicesboolean');

      String bodyParams = json.encode({
        'id_servicio': id_servicio,
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


   Future<ResponseApi> getserviceboolfinish(String id_servicio) async {
    try {
      Uri url = Uri.http(_url, '$_api/servicesbooleanfinish');

      String bodyParams = json.encode({
        'id_servicio': id_servicio,
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
