import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:parkline/models/parqueos.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class ParqueosService extends ChangeNotifier {
  final String _baseUrl = 'parkiate-ki-default-rtdb.firebaseio.com';
  final List<Parqueos> parqueos = [];
  bool isLoading = true;
  final storage = new FlutterSecureStorage();

  ParqueosService() {
    this.loadParqueos();
  }

  Future<List<Parqueos>> loadParqueos() async {
    this.isLoading = true;
    notifyListeners();

    final url = Uri.https(_baseUrl, 'parqueos.json');

    /* final url = Uri.https(_baseUrl, 'parqueos.json',
        {'auth': await storage.read(key: 'token') ?? ''});*/
    final resp = await http.get(url);

    final Map<String, dynamic> parqueosMap = json.decode(resp.body);
    //print(parqueosMap);

    //se me hace mas facil que no fuera un mapa sino fuera un listado

    parqueosMap.forEach((key, value) {
      final tempparqueo = Parqueos.fromMap(value);
      tempparqueo.id = key;
      this.parqueos.add(tempparqueo);
    });

    // print(this.parqueos[0].nombreParqueo);

    //this.isLoading = false;
    notifyListeners();

    return this.parqueos;
  }
}
