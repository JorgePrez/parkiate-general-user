import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class AuthService extends ChangeNotifier {
  final String _baseUrl = 'identitytoolkit.googleapis.com';

  final String _firebaseToken = 'AIzaSyDLcyjmlR5CxmYrYjTJq39q4GleeMrodC0';

  final storage = new FlutterSecureStorage();

  Future<String> createUser(String email, String password) async {
    final Map<String, dynamic> authData = {
      'email': email,
      'password': password,
      'returnSecureToken': true
    };

    final url =
        Uri.https(_baseUrl, '/v1/accounts:signUp', {'key': _firebaseToken});

    final resp = await http.post(url, body: json.encode(authData));
    final Map<String, dynamic> decodedResp = json.decode(resp.body);

    print(decodedResp);
    //tenemos el id token o tenemos un status de error.

    if (decodedResp.containsKey('idToken')) {
      // Token hay que guardarlo en un lugar seguro
      await storage.write(key: 'token', value: decodedResp['idToken']);
      // decodedResp['idToken'];
      return null;
    } else {
      return decodedResp['error']['message'];
    }
  }

  Future<String> login(String email, String password) async {
    final Map<String, dynamic> authData = {
      'email': email,
      'password': password,
      'returnSecureToken': true
    };

    final url = Uri.https(
        _baseUrl, '/v1/accounts:signInWithPassword', {'key': _firebaseToken});

    final resp = await http.post(url, body: json.encode(authData));
    final Map<String, dynamic> decodedResp = json.decode(resp.body);

    print(decodedResp);
    //tenemos el id token o tenemos un status de error.
    //return 'Error en el login';

    if (decodedResp.containsKey('idToken')) {
      // Token hay que guardarlo en un lugar seguro
      await storage.write(key: 'token', value: decodedResp['idToken']);
      // decodedResp['idToken'];
      return null;
    } else {
      return decodedResp['error']['message'];
    }
  }

  Future<String> crearsevicio(String ankey) async {
    await storage.write(key: 'service', value: ankey);
    return null;
  }

  Future<String> crearubicacio(String latitude, String longitude) async {
    await storage.write(key: 'latitude', value: latitude);
        await storage.write(key: 'longitude', value: longitude);

    return null;
  }

  Future<String> borrarubicacion() async {
        await storage.delete(key: 'latitude');
                await storage.delete(key: 'longitude');



    return null;
  }


 

  Future logout() async {
    await storage.delete(key: 'token');
    return;
  }

  Future logout2() async {
    await storage.delete(key: 'service');
    return;
  }
    Future clear_latitude() async {
    await storage.delete(key: 'latitude');
    return;
  }

    Future clear_longitude() async {
    await storage.delete(key: 'longitude');
    return;
  }


  Future<String> readToken() async {
    return await storage.read(key: 'token') ?? '';
  }

  Future<String> readService() async {
    return await storage.read(key: 'service') ?? '';
  }

    Future<String> readlatitude() async {
    return await storage.read(key: 'latitude') ?? '';
  }

  Future<String> readlongitude() async {
    return await storage.read(key: 'longitude') ?? '';
  }



  
}
