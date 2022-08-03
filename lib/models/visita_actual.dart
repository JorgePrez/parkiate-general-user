import 'dart:convert';

Visitactual visitaactualfromJson(String str) =>
    Visitactual.fromJson(json.decode(str));

String visitaactualToJson(Visitactual data) => json.encode(data.toJson());

class Visitactual {
  Visitactual({
    this.imgAuto,
    this.numeroPlaca,
    this.tiempoTotal,
    this.timestampEntrada,
    this.email,
    this.telefono,
    this.idVisitactual,
    this.nombreParqueo,
    this.direccion,
    this.latitude,
    this.longitude,
    this.imagenParqueo,
    this.tipoRegistro,
  });

  String imgAuto;
  String numeroPlaca;
  String tiempoTotal;
  String timestampEntrada;
  String email;
  String telefono;
  String idVisitactual;
  String nombreParqueo;
  String direccion;
  String latitude;
  String longitude;
  String imagenParqueo;
  String tipoRegistro;

  List<Visitactual> toList = [];

  factory Visitactual.fromJson(Map<String, dynamic> json) => Visitactual(
        imgAuto: json["img_auto"],
        numeroPlaca: json["numero_placa"],
        tiempoTotal: json["tiempo_total"],
        timestampEntrada: (json["timestamp_entrada"]),
        email: json["email"],
        telefono: json["telefono"],
        idVisitactual: json["id_visita"],
        nombreParqueo: json["nombre_parqueo"],
        direccion: json["direccion"],
        latitude: json["latitude"],
        longitude: json['longitude'],
        imagenParqueo: json["imagen_parqueo"],
        tipoRegistro: json["tipo_registro"],
      );

  Visitactual.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    jsonList.forEach((item) {
      Visitactual visita = Visitactual.fromJson(item);
      toList.add(visita);
    });
  }

  Map<String, dynamic> toJson() => {
        "img_auto": imgAuto,
        "numero_placa": numeroPlaca,
        "tiempo_total": tiempoTotal,
        "timestamp_entrada": timestampEntrada,
        "email": email,
        "telefono": telefono,
        "id_visita": idVisitactual,
        "nombre_parqueo": nombreParqueo,
        "direccion": direccion,
        "latitude": latitude,
        "longitude": longitude,
        "imagen_parqueo": imagenParqueo,
        "tipo_registro": tipoRegistro,
      };
}
