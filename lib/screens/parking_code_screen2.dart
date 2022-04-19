import 'package:flutter/material.dart';
import 'package:parkline/utils/dimensions.dart';
import 'package:parkline/utils/custom_style.dart';
import 'package:parkline/utils/colors.dart';
import 'package:intl/intl.dart';
import 'package:parkline/screens/dashboard_screen.dart';
import 'package:parkline/providers/usuarios_provider.dart';
import 'package:parkline/models/response_api.dart';
import 'package:parkline/models/user.dart';
import 'package:parkline/providers/serviciosadmin_provider.dart';
import 'package:parkline/models/servicioadmin.dart';

class ParkingCodeScreen2 extends StatefulWidget {
  final String direccion,
      idparqueo,
      imagenes,
      nombreparqueo,
      idservicio,
      precio;
  final String controlPagos,
      idusuario,
      nombreusuario,
      telefono,
      modelo_auto,
      placa_auto;

  ParkingCodeScreen2(
      {Key key,
      this.direccion,
      this.idparqueo,
      this.imagenes,
      this.nombreparqueo,
      this.idservicio,
      this.precio,
      this.controlPagos,
      this.idusuario,
      this.nombreusuario,
      this.telefono,
      this.modelo_auto,
      this.placa_auto})
      : super(key: key);

  @override
  _ParkingCodeScreen2State createState() => _ParkingCodeScreen2State();
}

