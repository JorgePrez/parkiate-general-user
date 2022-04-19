import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:parkline/api/environment.dart';
import 'package:parkline/models/parqueo.dart';
import 'package:parkline/models/parqueos.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class ParqueosService extends ChangeNotifier {

   String _url = Enviroment.API_PARKIATE_KI;

  String _api = '/api/parqueos/getAll';

  BuildContext context;

  final String _baseUrl = 'parkiate-ki-default-rtdb.firebaseio.com';
  final List<Parqueo> parqueos = [];
  bool isLoading = true;
  final storage = new FlutterSecureStorage();

  ParqueosService() {
    this.loadParqueos();
  }

  Future<List<Parqueo>> loadParqueos() async {
    this.isLoading = true;
    notifyListeners();

    final url = Uri.http(_url, _api);

    /* final url = Uri.https(_baseUrl, 'parqueos.json',
        {'auth': await storage.read(key: 'token') ?? ''});*/
    final resp = await http.get(url);

    final parqueos = json.decode(resp.body);
    print(parqueos);

    //se me hace mas facil que no fuera un mapa sino fuera un listado

    

    // print(this.parqueos[0].nombreParqueo);

    //this.isLoading = false;
    notifyListeners();

    return this.parqueos;
  }
}
