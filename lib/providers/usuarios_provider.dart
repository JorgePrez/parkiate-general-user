import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:parkline/api/environment.dart';
import 'package:parkline/models/response_api.dart';
import 'package:parkline/models/user.dart';
import 'package:parkline/models/direccion.dart';

import 'package:http/http.dart' as http;

class UsuarioProvider {
  String _url = Enviroment.API_PARKIATE_KI;

  String _api = '/api/users';

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
  }

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

  Future<ResponseApi> update(int id, String email, String nombre,
      String telefono, String imagen) async {
    try {
      Uri url = Uri.http(_url, '$_api/update');

      String bodyParams = json.encode({
        'id': id,
        'email': email,
        'nombre': nombre,
        'telefono': telefono,
        'imagen': imagen
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

  Future<ResponseApi> updateauto(int id, String modelo_auto, String placa_auto,
      String imagen_auto, String tipo_auto) async {
    try {
      Uri url = Uri.http(_url, '$_api/updateauto');
      String bodyParams = json.encode({
        'id': id,
        'modelo_auto': modelo_auto,
        'placa_auto': placa_auto,
        'imagen_auto': imagen_auto,
        'tipo_auto': tipo_auto
      });
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
  }
}
