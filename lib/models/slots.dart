import 'dart:convert';

class Slots {


 String codigo;
bool estado;
String idSlot;
String reservas;
String id;


  Slots({
    this.codigo,
    this.estado,
    this.idSlot,
    this.reservas,
  });

 

  factory Slots.fromJson(String str) => Slots.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  /*
  
  String codigo;
bool estado;
String id_slot;
String reservas;
String id;
   */

  factory Slots.fromMap(Map<String, dynamic> json) => Slots(
        codigo: json["codigo"],
        estado: json["estado"],
        idSlot: json["id_slot"],
        reservas: json["reservas"],
      );

  Map<String, dynamic> toMap() => {
        "codigo": codigo,
        "estado": estado,
        "id_slot": idSlot,
        "reservas": reservas,
      };
}
