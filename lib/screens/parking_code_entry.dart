import 'package:flutter/material.dart';
import 'package:parkline/models/bservicios.dart';
import 'package:provider/provider.dart';

import 'package:qr_flutter/qr_flutter.dart';





import 'package:parkline/models/response_api.dart';
import 'package:parkline/models/servicioadmin.dart';
import 'package:parkline/providers/serviciosadmin_provider.dart';
import 'package:parkline/screens/parking_code_screen.dart';
import 'package:parkline/screens/parking_code_screen_qr.dart';
import 'package:parkline/services/auth_service.dart';
import 'package:parkline/services/notifications_service.dart';
import 'package:parkline/utils/dimensions.dart';
import 'package:parkline/utils/custom_style.dart';
import 'package:parkline/utils/colors.dart';
import 'package:intl/intl.dart';


class ParkingCodeScreenEntry extends StatefulWidget {
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


  ParkingCodeScreenEntry(
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
  _ParkingCodeScreenEntryState createState() => _ParkingCodeScreenEntryState();
}

class _ParkingCodeScreenEntryState extends State<ParkingCodeScreenEntry> {
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

    final ServiciosadminProvider serviciosadminProvider =
        new ServiciosadminProvider();

    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('dd-MM-yyyy');
    final String formatted = formatter.format(now);

   // dynamic currentTime = DateFormat.Hm().format(DateTime.now());

    //final currentTime = DateFormat.Hm().format(DateTime.now()); //dinamic
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

              Padding(
                padding: const EdgeInsets.only(
                    top: Dimensions.heightSize * 2.5,
                    left: Dimensions //3
                        .marginSize,
                    right: Dimensions.marginSize),
                child: Text(
                  'Presenta este QR al encargado del parqueo (en el momento en que este QR sea escaneado el tiempo se comenzará a contar) ',
                  style: TextStyle(
                      fontSize: Dimensions.largeTextSize,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ),
              SizedBox(height: Dimensions.heightSize),
              GestureDetector(
                onTap: () async{

               
                },
                child: Center(

                  

                 /* child: Image.asset(
                    'assets/qrcodes.png', //'assets/images/qrcode.png',
                    height: 400.0,
                  ), */

                  child: QrImage(

             
                  data: 'new:${widget.idservicio}',
                  gapless: false,
                  size: 250,
                ),



                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: Dimensions.heightSize * 2.5,
                    left: Dimensions //3
                        .marginSize,
                    right: Dimensions.marginSize),
             /*   child: Text(
                  'Datos del servicio actual:',
                  style: TextStyle(
                      fontSize: Dimensions.extraLargeTextSize,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),*/
              ),
              SizedBox(height: Dimensions.heightSize),
            ],
          ),
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
                  color: Colors.green,
                  borderRadius: BorderRadius.all(
                      Radius.circular(Dimensions.radius * 0.5))),
              child: Center(
                child: Text(
                  'Mi QR (de inicio) ha sido escaneado',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: Dimensions.largeTextSize,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            onTap: () async {


              //BUSCAR EL ID, si este existe va a permitir navegar sino va a mostrar el banner


                    final ServiciosadminProvider serviciosProvider = new ServiciosadminProvider();


               ResponseApi responseApiservicios =
                await serviciosProvider.getservicebool(widget.idservicio);

            Bservicios fresenias = Bservicios.fromJson(responseApiservicios.data);

            String ocupados = fresenias.servicioBool;
            int servicioBool =int.parse(ocupados);





            if(servicioBool>0) {

           

            
  final currentTime = DateFormat.Hm().format(DateTime.now());

            

              ResponseApi responseApi =
                  await serviciosadminProvider.updateqr(
                    widget.idservicio, 
                    widget.idparqueo, 
                    widget.direccion, 
                    widget.nombreparqueo, 
                    widget.imagenes, 
                    widget.idusuario, 
                    widget.nombreusuario, 
                    widget.telefono, 
                    widget.modelo_auto, 
                    widget.placa_auto, 
                    formatted, 
                    currentTime, 
                    'Por Definir', 
                    'Por Definir', 
                    widget.controlPagos);

              print('RESPUESTA: ${responseApi.toJson()}');

              if (responseApi.success) {
                //  NotificationsService.showSnackbar(responseApi.message);
              } else {
                NotificationsService.showSnackbar(responseApi.message);
              }

              final authService =
                  Provider.of<AuthService>(context, listen: false);

              await authService
                  .crearsevicio(widget.idservicio); //Guardar el id del servicio

                  await authService
                  .crearubicacio(widget.latitude.toString(), widget.longitude.toString()); 

                  print("llego aqui");

                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ParkingCodeScreen(
                           direccion: widget.direccion,
                      idparqueo: widget.idparqueo,
                      imagenes: widget.imagenes,
                      nombreparqueo: widget.nombreparqueo,
                      idservicio: widget.idservicio,
                      media_hora: widget.media_hora,
                      hora: widget.hora,
                      controlPagos: widget.controlPagos,
                      idusuario: widget.idusuario,
                      nombreusuario: widget.nombreusuario,
                      telefono: widget.telefono,
                      modelo_auto: widget.modelo_auto,
                      placa_auto: widget.placa_auto,
                      imagen_usuario: widget.imagen_usuario,
                          latitude: widget.latitude,
                              longitude: widget.longitude,
                      )));
           }

          else{
print("no hay ");
              //  NotificationsService.showSnackbar("TU QR PARA INICIAR NO HA SIDO ESCANEADO AÚN");


           }


            },
          ),
        ),

        

           

        //invoiceDetailsWidget(context),
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
  } */
}
