import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:parkline/api/environment.dart';
import 'package:parkline/models/response_api.dart';
import 'package:parkline/models/user.dart';
import 'package:parkline/models/autos_user.dart';

import 'package:parkline/models/direccion.dart';

import 'package:http/http.dart' as http;
import 'package:parkline/models/usuarios_app.dart';

class UsuarioAppProvider {
  String _url = Enviroment.API_PARKIATE_KI;

  String _api = '/api/usuarios_app';

  BuildContext context;

  Future init(BuildContext context) {
    this.context = context;
  }

/*
Respuesta Postman
{
    "sucess": true,
    "message": "El registro se realizo correctamente",
    "data": "12"  o en lugar de data un "error"
    }


}
*/

/*
  Future<ResponseApi> create(User user) async {
    try {
      Uri url = Uri.http(_url, '$_api/create');
      String bodyParams = json.encode(user);
      //<llave, valoir>
      Map<String, String> headers = {'Content-type': 'application/json'};

      final res = await http.post(url, headers: headers, body: bodyParams);
      final data = json.decode(
          res.body); //lo que nos retorna node JS, success, message, data

      /* ESTO ES UN MAPA DE VALORES, (data)
     LLAVE    : VALOR  
     "correo":  "jorgi@gmail.com",

     */
      ResponseApi responseApi = ResponseApi.fromJson(data);
      return responseApi;
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }*/

  Future<ResponseApi> login(String email, String password) async {
    try {
      Uri url = Uri.http(_url, '$_api/login');
      String bodyParams = json.encode({'email': email, 'password': password});
      //<llave, valoir>
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

  Future<ResponseApi> getById(int id_usuario) async {
    try {
      Uri url = Uri.http(_url, '$_api/getuser');

      String bodyParams = json.encode({
        'id_usuario': id_usuario,
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

  Future<ResponseApi> update(
      int id, String nombre, String telefono, String foto_perfil) async {
    try {
      Uri url = Uri.http(_url, '$_api/modifyuser');

      String bodyParams = json.encode({
        'id': id,
        'nombre': nombre,
        'telefono': telefono,
        'foto_perfil': foto_perfil
      });

      //<llave, valoir>
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

  Future<String> uploadImage(String path) async {
    final url = Uri.parse(
        'https://api.cloudinary.com/v1_1/parkiate-ki/image/upload?upload_preset=ipkmhg7m');

    final imageUploadRequest = http.MultipartRequest('POST', url);

    final file = await http.MultipartFile.fromPath('file', path);

    imageUploadRequest.files.add(file);

    final streamedResponse = await imageUploadRequest.send();
    final resp = await http.Response.fromStream(streamedResponse);

    if (resp.statusCode != 200 && resp.statusCode != 201) {
      print('Algo salio mal al registrar la imagen');
      print(resp.body);
      return null;
    }

    final decodedData = json.decode(resp.body);

    return decodedData['secure_url'];

    //   print(resp.body);
  }

  Future<List<AutosUser>> getAutos(String id_usuario) async {
    try {
      Uri url = Uri.http(_url, '$_api/autosbyuser');

      String bodyParams = json.encode({
        'id_usuario': id_usuario,
      });

      Map<String, String> headers = {'Content-type': 'application/json'};

      final res = await http.post(url, headers: headers, body: bodyParams);
      final data = json.decode(res.body);
      print(data);

      AutosUser autosUser = AutosUser.fromJsonList(data);
      print(autosUser.toList);
      return autosUser.toList;
    } catch (e) {
      print('Error: $e');
      return [];
    }
  }
/*
  Future<ResponseApi> getById(int id_usuario) async {
    try {
      Uri url = Uri.http(_url, '$_api/getById');

      String bodyParams = json.encode({
        'id_usuario': id_usuario,
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

  Future<String> uploadImage(String path) async {
    final url = Uri.parse(
        'https://api.cloudinary.com/v1_1/parkiate-ki/image/upload?upload_preset=is-sales-preset');

    final imageUploadRequest = http.MultipartRequest('POST', url);

    final file = await http.MultipartFile.fromPath('file', path);

    imageUploadRequest.files.add(file);

    final streamedResponse = await imageUploadRequest.send();
    final resp = await http.Response.fromStream(streamedResponse);

    if (resp.statusCode != 200 && resp.statusCode != 201) {
      print('Algo salio mal al registrar la imagen');
      print(resp.body);
      return null;
    }

    final decodedData = json.decode(resp.body);

    return decodedData['secure_url'];

    //   print(resp.body);
  }

//creando direcciones

  Future<ResponseApi> createdireccion(Direccion direccion) async {
    try {
      Uri url = Uri.http(_url, '$_api/createdirections');
      String bodyParams = json.encode(direccion);
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

  //obtener direcciones por usuario

  Future<List<Direccion>> getDirections(String id_usuario) async {
    try {
      Uri url = Uri.http(_url, '$_api/getdirections');

      String bodyParams = json.encode({
        'id_usuario': id_usuario,
      });

      Map<String, String> headers = {'Content-type': 'application/json'};

      final res = await http.post(url, headers: headers, body: bodyParams);
      final data = json.decode(res.body);
      print(data);

      Direccion direccion = Direccion.fromJsonList(data);
      print(direccion.toList);
      return direccion.toList;
    } catch (e) {
      print('Error: $e');
      return [];
    }
  }*/
}
