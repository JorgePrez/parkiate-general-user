// To parse this JSON data, do
//
//     final autosUser = autosUserFromJson(jsonString);

import 'dart:convert';

AutosUser autos_userFromJson(String str) =>
    AutosUser.fromJson(json.decode(str));

String autos_userToJson(AutosUser data) => json.encode(data.toJson());

class AutosUser {
  AutosUser({
    this.placa,
    this.fotoDelante,
    this.fechaRegistroAuto,
  });

  String placa;
  String fotoDelante;
  String fechaRegistroAuto;
  List<AutosUser> toList = [];

  factory AutosUser.fromJson(Map<String, dynamic> json) => AutosUser(
        placa: json["placa"],
        fotoDelante: json["foto_delante"],
        fechaRegistroAuto: json["fecha_registro_auto"],
      );

  AutosUser.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    jsonList.forEach((item) {
      AutosUser autosUser = AutosUser.fromJson(item);
      toList.add(autosUser);
    });
  }

  Map<String, dynamic> toJson() => {
        "placa": placa,
        "foto_delante": fotoDelante,
        "fecha_registro_auto": fechaRegistroAuto,
      };
}
