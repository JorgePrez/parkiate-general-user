import 'package:flutter/material.dart';
import 'package:parkline/models/resenia_app.dart';
import 'package:parkline/models/response_api.dart';
import 'package:parkline/screens/submit_review_edit.dart';
import 'package:parkline/screens/submit_review_screen.dart';
import 'package:parkline/utils/dimensions.dart';
import 'package:parkline/utils/custom_style.dart';
import 'package:parkline/utils/colors.dart';
import 'package:parkline/providers/resenias_provider.dart';

class ParkingCodeScreenDetailsReview extends StatefulWidget {
  final String img_auto,
      numero_placa,
      tiempo_total,
      timestamp_entrada,
      timestamp_salida,
      email,
      telefono,
      id_visita,
      nombre_parqueo,
      direccion,
      id_parqueo,
      usuario_id;

  ParkingCodeScreenDetailsReview(
      {Key key,
      this.img_auto,
      this.numero_placa,
      this.tiempo_total,
      this.timestamp_entrada,
      this.timestamp_salida,
      this.email,
      this.telefono,
      this.id_visita,
      this.nombre_parqueo,
      this.direccion,
      this.id_parqueo,
      this.usuario_id})
      : super(key: key);

  @override
  _ParkingCodeScreenDetailsReviewState createState() =>
      _ParkingCodeScreenDetailsReviewState();
}

class _ParkingCodeScreenDetailsReviewState
    extends State<ParkingCodeScreenDetailsReview> {
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
    final ReseniasProvider reseniasProvider = new ReseniasProvider();

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
                    'Datos registrados de la visita',
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
                    'Dar / Editar reseña a este parqueo',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: Dimensions.largeTextSize,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              onTap: () async {
                //revisar si tiene resema
                print("${widget.id_parqueo} ${widget.usuario_id}; \n");

                ResponseApi actual = await reseniasProvider.getreview(
                    widget.usuario_id, widget.id_parqueo);
                if (actual.data != null) {
                  Resenia_app resenia_actual =
                      Resenia_app.fromJson(actual.data);

                  print('Resenia_app: ${resenia_actual.toJson()}');

                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => SubmitReviewEdit(
                            idusuario: widget.usuario_id,
                            idparqueo: widget.id_parqueo,
                            comentario: resenia_actual.comentario,
                            rating: double.parse(resenia_actual.calificacion),
                          )));
                } else {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => SubmitReviewScreen(
                          idusuario: widget.usuario_id,
                          idparqueo: widget.id_parqueo)));
                }

                //sino tiene reseña crear

                //si tiene editar

                /* Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => SubmitReviewScreen(


                         

                        /*

                          TODO: hacer cambios correspondientes para las reseñas
                              idusuario: widget.,
                              idparqueo: widget.idparqueo,
                              nombreusuario: widget.nombreusuario,
                              imagenusuario: widget.imagenusuario)*/
                        )));
                        */

                //}
              },
            ),
          )
        ],
      );
    } else {
      //TODO: ADASD AD
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
                    'Datos registrados de la visita',
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
          /* SizedBox(height: Dimensions.heightSize * 2.5), //3
        Padding(
          padding: const EdgeInsets.only(
              left: Dimensions.marginSize, right: Dimensions.marginSize),
        ),*/
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
                      'Tiempo total:',
                      style: CustomStyle.textStylebold,
                    ),
                    SizedBox(
                      height: Dimensions.heightSize * 0.5,
                    ),
                    Text(
                      widget.tiempo_total,
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
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'SALIDA:',
                      style: CustomStyle.textStylebold,
                    ),
                    SizedBox(
                      height: Dimensions.heightSize * 0.5,
                    ),
                    Text(
                      widget.timestamp_salida,
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
