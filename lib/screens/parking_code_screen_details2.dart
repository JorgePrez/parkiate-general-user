import 'package:flutter/material.dart';
import 'package:parkline/screens/parking_direction_screen_guide.dart';
import 'package:parkline/screens/parking_direction_screen_guide2.dart';
import 'package:parkline/utils/dimensions.dart';
import 'package:parkline/utils/custom_style.dart';
import 'package:parkline/utils/colors.dart';

class ParkingCodeScreenDetails2 extends StatefulWidget {
  final String img_auto,
      numero_placa,
      timestamp_entrada,
      email,
      telefono,
      id_visita,
      nombre_parqueo,
      direccion,
      latitude,
      longitude;

  ParkingCodeScreenDetails2({
    Key key,
    this.img_auto,
    this.numero_placa,
    this.timestamp_entrada,
    this.email,
    this.telefono,
    this.id_visita,
    this.nombre_parqueo,
    this.direccion,
    this.latitude,
    this.longitude,
  }) : super(key: key);

  @override
  _ParkingCodeScreenDetails2State createState() =>
      _ParkingCodeScreenDetails2State();
}

class _ParkingCodeScreenDetails2State extends State<ParkingCodeScreenDetails2> {
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

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    print('ancho $width');
    print('alto $height');

    if (height > 700) {
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
          /* SizedBox(
          height: Dimensions.heightSize * 0.5, //2
        ),*/
          Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      top: Dimensions.heightSize * 3, //1//2.5
                      left: Dimensions //3
                          .marginSize,
                      right: Dimensions.marginSize),
                  child: Text(
                    'Datos registrados de la visita actual',
                    style: TextStyle(
                        fontSize: Dimensions.extraLargeTextSize,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ),
                SizedBox(height: Dimensions.heightSize * 2),
                GestureDetector(
                  child: Image.network(
                    widget.img_auto,
                    height: 150.0,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: Dimensions.heightSize * 1.5, //2
          ),
          invoiceDetailsWidget(context),
          SizedBox(
            height: Dimensions.heightSize * 1.5, //2
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: Dimensions.marginSize, right: Dimensions.marginSize),
            child: GestureDetector(
              child: Container(
                height: 50.0,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.all(
                        Radius.circular(Dimensions.radius * 0.5))),
                child: Center(
                  child: Text(
                    'Ver ubicación del parqueo',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: Dimensions.largeTextSize,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              onTap: () {
                /*guardar ubicacion 
                    
                    */
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ParkingDirectionScreenGuide2(
                          latitude: double.parse(widget.latitude),
                          longitude: double.parse(widget.longitude),
                        )));
                //}
              },
            ),
          )
          /* SizedBox(height: Dimensions.heightSize * 2.5), //3
        Padding(
          padding: const EdgeInsets.only(
              left: Dimensions.marginSize, right: Dimensions.marginSize),
        ),*/
        ],
      );
    } else {
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
          /* SizedBox(
          height: Dimensions.heightSize * 0.5, //2
        ),*/
          Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      top: Dimensions.heightSize * 1, //1//2.5
                      left: Dimensions //3
                          .marginSize,
                      right: Dimensions.marginSize),
                  child: Text(
                    'Datos registrados de la visita actual',
                    style: TextStyle(
                        fontSize: Dimensions.extraLargeTextSize,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ),
                SizedBox(height: Dimensions.heightSize * 2),
                GestureDetector(
                  child: Image.network(
                    widget.img_auto,
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
          SizedBox(
            height: Dimensions.heightSize * 1.5, //2
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: Dimensions.marginSize, right: Dimensions.marginSize),
            child: GestureDetector(
              child: Container(
                height: 50.0,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.all(
                        Radius.circular(Dimensions.radius * 0.5))),
                child: Center(
                  child: Text(
                    'Ver ubicación del parqueo',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: Dimensions.largeTextSize,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              onTap: () {
                /*guardar ubicacion 
                    
                    */
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ParkingDirectionScreenGuide2(
                          latitude: double.parse(widget.latitude),
                          longitude: double.parse(widget.longitude),
                        )));
                //}
              },
            ),
          )
        ],
      );
    }
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
                      'Número de Placa:',
                      style: CustomStyle.textStylebold,
                    ),
                    SizedBox(
                      height: Dimensions.heightSize * 0.5,
                    ),
                    Text(
                      widget.numero_placa,
                      style: TextStyle(
                          fontSize: Dimensions.defaultTextSize,
                          color: CustomColor.primaryColor,
                          fontWeight: FontWeight.bold),
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
                      'ENTRADA:',
                      style: CustomStyle.textStylebold,
                    ),
                    SizedBox(
                      height: Dimensions.heightSize * 0.5,
                    ),
                    Text(
                      widget.timestamp_entrada,
                      style: TextStyle(
                          fontSize: Dimensions.defaultTextSize,
                          color: CustomColor.primaryColor,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: Dimensions.heightSize * 2),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Email:',
                      style: CustomStyle.textStylebold,
                    ),
                    SizedBox(
                      height: Dimensions.heightSize * 0.5,
                    ),
                    Text(
                      widget.email, //Strings.demoModelNo,
                      style: TextStyle(
                          fontSize: Dimensions.defaultTextSize,
                          color: CustomColor.primaryColor,
                          fontWeight: FontWeight.bold),
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
                      'Teléfono:',
                      style: CustomStyle.textStylebold,
                    ),
                    SizedBox(
                      height: Dimensions.heightSize * 0.5,
                    ),
                    Text(
                      widget.telefono, // Strings.demoPlateNo,
                      style: TextStyle(
                          fontSize: Dimensions.defaultTextSize,
                          color: CustomColor.primaryColor,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: Dimensions.heightSize * 2),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Id registrado:',
                      style: CustomStyle.textStylebold,
                    ),
                    SizedBox(
                      height: Dimensions.heightSize * 0.5,
                    ),
                    Text(
                      widget.id_visita, // 'Por determinar', //'Today , 12:00 pm
                      style: TextStyle(
                          fontSize: Dimensions.defaultTextSize,
                          color: CustomColor.primaryColor,
                          fontWeight: FontWeight.bold),
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
                      'Nombre de Parqueo:',
                      style: CustomStyle.textStylebold,
                    ),
                    SizedBox(
                      height: Dimensions.heightSize * 0.5,
                    ),
                    Text(
                      widget
                          .nombre_parqueo, //horafinal, // 'Por determinar', // Today 3.00 PM
                      style: TextStyle(
                          fontSize: Dimensions.defaultTextSize,
                          color: CustomColor.primaryColor,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: Dimensions.heightSize * 2),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Dirección del Parqueo',
                style: CustomStyle.textStylebold,
              ),
              SizedBox(
                height: Dimensions.heightSize * 0.5,
              ),
              Text(
                widget.direccion,
                style: TextStyle(
                    fontSize: Dimensions.defaultTextSize,
                    color: CustomColor.primaryColor,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
