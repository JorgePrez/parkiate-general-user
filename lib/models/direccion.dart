import 'dart:convert';

import 'package:flutter/cupertino.dart';

Direccion direccionFromJson(String str) => Direccion.fromJson(json.decode(str));

String direccionToJson(Direccion data) => json.encode(data.toJson());

class Direccion{
  Direccion({
    this.idUsuario,
    this.nombre,
    this.nombreDetallado,
    this.latitude,
    this.longitude,
  });

   /*
     "id": "3",
            "id_usuario": "ABCAS1",
            "nombre": "JUYIRA",
            "nombre_detallado": "SUPER JUYIRA GUATEMALA",
            "latitude": "90.2358",
            "longitude": "11.2526"
            */

    String idUsuario;
   String nombre;
   String nombreDetallado;
    String latitude;
   String longitude;
  List<Direccion> toList = [];

  factory Direccion.fromJson(Map<String, dynamic> json) => Direccion(
        idUsuario: json["id_usuario"],
        nombre: json["nombre"],
        nombreDetallado: json["nombre_detallado"],
        latitude: json["latitude"],
        longitude: json["longitude"],
      );

  Direccion.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    jsonList.forEach((item) {
      Direccion direccion = Direccion.fromJson(item);
      toList.add(direccion);
    });
  }

  Map<String, dynamic> toJson() => {
        "id_usuario": idUsuario,
        "nombre": nombre,
        "nombre_detallado": nombreDetallado,
        "latitude": latitude,
        "longitude": longitude
      };
}
