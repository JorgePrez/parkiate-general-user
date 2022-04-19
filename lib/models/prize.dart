import 'dart:convert';

Prize prizeFromJson(String str) => Prize.fromJson(json.decode(str));

String prizeToJson(Prize data) => json.encode(data.toJson());

class Prize {
  Prize({
    this.mediaHora,
    this.hora,
  });

  String mediaHora;
  String hora;

  factory Prize.fromJson(Map<String, dynamic> json) => Prize(
        mediaHora: json["media_hora"],
        hora: json["hora"],
      );

  Map<String, dynamic> toJson() => {
        "media_hora": mediaHora,
        "hora": hora,
      };
}
