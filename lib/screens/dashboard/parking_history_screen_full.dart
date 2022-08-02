import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:parkline/models/visita.dart';
import 'package:parkline/screens/parking_code_screen_details.dart';
import 'package:parkline/screens/parking_code_screen_qr2.dart';

import 'package:parkline/utils/dimensions.dart';
import 'package:parkline/utils/custom_style.dart';
import 'package:parkline/utils/colors.dart';
import 'package:parkline/models/servicioadmin.dart';

class ParkingHistoryScreenFull extends StatefulWidget {
  final List<Visita> listaservicios;

  ParkingHistoryScreenFull({Key key, this.listaservicios}) : super(key: key);

  @override
  _ParkingHistoryScreenFullState createState() =>
      _ParkingHistoryScreenFullState();
}

class _ParkingHistoryScreenFullState extends State<ParkingHistoryScreenFull> {
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
                    'Para ver los detalles completos sobre tu visita presiona utiliza el botón ver detalles',
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
                        Visita parkingHistory = widget.listaservicios[index];

                        String temporal_fecha =
                            parkingHistory.timestampSalida.substring(1, 11);

                        List<String> temporal_fecha_slipt =
                            temporal_fecha.split('-');

                        String dia = temporal_fecha_slipt[2].trim();
                        String mes = temporal_fecha_slipt[1];
                        String anio = temporal_fecha_slipt[0];

                        String fecha = '${dia}/${mes}/${anio}';

                        /*   String valor_horario = '';
                        if (parkingHistory.horaDesalida != 'N/A') {
                          valor_horario =
                              ' ${parkingHistory.horaDeentrada} - ${parkingHistory.horaDesalida}';
                        } else {
                          valor_horario = ' ${parkingHistory.horaDeentrada}';
                        }*/

