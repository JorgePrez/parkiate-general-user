// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  String id;
  String email;
  String nombre;
  String telefono;
  String imagen;
  String password;
  String sessionToken;
  String modeloAuto;
  String placaAuto;
  String imagenAuto;
  String tipoAuto;

  /* 
  ESTO ES LO QUE ESTAMOS HACIENDO AQUI
  User (String id) {
    this.id = id;
  }

*/
  User({
    this.id,
    this.email,
    this.nombre,
    this.telefono,
    this.imagen,
    this.password,
    this.sessionToken,
    this.modeloAuto,
    this.placaAuto,
    this.imagenAuto,
    this.tipoAuto,
  });

  /* RECIBE LLAVE Y VALOR (JSON) Y NOS RETORNA UN OBJETO DE TIPO USER (esta clase)
  */

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        email: json["email"],
        nombre: json["nombre"],
        telefono: json["telefono"],
        imagen: json["imagen"],
        password: json["password"],
        sessionToken: json["session_token"],
        modeloAuto: json["modelo_auto"],
        placaAuto: json["placa_auto"],
        imagenAuto: json["imagen_auto"],
        tipoAuto: json["tipo_auto"],
      );

  /* TOMA EL OBJECOT USER Y LO T5ANSFORMA A UN OBJETO JSON  */

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "nombre": nombre,
        "telefono": telefono,
        "imagen": imagen,
        "password": password,
        "session_token": sessionToken,
        "modelo_auto": modeloAuto,
        "placa_auto": placaAuto,
        "imagen_auto": imagenAuto,
        "tipo_auto": tipoAuto,
      };
}
