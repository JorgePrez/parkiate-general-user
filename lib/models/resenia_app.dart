import 'dart:convert';

Resenia_app resenia_appFromJson(String str) =>
    Resenia_app.fromJson(json.decode(str));

String resenia_appToJson(Resenia_app data) => json.encode(data.toJson());

class Resenia_app {
  Resenia_app({
    this.idReseniasApp,
    this.idUsuarioMovil,
    this.idParqueo,
    this.timestampResenia,
    this.calificacion,
    this.comentario,
  });

  String idReseniasApp;
  String idUsuarioMovil;
  String idParqueo;
  String timestampResenia;
  String calificacion;
  String comentario;
  List<Resenia_app> toList = [];

  factory Resenia_app.fromJson(Map<String, dynamic> json) => Resenia_app(
        idReseniasApp: json["id_resenias_app"],
        idUsuarioMovil: json["id_usuario_movil"],
        idParqueo: json["id_parqueo"],
        timestampResenia: json["timestamp_resenia"],
        calificacion: json["calificacion"],
        comentario: json["comentario"],
      );

  Resenia_app.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    jsonList.forEach((item) {
      Resenia_app resenia_app = Resenia_app.fromJson(item);
      toList.add(resenia_app);
    });
  }

  Map<String, dynamic> toJson() => {
        "id_resenias_app": idReseniasApp,
        "id_usuario_movil": idUsuarioMovil,
        "id_parqueo": idParqueo,
        "timestamp_resenia": timestampResenia,
        "calificacion": calificacion,
        "comentario": comentario,
      };
}