                        if (parkingHistory.tipoRegistro == 'S') {
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
                            height: 150.0, //120
                            decoration: BoxDecoration(
                                color: CustomColor.secondaryColor,
                                border:
                                    Border.all(color: CustomColor.primaryColor),
                                borderRadius: BorderRadius.all(
                                    Radius.circular(Dimensions.radius))),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                /* Container(
                                    height: 25, //25
                                    width: 200, //120     //,70, //60
                                    decoration: BoxDecoration(
                                        color: valor
                                            ? Color(0xFFFFDD7A)
                                            : Color(0xFF8EFF9D),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(Dimensions.radius *
                                                2))), //2 //0.5
                                    child: Center(
                                        child: Text(valor
                                            ? 'Registrado'
                                            : 'Registrado con fotos'))),*/
                                Expanded(
                                  flex: 1, //1
                                  child: GestureDetector(
                                    onTap: () {},
                                    child: Image.network(
                                        parkingHistory.imagenParqueo),
                                  ),
                                ),
                                Expanded(
                                  flex: 2, //
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center, //.start
                                    children: [
                                      Container(
                                          height: 25, //25
                                          width: 200, //120     //,70, //60
                                          decoration: BoxDecoration(
                                              color: valor
                                                  ? Color(0xFFFFDD7A)
                                                  : Color(0xFF8EFF9D),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(
                                                      Dimensions.radius *
                                                          2))), //2 //0.5
                                          child: Center(
                                              child: Text(valor
                                                  ? 'Registrado'
                                                  : 'Registrado con fotos'))),
                                      SizedBox(
                                          height: Dimensions.heightSize *
                                              0.5), //heightSize
                                      Text(
                                        parkingHistory.nombreParqueo,
                                        style: TextStyle(
                                            fontSize: Dimensions.largeTextSize,
                                            color: Colors.black),
                                      ),
                                      SizedBox(
                                          height: Dimensions.heightSize *
                                              0.5), //0.5
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center, //-staert
                                        children: [
                                          Text(
                                            'Fecha de visita: $fecha',
                                            style: CustomStyle.textStyle,
                                          ),
                                          SizedBox(
                                              height:
                                                  Dimensions.heightSize * 0.3),
                                          ElevatedButton.icon(
                                            onPressed: () {
                                              //formato de hora  08:00-27/06/2022

                                              //tiempo_total: 00-00-56-41

                                              /*    List<String> hora_temporal =
                                                  parkingHistory.tiempoTotal
                                                      .split('-');*/

                                              List<String> hora_temporal =
                                                  parkingHistory.tiempoTotal
                                                      .split('-');

                                              String dia_t = hora_temporal[0];
                                              String hora_t = hora_temporal[1];
                                              String minuto_t =
                                                  hora_temporal[2];

                                              if (int.parse(dia_t) > 0) {
                                                dia_t = (int.parse(dia_t))
                                                    .toString();

                                                if (int.parse(dia_t) == 1) {
                                                  dia_t = '${dia_t} dìa';
                                                } else {
                                                  dia_t = '${dia_t} dìas';
                                                }
                                              } else {
                                                dia_t = '';
                                              }

                                              if (int.parse(hora_t) > 0) {
                                                hora_t = (int.parse(hora_t))
                                                    .toString();

                                                if (int.parse(hora_t) == 1) {
                                                  hora_t = '${hora_t} hora';
                                                } else {
                                                  hora_t = '${hora_t} horas';
                                                }
                                              } else {
                                                hora_t = '';
                                              }

                                              if (int.parse(minuto_t) > 0) {
                                                minuto_t = (int.parse(minuto_t))
                                                    .toString();

                                                minuto_t =
                                                    '${minuto_t} minutos';
                                              } else {
                                                minuto_t = '${1} minuto';
                                              }

                                              String tiempo_total =
                                                  '${dia_t} ${hora_t} ${minuto_t}';

                                              String temporal_fecha_E =
                                                  parkingHistory
                                                      .timestampEntrada
                                                      .substring(1, 11);
                                              String temporal_hora_E =
                                                  parkingHistory
                                                      .timestampEntrada
                                                      .substring(11);

                                              String hora_E = temporal_hora_E
                                                  .substring(0, 5);

                                              List<String>
                                                  temporal_fechaE_slipt =
                                                  temporal_fecha_E.split('-');

                                              String dia_e =
                                                  temporal_fechaE_slipt[2]
                                                      .trim();
                                              String mes_e =
                                                  temporal_fechaE_slipt[1];
                                              String anio_e =
                                                  temporal_fechaE_slipt[0];

                                              String fecha_E =
                                                  '${dia_e}/${mes_e}/${anio_e}';
                                              String entrada =
                                                  '${hora_E} - $fecha_E';

                                              String temporal_fecha_S =
                                                  parkingHistory.timestampSalida
                                                      .substring(1, 11);
                                              String temporal_hora_S =
                                                  parkingHistory.timestampSalida
                                                      .substring(11);

                                              String hora_S = temporal_hora_S
                                                  .substring(0, 5);

                                              List<String>
                                                  temporal_fechaS_slipt =
                                                  temporal_fecha_S.split('-');

                                              String dia_s =
                                                  temporal_fechaS_slipt[2]
                                                      .trim();
                                              String mes_s =
                                                  temporal_fechaS_slipt[1];
                                              String anio_s =
                                                  temporal_fechaS_slipt[0];

                                              String fecha_S =
                                                  '${dia_s}/${mes_s}/${anio_s}';

                                              String salida =
                                                  '${hora_S} - $fecha_S';
                                              //tiempo total

                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          ParkingCodeScreenDetails(
                                                            img_auto:
                                                                parkingHistory
                                                                    .imgAuto,
                                                            numero_placa:
                                                                parkingHistory
                                                                    .numeroPlaca,
                                                            tiempo_total:
                                                                tiempo_total,
                                                            timestamp_entrada:
                                                                entrada,
                                                            timestamp_salida:
                                                                salida,
                                                            email:
                                                                parkingHistory
                                                                    .email,
                                                            telefono:
                                                                parkingHistory
                                                                    .telefono,
                                                            id_visita:
                                                                parkingHistory
                                                                    .idVisita,
                                                            nombre_parqueo:
                                                                parkingHistory
                                                                    .nombreParqueo,
                                                            direccion:
                                                                parkingHistory
                                                                    .direccion,
                                                          )));
                                            },
                                            icon: Icon(
                                              // <-- Icon
                                              Icons.remove_red_eye_outlined,
                                              size: 24.0, //24
                                            ),
                                            label: Text(
                                                'Ver Detalles'), // <-- Text
                                          ),
                                          /* Text(
                                           ' ${valor_horario}',
                                            style: TextStyle(
                                                fontSize:
                                                    Dimensions.defaultTextSize,
                                                color: Colors.black),
                                          ),*/
                                          /*Text(
                                            parkingHistory.idParqueo,
                                            style: TextStyle(
                                                fontSize:
                                                    Dimensions.defaultTextSize,
                                                color: Colors.black),
                                          ),*/
                                        ],
                                      ),
                                      /*     SizedBox(
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
                                                  Dimensions.heightSize * 0.3),
                                          Text(
                                            ' ${valor_horario}',
                                            style: TextStyle(
                                                fontSize:
                                                    Dimensions.defaultTextSize,
                                                color: Colors.black),
                                          ),
                                        ],
                                      ),*/
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
