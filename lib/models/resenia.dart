import 'dart:convert';

Resenia reseniaFromJson(String str) => Resenia.fromJson(json.decode(str));

String reseniaToJson(Resenia data) => json.encode(data.toJson());

class Resenia {
  Resenia({
    this.nombreUsuario,
    this.imagenUsuario,
    this.fecha,
    this.calificacion,
    this.comentario,
    this.idParqueo,
  });

  String nombreUsuario;
  String imagenUsuario;
  String fecha;
  String calificacion;
  String comentario;
  String idParqueo;
  List<Resenia> toList = [];

  factory Resenia.fromJson(Map<String, dynamic> json) => Resenia(
        nombreUsuario: json["nombre_usuario"],
        imagenUsuario: json["imagen_usuario"],
        fecha: json["fecha"],
        calificacion: json["calificacion"],
        comentario: json["comentario"],
        idParqueo: json["id_parqueo"],
      );

  Resenia.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    jsonList.forEach((item) {
      Resenia resenia = Resenia.fromJson(item);
      toList.add(resenia);
    });
  }

  Map<String, dynamic> toJson() => {
        "nombre_usuario": nombreUsuario,
        "imagen_usuario": imagenUsuario,
        "fecha": fecha,
        "calificacion": calificacion,
        "comentario": comentario,
        "id_parqueo": idParqueo
      };
}
