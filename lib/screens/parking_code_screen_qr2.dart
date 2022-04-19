import 'package:flutter/material.dart';
import 'package:parkline/utils/dimensions.dart';
import 'package:parkline/utils/custom_style.dart';
import 'package:parkline/utils/colors.dart';

class ParkingCodeScreenQr2 extends StatefulWidget {
  final String direccion,
      idparqueo,
      imagenes,
      nombreparqueo,
      idservicio,
      horafin,
      horainicio;

  final String controlPagos,
      idusuario,
      nombreusuario,
      telefono,
      modelo_auto,
      placa_auto,
      precio;

  ParkingCodeScreenQr2(
      {Key key,
      this.direccion,
      this.idparqueo,
      this.imagenes,
      this.nombreparqueo,
      this.idservicio,
      this.horainicio,
      this.horafin,
      this.controlPagos,
      this.idusuario,
      this.nombreusuario,
      this.telefono,
      this.modelo_auto,
      this.placa_auto,
      this.precio})
      : super(key: key);

  @override
  _ParkingCodeScreenQr2State createState() => _ParkingCodeScreenQr2State();
}

class _ParkingCodeScreenQr2State extends State<ParkingCodeScreenQr2> {
  @override
  Widget build(BuildContext context) {
    // final servicioService = Provider.of<ServiciosService>(context);

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
    // var start = format.parse(widget.horainicio);
    // var end = format.parse(horafinal);

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
                  'Datos finales del servicio',
                  style: TextStyle(
                      fontSize: Dimensions.extraLargeTextSize,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ),
              SizedBox(height: Dimensions.heightSize),
              GestureDetector(
                child: Image.asset(
                  'assets/images/qrcode.png',
                  height: 175.0,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: Dimensions.heightSize * 1.5, //2
        ),
        invoiceDetailsWidget(context),
       /* SizedBox(height: Dimensions.heightSize * 2.5), //3
        Padding(
          padding: const EdgeInsets.only(
              left: Dimensions.marginSize, right: Dimensions.marginSize),
        ),*/
      ],
    );
  }

  invoiceDetailsWidget(BuildContext context) {
    String valor = "";
    if (widget.precio == 'N/A') {
      valor = 'N/A';
    } 
     else if(widget.precio=='Por Definir'){
      valor ='Por Definir';
     }
    else {
      valor = 'Q${widget.precio}.00';
    }

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
                          .horainicio, // 'Por determinar', //'Today , 12:00 pm
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
                      widget
                          .horafin, //horafinal, // 'Por determinar', // Today 3.00 PM
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
          SizedBox(height: Dimensions.heightSize),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Valor del servicio:',
                style: CustomStyle.textStyle,
              ),
              SizedBox(
                height: Dimensions.heightSize * 0.5,
              ),
              Text(
                valor,
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
