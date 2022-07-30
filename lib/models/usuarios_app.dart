// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

UsuarioApp usuarioappFromJson(String str) =>
    UsuarioApp.fromJson(json.decode(str));

String usuarioappToJson(UsuarioApp data) => json.encode(data.toJson());

class UsuarioApp {
  String id;
  String email;
  String nombre;
  String telefono;
  String fotoPerfil;
  String timestampCreacion;
  String idVisitaActual;

  /* 
  ESTO ES LO QUE ESTAMOS HACIENDO AQUI
  UsuarioApp (String id) {
    this.id = id;
  }

*/
  UsuarioApp({
    this.id,
    this.email,
    this.nombre,
    this.telefono,
    this.fotoPerfil,
    this.timestampCreacion,
    this.idVisitaActual,
  });

  /* RECIBE LLAVE Y VALOR (JSON) Y NOS RETORNA UN OBJETO DE TIPO USER (esta clase)
  */

  factory UsuarioApp.fromJson(Map<String, dynamic> json) => UsuarioApp(
        id: json["id"],
        email: json["email"],
        nombre: json["nombre"],
        telefono: json["telefono"],
        fotoPerfil: json["foto_perfil"],
        timestampCreacion: json["timestamp_creacion"],
        idVisitaActual: json["id_visita_actual"],
      );

  /* TOMA EL OBJECOT USER Y LO T5ANSFORMA A UN OBJETO JSON  */

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "nombre": nombre,
        "telefono": telefono,
        "fotoPerfil": fotoPerfil,
        "timestamp_creacion": timestampCreacion,
        "id_visita_actual": idVisitaActual,
      };
}
