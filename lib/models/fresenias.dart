import 'dart:convert';

Fresenias espaciosFromJson(String str) => Fresenias.fromJson(json.decode(str));

String espaciosToJson(Fresenias data) => json.encode(data.toJson());

class Fresenias {
    Fresenias({
    this.cantidadResenias,
  });

  String cantidadResenias;

  factory Fresenias.fromJson(Map<String, dynamic> json) => Fresenias(
        cantidadResenias: json["cantidad_resenias"],
      );

  Map<String, dynamic> toJson() => {
        "cantidad_resenias": cantidadResenias,
      };
}
