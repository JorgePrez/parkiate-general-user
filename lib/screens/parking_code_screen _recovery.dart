import 'package:flutter/material.dart';
import 'package:parkline/screens/parking_code_screen_qr.dart';
import 'package:parkline/utils/dimensions.dart';
import 'package:parkline/utils/custom_style.dart';
import 'package:parkline/utils/colors.dart';

class ParkingCodeScreenRecovery extends StatefulWidget {
  final String direccion,
      idparqueo,
      imagenes,
      nombreparqueo,
      idservicio,
      media_hora,
      hora;
  final String controlPagos,
      idusuario,
      nombreusuario,
      telefono,
      modelo_auto,
      placa_auto;

  final String imagen_usuario, horallegada;

  ParkingCodeScreenRecovery(
      {Key key,
      this.direccion,
      this.idparqueo,
      this.imagenes,
      this.nombreparqueo,
      this.idservicio,
      this.media_hora,
      this.hora,
      this.controlPagos,
      this.idusuario,
      this.nombreusuario,
      this.telefono,
      this.modelo_auto,
      this.placa_auto,
      this.imagen_usuario,
      this.horallegada})
      : super(key: key);

  @override
  _ParkingCodeScreenRecoveryState createState() =>
      _ParkingCodeScreenRecoveryState();
}

class _ParkingCodeScreenRecoveryState extends State<ParkingCodeScreenRecovery> {
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(
              left: Dimensions.marginSize,
              right: Dimensions.marginSize,
              top: Dimensions.heightSize * 1), //2
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
                  'Un encargado del parqueo escaneará este QR para determinar tu hora de salida y pago ',
                  style: TextStyle(
                      fontSize: Dimensions.largeTextSize,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ),
              SizedBox(height: Dimensions.heightSize),
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ParkingCodeScreenQr(
                              direccion: widget.direccion,
                              idparqueo: widget.idparqueo,
                              imagenes: widget.imagenes,
                              nombreparqueo: widget.nombreparqueo,
                              idservicio: widget.idservicio,
                              media_hora: widget.media_hora,
                              hora: widget.hora,
                              horainicio: widget.horallegada,
                              controlPagos: widget.controlPagos,
                              idusuario: widget.idusuario,
                              nombreusuario: widget.nombreusuario,
                              telefono: widget.telefono,
                              modelo_auto: widget.modelo_auto,
                              placa_auto: widget.placa_auto,
                              imagen_usuario: widget.imagen_usuario)));
                },
                child: Image.asset(
                  'assets/qrcodes.png', //'assets/images/qrcode.png',
                  height: 200.0,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: Dimensions.heightSize * 2.5,
                    left: Dimensions //3
                        .marginSize,
                    right: Dimensions.marginSize),
                child: Text(
                  'Datos del servicio actual:',
                  style: TextStyle(
                      fontSize: Dimensions.extraLargeTextSize,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ),
              SizedBox(height: Dimensions.heightSize),
            ],
          ),
        ),
        SizedBox(
          height: Dimensions.heightSize * 1.5, //2
        ),
        invoiceDetailsWidget(context),
      ],
    );
  }

  invoiceDetailsWidget(BuildContext context) {
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
                      widget.nombreusuario,
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
                      widget.telefono,
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
                      widget.modelo_auto, //Strings.demoModelNo,
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
                      widget.placa_auto, // Strings.demoPlateNo,
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
                      widget
                          .horallegada, // 'Por determinar', //'Today , 12:00 pm
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
                      'Por definir', // 'Por determinar', // Today 3.00 PM
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
