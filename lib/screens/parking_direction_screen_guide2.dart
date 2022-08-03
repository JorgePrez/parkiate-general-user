import 'dart:math';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:parkline/models/servicioadmin.dart';
import 'package:parkline/screens/parking_code_entry.dart';
import 'package:parkline/utils/colors.dart';
import 'package:parkline/utils/dimensions.dart';
import 'package:parkline/screens/parking_code_screen.dart';

import 'package:provider/provider.dart';
import 'package:parkline/services/services.dart';

import 'package:parkline/pages/mapa_page_ruta.dart';
import 'package:parkline/providers/serviciosadmin_provider.dart';

import 'package:parkline/models/response_api.dart';

class ParkingDirectionScreenGuide2 extends StatefulWidget {
  final String direccion, idparqueo, imagenes, nombreparqueo, media_hora, hora;
  final double latitude, longitude;
  final String controlPagos,
      idusuario,
      nombreusuario,
      telefono,
      modelo_auto,
      placa_auto;

  final String imagen_usuario;

  ParkingDirectionScreenGuide2({
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
    this.imagen_usuario,
  }) : super(key: key);

  @override
  _ParkingDirectionScreenGuide2State createState() =>
      _ParkingDirectionScreenGuide2State();
}

class _ParkingDirectionScreenGuide2State
    extends State<ParkingDirectionScreenGuide2> {
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
    final ServiciosadminProvider serviciosadminProvider =
        new ServiciosadminProvider();

    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('dd-MM-yyyy');
    final String formatted = formatter.format(now);

    dynamic currentTime = DateFormat.Hm().format(DateTime.now());

    // dynamic currentTime = DateFormat.Hm().format(DateTime.now());

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
          Center(
            child: Text(
              //'Este QR será escaneando por un encargado del parqueo en el momento que llegues',
              'Para actualizar la ruta debe presionar el botón de arriba que dice "Ver Ruta"',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: Dimensions.largeTextSize,
                  fontWeight: FontWeight.bold),
            ),
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
                  color: Colors.red,
                  borderRadius:
                      BorderRadius.all(Radius.circular(Dimensions.radius))),
              child: Center(
                child: Text(
                  'Regresar a ver detalles de mi visita actual',
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
          //  SizedBox(height: Dimensions.heightSize),
        ],
      ),
    );
  }
}
