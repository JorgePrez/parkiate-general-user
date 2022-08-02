import 'dart:convert';

Visita visitafromJson(String str) => Visita.fromJson(json.decode(str));

String visitaToJson(Visita data) => json.encode(data.toJson());

class Visita {
  Visita({
    this.imgAuto,
    this.numeroPlaca,
    this.tiempoTotal,
    this.timestampEntrada,
    this.timestampSalida,
    this.email,
    this.telefono,
    this.idVisita,
    this.nombreParqueo,
    this.direccion,
    this.imagenParqueo,
    this.tipoRegistro,
  });

  String imgAuto;
  String numeroPlaca;
  String tiempoTotal;
  String timestampEntrada;
  String timestampSalida;
  String email;
  String telefono;
  String idVisita;
  String nombreParqueo;
  String direccion;
  String imagenParqueo;
  String tipoRegistro;

  List<Visita> toList = [];

  factory Visita.fromJson(Map<String, dynamic> json) => Visita(
        imgAuto: json["img_auto"],
        numeroPlaca: json["numero_placa"],
        tiempoTotal: json["tiempo_total"],
        timestampEntrada: (json["timestamp_entrada"]),
        timestampSalida: (json["timestamp_salida"]),
        email: json["email"],
        telefono: json["telefono"],
        idVisita: json["id_visita"],
        nombreParqueo: json["nombre_parqueo"],
        direccion: json["direccion"],
        imagenParqueo: json["imagen_parqueo"],
        tipoRegistro: json["tipo_registro"],
      );

  Visita.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    jsonList.forEach((item) {
      Visita visita = Visita.fromJson(item);
      toList.add(visita);
    });
  }

  Map<String, dynamic> toJson() => {
        "img_auto": imgAuto,
        "numero_placa": numeroPlaca,
        "tiempo_total": tiempoTotal,
        "timestamp_entrada": timestampEntrada,
        "timestamp_salida": timestampSalida,
        "email": email,
        "telefono": telefono,
        "id_visita": idVisita,
        "nombre_parqueo": nombreParqueo,
        "direccion": direccion,
        "imagen_parqueo": imagenParqueo,
        "tipo_registro": tipoRegistro,
      };
}