class _ParkingCodeScreen2State extends State<ParkingCodeScreen2> {
  UsuarioProvider usuarioProvider = new UsuarioProvider();
  final ServiciosadminProvider serviciosProvider = new ServiciosadminProvider();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: bodyWidget(context),
        ),
      ),
    );
  }

  bodyWidget(BuildContext context) {
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('dd-MM-yyyy');
    final String formatted = formatter.format(now);

    dynamic currentTime = DateFormat.Hm().format(DateTime.now());
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(
              left: Dimensions.marginSize,
              right: Dimensions.marginSize,
              top: Dimensions.heightSize * 1), //2
          child: GestureDetector(
            child: Icon(
              Icons.arrow_back,
              color: CustomColor.primaryColor,
            ),
            onTap: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        SizedBox(
          height: Dimensions.heightSize * 1.5, //2
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    top: Dimensions.heightSize * 2.5,
                    left: Dimensions //3
                        .marginSize,
                    right: Dimensions.marginSize),
                child: Text(
                  'Favor dirigirse a la garita del parqueo',
                  style: TextStyle(
                      fontSize: Dimensions.extraLargeTextSize,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ),
              SizedBox(height: Dimensions.heightSize),
              Image.asset(
                'assets/images/qrcode.png',
                height: 200.0,
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: Dimensions.heightSize * 2.5,
                    left: Dimensions //3
                        .marginSize,
                    right: Dimensions.marginSize),
                child: Text(
                  'GRACIAS POR USAR NUESTRA APP',
                  style: TextStyle(
                      fontSize: Dimensions.extraLargeTextSize,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: Dimensions.heightSize * 1.5, //2
        ),
        // invoiceDetailsWidget(context),
        SizedBox(height: Dimensions.heightSize * 2.5), //3
        Padding(
          padding: const EdgeInsets.only(
              left: Dimensions.marginSize, right: Dimensions.marginSize),
          child: GestureDetector(
            child: Container(
              height: 50.0,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: CustomColor.primaryColor,
                  borderRadius: BorderRadius.all(
                      Radius.circular(Dimensions.radius * 0.5))),
              child: Center(
                child: Text(
                  'FINALIZAR',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: Dimensions.largeTextSize,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            onTap: () async {
              Servicioadmin servicio = new Servicioadmin(
                idServicio: widget.idservicio,
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
                horaDesalida: "N/A",
                precio: "N/A",
                parqueoControlPagos: widget.controlPagos,
              );

              ResponseApi responseApi =
                  await serviciosProvider.create(servicio);

              print('RESPUESTA: ${responseApi.toJson()}');

              if (responseApi.success) {
                //NotificationsService.showSnackbar(responseApi.message);
                print('RESPUESTA: EXITO 1');

                ResponseApi responseApi2 =
                    await usuarioProvider.getById(int.parse(widget.idusuario));

                print('Respuesta object: ${responseApi2}');
                print('RESPUESTA: ${responseApi2.toJson()}');

                if (responseApi2.success) {
                  User user = User.fromJson(responseApi2.data);
                  print('RESPUESTA: EXITO 2');

                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DashboardScreen(
                                id: user.id,
                                email: user.email,
                                nombre: user.nombre,
                                telefono: user.telefono,
                                imagen: user.imagen,
                                session_token: user.sessionToken,
                                modelo_auto: user.modeloAuto,
                                placa_auto: user.placaAuto,
                                imagen_auto: user.imagenAuto,
                                tipo_auto: user.tipoAuto,
                              )));
                } else {
                  print('RESPUESTA: FRACASO 2');
                }
              } else {
                print('RESPUESTA: FRACASO 1');
              }
            },
          ),
        ),
      ],
    );
  }

  invoiceDetailsWidget(BuildContext context) {
    dynamic currentTime = DateFormat.jm().format(DateTime.now());

    return Padding(
      padding: const EdgeInsets.only(
          left: Dimensions.marginSize, right: Dimensions.marginSize),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Nombre',
                      style: CustomStyle.textStyle,
                    ),
                    SizedBox(
                      height: Dimensions.heightSize * 0.5,
                    ),
                    Text(
                      'Jorge Pérez',
                      style: TextStyle(
                          fontSize: Dimensions.defaultTextSize,
                          color: CustomColor.primaryColor),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Telefono',
                      style: CustomStyle.textStyle,
                    ),
                    SizedBox(
                      height: Dimensions.heightSize * 0.5,
                    ),
                    Text(
                      '5672149',
                      style: TextStyle(
                          fontSize: Dimensions.defaultTextSize,
                          color: CustomColor.primaryColor),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: Dimensions.heightSize),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Id del Parqueo',
                      style: CustomStyle.textStyle,
                    ),
                    SizedBox(
                      height: Dimensions.heightSize * 0.5,
                    ),
                    Text(
                      widget.idparqueo,
                      style: TextStyle(
                          fontSize: Dimensions.defaultTextSize,
                          color: CustomColor.primaryColor),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Id Servicio',
                      style: CustomStyle.textStyle,
                    ),
                    SizedBox(
                      height: Dimensions.heightSize * 0.5,
                    ),
                    Text(
                      widget.idservicio,
                      style: TextStyle(
                          fontSize: Dimensions.defaultTextSize,
                          color: CustomColor.primaryColor),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: Dimensions.heightSize),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Modelo del vehículo',
                      style: CustomStyle.textStyle,
                    ),
                    SizedBox(
                      height: Dimensions.heightSize * 0.5,
                    ),
                    Text(
                      'N/A', //Strings.demoModelNo,
                      style: TextStyle(
                          fontSize: Dimensions.defaultTextSize,
                          color: CustomColor.primaryColor),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Número de Placa',
                      style: CustomStyle.textStyle,
                    ),
                    SizedBox(
                      height: Dimensions.heightSize * 0.5,
                    ),
                    Text(
                      'N/A', // Strings.demoPlateNo,
                      style: TextStyle(
                          fontSize: Dimensions.defaultTextSize,
                          color: CustomColor.primaryColor),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: Dimensions.heightSize),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hora de llegada:',
                      style: CustomStyle.textStyle,
                    ),
                    SizedBox(
                      height: Dimensions.heightSize * 0.5,
                    ),
                    Text(
                      currentTime, // 'Por determinar', //'Today , 12:00 pm
                      style: TextStyle(
                          fontSize: Dimensions.defaultTextSize,
                          color: CustomColor.primaryColor),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Hora de Salida:',
                      style: CustomStyle.textStyle,
                    ),
                    SizedBox(
                      height: Dimensions.heightSize * 0.5,
                    ),
                    Text(
                      currentTime, // 'Por determinar', // Today 3.00 PM
                      style: TextStyle(
                          fontSize: Dimensions.defaultTextSize,
                          color: CustomColor.primaryColor),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: Dimensions.heightSize),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Dirección del Parqueo',
                style: CustomStyle.textStyle,
              ),
              SizedBox(
                height: Dimensions.heightSize * 0.5,
              ),
              Text(
                widget.direccion,
                style: TextStyle(
                    fontSize: Dimensions.defaultTextSize,
                    color: CustomColor.primaryColor),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
