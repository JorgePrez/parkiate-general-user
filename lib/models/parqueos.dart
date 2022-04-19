import 'dart:convert';

class Parqueos {
  Parqueos({
    this.capacidad,
    this.controlPagos,
    this.detalles,
    this.dia,
    this.direccion,
    this.domingoApertura,
    this.domingoCierre,
    this.hora,
    this.idDuenio,
    this.idParqueo,
    this.imagenes,
    this.juevesEntrada,
    this.juevesSalida,
    this.latitude,
    this.longitude,
    this.lunesCierre,
    this.lunesEntrada,
    this.martesEntrada,
    this.martesSalida,
    this.mediaHora,
    this.mes,
    this.miercolesEntrada,
    this.miercolesSalida,
    this.nombreParqueo,
    this.sabadoEntrada,
    this.sabadoSalida,
    this.viernesEntrada,
    this.viernesSalida,
  });

  String capacidad;
  String controlPagos;
  String detalles;
  String dia;
  String direccion;
  String domingoApertura;
  String domingoCierre;
  String hora;
  String idDuenio;
  String idParqueo;
  String imagenes;
  String juevesEntrada;
  String juevesSalida;
  String latitude;
  String longitude;
  String lunesCierre;
  String lunesEntrada;
  String martesEntrada;
  String martesSalida;
  String mediaHora;
  String mes;
  String miercolesEntrada;
  String miercolesSalida;
  String nombreParqueo;
  String sabadoEntrada;
  String sabadoSalida;
  String viernesEntrada;
  String viernesSalida;
  String id;

  factory Parqueos.fromJson(String str) => Parqueos.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Parqueos.fromMap(Map<String, dynamic> json) => Parqueos(
        capacidad: json["capacidad"],
        detalles: json["detalles"],
        controlPagos: json["control_pagos"],
        dia: json["dia"],
        direccion: json["direccion"],
        domingoApertura: json["domingo_apertura"],
        domingoCierre: json["domingo_cierre"],
        hora: json["hora"],
        idDuenio: json["id_duenio"],
        idParqueo: json["id_parqueo"],
        imagenes: json["imagenes"],
        juevesEntrada: json["jueves_entrada"],
        juevesSalida: json["jueves_salida"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        lunesCierre: json["lunes_cierre"],
        lunesEntrada: json["lunes_entrada"],
        martesEntrada: json["martes_entrada"],
        martesSalida: json["martes_salida"],
        mediaHora: json["media_hora"],
        mes: json["mes"],
        miercolesEntrada: json["miercoles_entrada"],
        miercolesSalida: json["miercoles_salida"],
        nombreParqueo: json["nombre_parqueo"],
        sabadoEntrada: json["sabado_entrada"],
        sabadoSalida: json["sabado_salida"],
        viernesEntrada: json["viernes_entrada"],
        viernesSalida: json["viernes_salida"],
      );

  Map<String, dynamic> toMap() => {
        "capacidad": capacidad,
        "control_pagos": controlPagos,
        "detalles": detalles,
        "dia": dia,
        "direccion": direccion,
        "domingo_apertura": domingoApertura,
        "domingo_cierre": domingoCierre,
        "hora": hora,
        "id_duenio": idDuenio,
        "id_parqueo": idParqueo,
        "imagenes": imagenes,
        "jueves_entrada": juevesEntrada,
        "jueves_salida": juevesSalida,
        "latitude": latitude,
        "longitude": longitude,
        "lunes_cierre": lunesCierre,
        "lunes_entrada": lunesEntrada,
        "martes_entrada": martesEntrada,
        "martes_salida": martesSalida,
        "media_hora": mediaHora,
        "mes": mes,
        "miercoles_entrada": miercolesEntrada,
        "miercoles_salida": miercolesSalida,
        "nombre_parqueo": nombreParqueo,
        "sabado_entrada": sabadoEntrada,
        "sabado_salida": sabadoSalida,
        "viernes_entrada": viernesEntrada,
        "viernes_salida": viernesSalida,
      };
}
