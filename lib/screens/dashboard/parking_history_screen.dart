import 'package:flutter/material.dart';
import 'package:parkline/screens/parking_code_screen_qr2.dart';

import 'package:parkline/utils/dimensions.dart';
import 'package:parkline/utils/custom_style.dart';
import 'package:parkline/utils/colors.dart';
import 'package:parkline/models/servicioadmin.dart';

class ParkingHistoryScreen extends StatefulWidget {
  final List<Servicioadmin> listaservicios;

  ParkingHistoryScreen({Key key, this.listaservicios}) : super(key: key);

  @override
  _ParkingHistoryScreenState createState() => _ParkingHistoryScreenState();
}

class _ParkingHistoryScreenState extends State<ParkingHistoryScreen> {
  @override
  Widget build(BuildContext context) {
    bool valor = false;

    return SafeArea(
      child: Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      left: Dimensions.marginSize,
                      right: Dimensions.marginSize,
                      top: Dimensions.marginSize),
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
                  height: Dimensions.heightSize,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: Dimensions.marginSize,
                      right: Dimensions.marginSize),
                  child: Text(
                    ' Para ver los detalles del servicio presiona sobre la imagen del parqueo',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: Dimensions.largeTextSize),
                  ),
                ),
                SizedBox(
                  height: Dimensions.heightSize,
                ),
                Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: ListView.builder(
                      itemCount: widget.listaservicios.length,
                      itemBuilder: (context, index) {
                        Servicioadmin parkingHistory =
                            widget.listaservicios[index];

                        String valor_horario = '';
                        if (parkingHistory.horaDesalida != 'N/A') {
                          valor_horario =
                              ' ${parkingHistory.horaDeentrada} - ${parkingHistory.horaDesalida}';
                        } else {
                          valor_horario = ' ${parkingHistory.horaDeentrada}';
                        }

                        if (parkingHistory.parqueoControlPagos == 'S') {
                          valor = false;
                        } else {
                          valor = true;
                        }

                        //  Servicios parkingHistory =
                        //    serviciosService.servicios[index];
                        return Padding(
                          padding: const EdgeInsets.only(
                              left: Dimensions.marginSize,
                              right: Dimensions.marginSize,
                              bottom: Dimensions.heightSize),
                          child: Container(
                            height: 120.0,
                            decoration: BoxDecoration(
                                color: CustomColor.secondaryColor,
                                borderRadius: BorderRadius.all(
                                    Radius.circular(Dimensions.radius))),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ParkingCodeScreenQr2(
                                                      direccion: parkingHistory
                                                          .direccion,
                                                      idparqueo: parkingHistory
                                                          .idParqueo,
                                                      imagenes: parkingHistory
                                                          .imagenes,
                                                      nombreparqueo:
                                                          parkingHistory
                                                              .nombreParqueo,
                                                      idservicio: parkingHistory
                                                          .idServicio,
                                                      horainicio: parkingHistory
                                                          .horaDeentrada,
                                                      horafin: parkingHistory
                                                          .horaDesalida,
                                                      controlPagos: parkingHistory
                                                          .parqueoControlPagos,
                                                      idusuario: parkingHistory
                                                          .idUsuario,
                                                      nombreusuario:
                                                          parkingHistory
                                                              .nombreUsuario,
                                                      telefono: parkingHistory
                                                          .telefono,
                                                      modelo_auto:
                                                          parkingHistory
                                                              .modeloAuto,
                                                      placa_auto: parkingHistory
                                                          .placaAuto,
                                                      precio: parkingHistory
                                                          .precio)));
                                    },
                                    child:
                                        Image.network(parkingHistory.imagenes),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                          height: 25,
                                          width: 120, //,70, //60
                                          decoration: BoxDecoration(
                                              color: valor
                                                  ? Color(0xFFFFDD7A)
                                                  : Color(0xFF8EFF9D),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(
                                                      Dimensions.radius *
                                                          2))), //0.5
                                          child: Center(
                                              child: Text(valor
                                                  ? 'Solamente guiado'
                                                  : 'Proceso completo'))),
                                      SizedBox(height: Dimensions.heightSize),
                                      Text(
                                        parkingHistory.nombreParqueo,
                                        style: TextStyle(
                                            fontSize: Dimensions.largeTextSize,
                                            color: Colors.black),
                                      ),
                                      SizedBox(
                                          height: Dimensions.heightSize * 0.5),
                                      Row(
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Id Parqueo',
                                                style: CustomStyle.textStyle,
                                              ),
                                              SizedBox(
                                                  height:
                                                      Dimensions.heightSize *
                                                          0.3),
                                              Text(
                                                parkingHistory.idParqueo,
                                                style: TextStyle(
                                                    fontSize: Dimensions
                                                        .defaultTextSize,
                                                    color: Colors.black),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            width: Dimensions.widthSize * 2,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                parkingHistory.fecha,
                                                style: CustomStyle.textStyle,
                                              ),
                                              SizedBox(
                                                  height:
                                                      Dimensions.heightSize *
                                                          0.3),
                                              Text(
                                                ' ${valor_horario}',
                                                style: TextStyle(
                                                    fontSize: Dimensions
                                                        .defaultTextSize,
                                                    color: Colors.black),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      }),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
