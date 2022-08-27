import 'dart:convert';

Parqueofirebase parqueoFromJson(String str) =>
    Parqueofirebase.fromJson(json.decode(str));

String parqueoToJson(Parqueofirebase data) => json.encode(data.toJson());

class Parqueofirebase {
  Parqueofirebase(
      {this.idParqueo,
      this.idDuenio,
      this.nombreEmpresa,
      this.direccion,
      this.capacidadMaxima,
      this.mediaHora,
      this.hora,
      this.dia,
      this.mes,
      this.lunesApertura,
      this.lunesCierre,
      this.domingoApertura,
      this.domingoCierre,
      this.detalles,
      this.imagenes,
      this.latitude,
      this.longitude,
      this.martesApertura,
      this.martesCierre,
      this.miercolesApertura,
      this.miercolesCierre,
      this.juevesApertura,
      this.juevesCierre,
      this.viernesApertura,
      this.viernesCierre,
      this.sabadoApertura,
      this.sabadoCierre,
      this.controlPagos,
      this.idFirebase});

  String idParqueo;
  String idDuenio;
  String nombreEmpresa;
  String direccion;
  String capacidadMaxima;
  String mediaHora;
  String hora;
  String dia;
  String mes;
  String lunesApertura;
  String lunesCierre;
  String domingoApertura;
  String domingoCierre;
  String detalles;
  String imagenes;
  String latitude;
  String longitude;
  String martesApertura;
  String martesCierre;
  String miercolesApertura;
  String miercolesCierre;
  String juevesApertura;
  String juevesCierre;
  String viernesApertura;
  String viernesCierre;
  String sabadoApertura;
  String sabadoCierre;
  String controlPagos;
  String idFirebase;
  List<Parqueofirebase> toList = [];

  factory Parqueofirebase.fromJson(Map<String, dynamic> json) =>
      Parqueofirebase(
        idParqueo: json["id_parqueo"],
        idDuenio: json["id_duenio"],
        nombreEmpresa: json["nombre_empresa"],
        direccion: json["direccion"],
        capacidadMaxima: json["capacidad_maxima"],
        mediaHora: json["media_hora"],
        hora: json["hora"],
        dia: json["dia"],
        mes: json["mes"],
        lunesApertura: json["lunes_apertura"],
        lunesCierre: json["lunes_cierre"],
        domingoApertura: json["domingo_apertura"],
        domingoCierre: json["domingo_cierre"],
        detalles: json["detalles"],
        imagenes: json["imagenes"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        martesApertura: json["martes_apertura"],
        martesCierre: json["martes_cierre"],
        miercolesApertura: json["miercoles_apertura"],
        miercolesCierre: json["miercoles_cierre"],
        juevesApertura: json["jueves_apertura"],
        juevesCierre: json["jueves_cierre"],
        viernesApertura: json["viernes_apertura"],
        viernesCierre: json["viernes_cierre"],
        sabadoApertura: json["sabado_apertura"],
        sabadoCierre: json["sabado_cierre"],
        controlPagos: json["control_pagos"],
        idFirebase: json["id_firebase"],
      );

  Parqueofirebase.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    jsonList.forEach((item) {
      Parqueofirebase parqueo = Parqueofirebase.fromJson(item);
      toList.add(parqueo);
    });
  }

  Map<String, dynamic> toJson() => {
        "id_parqueo": idParqueo,
        "id_duenio": idDuenio,
        "nombre_empresa": nombreEmpresa,
        "direccion": direccion,
        "capacidad_maxima": capacidadMaxima,
        "media_hora": mediaHora,
        "hora": hora,
        "dia": dia,
        "mes": mes,
        "lunes_apertura": lunesApertura,
        "lunes_cierre": lunesCierre,
        "domingo_apertura": domingoApertura,
        "domingo_cierre": domingoCierre,
        "detalles": detalles,
        "imagenes": imagenes,
        "latitude": latitude,
        "longitude": longitude,
        "martes_apertura": martesApertura,
        "martes_cierre": martesCierre,
        "miercoles_apertura": miercolesApertura,
        "miercoles_cierre": miercolesCierre,
        "jueves_apertura": juevesApertura,
        "jueves_cierre": juevesCierre,
        "viernes_apertura": viernesApertura,
        "viernes_cierre": viernesCierre,
        "sabado_apertura": sabadoApertura,
        "sabado_cierre": sabadoCierre,
        "control_pagos": controlPagos,
        "id_firebase": idFirebase,
      };
}
