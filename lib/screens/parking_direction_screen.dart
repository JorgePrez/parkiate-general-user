import 'dart:math';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:parkline/models/parqueofirebase.dart';
import 'package:parkline/models/servicioadmin.dart';
import 'package:parkline/models/usuarios_app.dart';
import 'package:parkline/providers/parqueos_provider.dart';
import 'package:parkline/providers/usuarios_app_provider.dart';
import 'package:parkline/screens/parking_code_entry.dart';
import 'package:parkline/utils/colors.dart';
import 'package:parkline/utils/dimensions.dart';
import 'package:parkline/screens/parking_code_screen.dart';
import 'package:parkline/utils/shared_pref.dart';

import 'package:provider/provider.dart';
import 'package:parkline/services/services.dart';

import 'package:parkline/pages/mapa_page_ruta.dart';
import 'package:parkline/providers/serviciosadmin_provider.dart';

import 'package:parkline/models/response_api.dart';

class ParkingDirectionScreen extends StatefulWidget {
  final String direccion, idparqueo, imagenes, nombreparqueo, media_hora, hora;
  final double latitude, longitude;
  final String controlPagos,
      idusuario,
      nombreusuario,
      telefono,
      modelo_auto,
      placa_auto;

  final String imagen_usuario;

  ParkingDirectionScreen({
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
  _ParkingDirectionScreenState createState() => _ParkingDirectionScreenState();
}

class _ParkingDirectionScreenState extends State<ParkingDirectionScreen> {
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
    SharedPref _sharedPref = new SharedPref();
    final ParqueosProvider parqueosProvider = new ParqueosProvider();
    final UsuarioAppProvider usuarioAppProvider = new UsuarioAppProvider();

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
          Text(
            currentTime,
            style: TextStyle(
                color: Colors.black,
                fontSize: Dimensions.largeTextSize * 2,
                fontWeight: FontWeight.bold),
          ),
          /*    SizedBox(
            height: Dimensions.heightSize * 0.5,
          ),
      */
          // SizedBox(height: Dimensions.heightSize),

          /* AQUI SE ENCONTRATABA ANTERIORMENTE EL GESTURE DETECTOR
          GestureDetector(
            onTap: () async {
              //Rgostyrpam para recovery
              Servicioadmin servicioadmin = new Servicioadmin(
                idServicio: idservicio,
                idParqueo: widget.idparqueo,
                direccion: widget.direccion,
                nombreParqueo: widget.nombreparqueo,
                imagenes: widget.imagenes,
                idUsuario: widget.idusuario,
                nombreUsuario: widget.nombreusuario,
                telefono: widget.telefono,
                modeloAuto: widget.modelo_auto,
                placaAuto: widget.placa_auto,
                fecha: formatted,
                horaDeentrada: currentTime,
                horaDesalida: 'Por Definir',
                precio: 'Por Definir',
                parqueoControlPagos: widget.controlPagos,
              );
      
              ResponseApi responseApi =
                  await serviciosadminProvider.create(servicioadmin);
      
              print('RESPUESTA: ${responseApi.toJson()}');
      
              if (responseApi.success) {
                //  NotificationsService.showSnackbar(responseApi.message);
              } else {
                NotificationsService.showSnackbar(responseApi.message);
              }
      
              final authService =
                  Provider.of<AuthService>(context, listen: false);
      
              await authService
                  .crearsevicio(idservicio); //Guardar el id del servicio
      
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ParkingCodeScreenEntry( //ruta intermedia
                      direccion: widget.direccion,
                      idparqueo: widget.idparqueo,
                      imagenes: widget.imagenes,
                      nombreparqueo: widget.nombreparqueo,
                      idservicio: idservicio,
                      media_hora: widget.media_hora,
                      hora: widget.hora,
                      controlPagos: widget.controlPagos,
                      idusuario: widget.idusuario,
                      nombreusuario: widget.nombreusuario,
                      telefono: widget.telefono,
                      modelo_auto: widget.modelo_auto,
                      placa_auto: widget.placa_auto,
                      imagen_usuario: widget.imagen_usuario)));
            },
            child: Image.asset(
              'assets/qr-code-blue.png', //'assets/images/qrcode.png',
              height: 200.0,
            ),
          ),
          */
          Center(
            child: Text(
              //'Este QR será escaneando por un encargado del parqueo en el momento que llegues',
              'Cuando llegues al parqueo presiona el boton generar QR',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: Dimensions.largeTextSize,
                  fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: Dimensions.heightSize * 0.5,
          ),

          /*        SizedBox(
            height: Dimensions.heightSize * 2,
          ),
      */
          GestureDetector(
            onTap: () async {
              //guardar los datos en algun lado

              ResponseApi user_app_true = await usuarioAppProvider
                  .getById(int.parse(widget.idusuario)); //○8

              UsuarioApp user2 = UsuarioApp.fromJson(user_app_true.data);

              String visita_app = user2.idVisitaActual;

              if ((visita_app == 'N')) {
                _sharedPref.save('id_parqueo_qr', widget.idparqueo);
              }

              //OBTENER EL NOMBRE DEL PARQUEO

              ResponseApi responseApifindparqueo =
                  await parqueosProvider.getparkbyidfirebase(widget.idparqueo);

              Parqueofirebase elparqueo =
                  Parqueofirebase.fromJson(responseApifindparqueo.data);

              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ParkingCodeScreenEntry(
                      //ruta intermedia
                      idparqueo: widget.idparqueo,
                      idusuario: widget.idusuario,
                      nombreparqueo: elparqueo.nombreEmpresa,
                      idVisitaInicial: visita_app)));
            },
            child: Container(
              height: 50.0,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: CustomColor.primaryColor,
                  borderRadius:
                      BorderRadius.all(Radius.circular(Dimensions.radius))),
              child: Center(
                child: Text(
                  'Generar QR',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: Dimensions.largeTextSize,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),

          /* SizedBox(
            height: Dimensions.heightSize * 0.5,
          ),*/

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
                  'Regresar',
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
