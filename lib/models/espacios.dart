import 'dart:convert';

Espacios espaciosFromJson(String str) => Espacios.fromJson(json.decode(str));

String espaciosToJson(Espacios data) => json.encode(data.toJson());

class Espacios {
  Espacios({
    this.espaciosOcupados,
  });

  String espaciosOcupados;

  factory Espacios.fromJson(Map<String, dynamic> json) => Espacios(
        espaciosOcupados: json["espacios_ocupados"],
      );

  Map<String, dynamic> toJson() => {
        "espacios_ocupados": espaciosOcupados,
      };
}
