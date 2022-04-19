import 'dart:math';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:parkline/screens/parking_code_screen2.dart';
import 'package:parkline/utils/dimensions.dart';
import 'package:parkline/utils/colors.dart';

import 'package:parkline/pages/mapa_page_ruta.dart';

class ParkingDirectionScreen2 extends StatefulWidget {
  final String direccion, idparqueo, imagenes, nombreparqueo, media_hora, hora;
  final double latitude, longitude;
  final String controlPagos,
      idusuario,
      nombreusuario,
      telefono,
      modelo_auto,
      placa_auto;

  ParkingDirectionScreen2({
    Key key,
    this.direccion,
    this.idparqueo,
    this.imagenes,
    this.nombreparqueo,
    this.media_hora,
    this.hora,
    this.latitude,
    this.longitude,
    this.controlPagos,
    this.idusuario,
    this.nombreusuario,
    this.telefono,
    this.modelo_auto,
    this.placa_auto,
  }) : super(key: key);

  @override
  _ParkingDirectionScreen2State createState() =>
      _ParkingDirectionScreen2State();
}

class _ParkingDirectionScreen2State extends State<ParkingDirectionScreen2> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: MapaPageRuta(
                  latitude: widget.latitude, longitude: widget.longitude),
            ),
            DraggableScrollableSheet(
              builder: (context, scrollController) {
                return Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(Dimensions.radius * 3),
                          topRight: Radius.circular(Dimensions.radius * 5))),
                  child: SingleChildScrollView(
                    child: bodyWidget(context),
                    controller: scrollController,
                  ),
                );
              },
              initialChildSize: 0.35,
              minChildSize: 0.35,
              maxChildSize: 1,
            ),
          ],
        ),
      )),
    );
  }

  bodyWidget(BuildContext context) {
    dynamic currentTime = DateFormat.Hm().format(DateTime.now());

    var random = Random.secure();
    var values = List<int>.generate(6, (i) => random.nextInt(255));
    var idservicio = base64UrlEncode(values);

    return Padding(
      padding: const EdgeInsets.only(
          left: Dimensions.marginSize,
          right: Dimensions.marginSize,
          top: Dimensions.heightSize * 2),
      child: Column(
        children: [
          Text(
            '$currentTime',
            style: TextStyle(
                color: Colors.black,
                fontSize: Dimensions.largeTextSize * 2,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: Dimensions.heightSize * 0.5,
          ),
          SizedBox(
            height: Dimensions.heightSize * 2,
          ),
          GestureDetector(
            child: Container(
              height: 50.0,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: CustomColor.primaryColor,
                  borderRadius:
                      BorderRadius.all(Radius.circular(Dimensions.radius))),
              child: Center(
                child: Text(
                  'Presione al llegar parqueo',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: Dimensions.largeTextSize,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ParkingCodeScreen2(
                      direccion: widget.direccion,
                      idparqueo: widget.idparqueo,
                      imagenes: widget.imagenes,
                      nombreparqueo: widget.nombreparqueo,
                      idservicio: idservicio,
                      controlPagos: widget.controlPagos,
                      idusuario: widget.idusuario,
                      nombreusuario: widget.nombreusuario,
                      telefono: widget.telefono,
                      modelo_auto: widget.modelo_auto,
                      placa_auto: widget.placa_auto)));
            },
          ),
          SizedBox(height: Dimensions.heightSize),
          GestureDetector(
            child: Container(
              height: 50.0,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius:
                      BorderRadius.all(Radius.circular(Dimensions.radius))),
              child: Center(
                child: Text(
                  'CANCELAR',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: Dimensions.largeTextSize,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            onTap: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}
