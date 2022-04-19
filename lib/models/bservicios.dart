import 'dart:convert';

Bservicios espaciosFromJson(String str) => Bservicios.fromJson(json.decode(str));

String espaciosToJson(Bservicios data) => json.encode(data.toJson());

class Bservicios {
  Bservicios({
    this.servicioBool,
  });

  String servicioBool;

  factory Bservicios.fromJson(Map<String, dynamic> json) => Bservicios(
        servicioBool: json["servicio_bool"],
      );

  Map<String, dynamic> toJson() => {
        "servicio:bool": servicioBool,
      };
}
