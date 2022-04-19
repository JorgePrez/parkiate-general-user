import 'package:flutter/material.dart';
import 'package:parkline/models/bservicios.dart';
import 'package:parkline/screens/parking_direction_screen.dart';
import 'package:parkline/screens/parking_direction_screen2.dart';
import 'package:parkline/screens/parking_direction_screen_guide.dart';


import 'package:qr_flutter/qr_flutter.dart';
import 'package:parkline/screens/parking_code_screen_qr.dart';
import 'package:parkline/utils/dimensions.dart';
import 'package:parkline/utils/custom_style.dart';
import 'package:parkline/utils/colors.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:parkline/models/response_api.dart';
import 'package:parkline/services/services.dart';
import 'package:parkline/models/servicioadmin.dart';
import 'package:parkline/providers/serviciosadmin_provider.dart';




class ParkingCodeScreen extends StatefulWidget {
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

  final String imagen_usuario;

    final double latitude, longitude;


  ParkingCodeScreen(
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
      this.imagen_usuario, this.latitude, this.longitude})
      : super(key: key);

  @override
  _ParkingCodeScreenState createState() => _ParkingCodeScreenState();
}

class _ParkingCodeScreenState extends State<ParkingCodeScreen> {
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
    final currentTime = DateFormat.Hm().format(DateTime.now()); //dinamic


       final ServiciosadminProvider serviciosadminProvider =
                    new ServiciosadminProvider();


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
                  'Este QR será escaneado para determinar tu hora de salida y cuanto debes pagar ',
                  style: TextStyle(
                      fontSize: Dimensions.largeTextSize,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ),
              SizedBox(height: Dimensions.heightSize),
              GestureDetector(
                onTap: () async {


                },
                child: QrImage(
             
                  data: 'final:${widget.idservicio}',
                  gapless: false,
                  size: 250,
                ),

              ),

               SizedBox(
          height: Dimensions.heightSize * 1.5, //2
        ),

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
                  color: Colors.red,
                  borderRadius: BorderRadius.all(
                      Radius.circular(Dimensions.radius * 0.5))),
              child: Center(
                child: Text(
                  'Mi QR (para finalizar) ha sido escaneado',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: Dimensions.largeTextSize,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            onTap: () async {


              
                    final ServiciosadminProvider serviciosProvider = new ServiciosadminProvider();


               ResponseApi responseApiservicios =
                await serviciosProvider.getserviceboolfinish(widget.idservicio);

            Bservicios fresenias = Bservicios.fromJson(responseApiservicios.data);

            String ocupados = fresenias.servicioBool;
            int servicioBool =int.parse(ocupados);


                      if(servicioBool==1) {


                         NotificationsService.showSnackbar("TU QR PARA FINALIZAR NO HA SIDO ESCANEADO AÚN");


                      }

                      else{

                  


              
                     
                    
                ResponseApi responseApi2 = await serviciosadminProvider
                    .getById(widget.idservicio);

                    
                Servicioadmin serviciorecuperado =
                    Servicioadmin.fromJson(responseApi2.data);




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
                              horainicio: serviciorecuperado.horaDeentrada,
                              controlPagos: widget.controlPagos,
                              idusuario: widget.idusuario,
                              nombreusuario: widget.nombreusuario,
                              telefono: widget.telefono,
                              modelo_auto: widget.modelo_auto,
                              placa_auto: widget.placa_auto,
                              imagen_usuario: widget.imagen_usuario,
                              precio_cobrado: serviciorecuperado.precio,
                              horafinal: serviciorecuperado.horaDesalida,
                                   latitude: widget.latitude,
                              longitude: widget.longitude,)));
                   
                       }

            },
          ),
        ),

            SizedBox(
          height: Dimensions.heightSize * 1.5, //2
        ),

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
                  'Guiarme hacia donde deje mi auto',
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
                          builder: (context) => ParkingDirectionScreenGuide(
                              direccion: widget.direccion,
                              idparqueo: widget.idparqueo,
                              imagenes: widget.imagenes,
                              nombreparqueo: widget.nombreusuario,
                              media_hora: widget.media_hora,
                              hora: widget.hora,
                              latitude: widget.latitude,
                              longitude:  widget.longitude,
                              controlPagos: widget.controlPagos,
                              idusuario: widget.idusuario,
                              nombreusuario: widget.nombreusuario,
                              telefono: widget.telefono,
                              modelo_auto: widget.modelo_auto,
                              placa_auto: widget.placa_auto,
                              imagen_usuario: widget.imagen_usuario)));
                    //}
                  },
                ),
              )


              /*
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
              SizedBox(height: Dimensions.heightSize),*/
            ],
          ),
        ),
        /*SizedBox(
          height: Dimensions.heightSize * 1.5, //2
        ),*/
       // invoiceDetailsWidget(context),
      ],
    );
  }


 /* invoiceDetailsWidget(BuildContext context) {
    final currentTime = DateFormat.Hm().format(DateTime.now());

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
  }*/
}
