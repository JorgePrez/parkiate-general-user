import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:parkline/models/bservicios.dart';
import 'package:parkline/models/parqueofirebase.dart';
import 'package:parkline/models/usuarios_app.dart';
import 'package:parkline/models/visita_actual.dart';
import 'package:parkline/providers/parqueos_provider.dart';
import 'package:parkline/providers/usuarios_app_provider.dart';
import 'package:parkline/providers/visitas_provider.dart';
import 'package:parkline/screens/parking_code_screen_details2.dart';
import 'package:parkline/screens/parking_code_screen_init.dart';
import 'package:parkline/utils/shared_pref.dart';
import 'package:provider/provider.dart';

import 'package:qr_flutter/qr_flutter.dart';

import 'package:parkline/api/environment.dart';

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
  final String idparqueo;
  final String idusuario;
  final String nombreparqueo;
  final String idVisitaInicial;

  ParkingCodeScreenEntry(
      {Key key,
      this.idparqueo,
      this.idusuario,
      this.nombreparqueo,
      this.idVisitaInicial})
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
    final UsuarioAppProvider usuarioAppProvider = new UsuarioAppProvider();
    SharedPref _sharedPref = new SharedPref();

    final VisitasProvider visitasProvider = new VisitasProvider();
    final ParqueosProvider parqueosProvider = new ParqueosProvider();

    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('dd-MM-yyyy');
    final String formatted = formatter.format(now);

    String _url = Enviroment.API_PARKIATE_KI2;

    /*
    Ejemplo de url:
    https://parkiateki.ngrok.io/Parkiate-web/formularios/registrar_desde_app.php?id_parqueo=86BE48&id_usuario=8
    */
    String direccion_registro =
        'https://${_url}/Parkiate-web/registrar_desde_app.php?id_parqueo=${widget.idparqueo}&id_usuario=${widget.idusuario}';

    var image = Image.asset('assets/simplereal.png');
    // dynamic currentTime = DateFormat.Hm().format(DateTime.now());
    //TODO: pantallas de diferentes tamano

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
        SizedBox(height: Dimensions.heightSize * 1 //1.5, //2
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
                  onTap: () async {
                    _sharedPref.removeqr();

                    Navigator.of(context).pop();
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: Dimensions.heightSize * 1, //2.5
                    left: Dimensions //3
                        .marginSize,
                    right: Dimensions.marginSize),
                child: Text(
                  'Puedes colocar este QR debajo del dispositivo lector del parqueo, o bien presentarlo al encargado del parqueo para ser escaneado',
                  style: TextStyle(
                      fontSize: Dimensions.largeTextSize,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ),
              SizedBox(height: Dimensions.heightSize),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                //Ajuste para pantallas pequeñas.....
                GestureDetector(
                  onTap: () async {},
                  child: Center(
                    child: Image.network(
                      'https://res.cloudinary.com/parkiate-ki/image/upload/v1659642981/detalles/DQ-Mini-lectura-codigo-QR_Kimaldi_1_ygrlyi.jpg',
                      height: 175.0,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () async {},
                  child: Center(
                    child: Image.network(
                      'https://res.cloudinary.com/parkiate-ki/image/upload/v1659643984/detalles/5-mejores-escaneres-qr-para-telefonos-inteligentes-android_rdxvgy.jpg',
                      height: 175.0,
                    ),
                  ),
                ),
              ]),

              SizedBox(height: Dimensions.heightSize * 3),
              GestureDetector(
                onTap: () async {},
                child: Center(
                  /* child: Image.asset(
                    'assets/qrcodes.png', //'assets/images/qrcode.png',
                    height: 400.0,
                  ), */

                  child: QrImage(
                    data: '${direccion_registro}',
                    gapless: false,
                    size: 250,
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(
                    left: Dimensions //3
                        .marginSize,
                    right: Dimensions.marginSize),
                child: Center(
                  child: Text(
                    '${widget.nombreparqueo}',
                    style: TextStyle(
                        fontSize: Dimensions.largeTextSize,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
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
              //  SizedBox(height: Dimensions.heightSize),/////////////
            ],
          ),
        ),
        /*SizedBox(
          height: Dimensions.heightSize, //2
        ),*/

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
                  'Ver resultado de código QR',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: Dimensions.largeTextSize,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            onTap: () async {
              UsuarioApp user_app = UsuarioApp.fromJson(
                  await _sharedPref.read('usuario_app') ?? {});

              ResponseApi user_app_true =
                  await usuarioAppProvider.getById(int.parse(user_app.id)); //○8

              UsuarioApp user2 = UsuarioApp.fromJson(user_app_true.data);

              print(user2.toJson());

              String visita_actualizada = user2.idVisitaActual;

              if ((visita_actualizada == 'N') &&
                  (widget.idVisitaInicial == 'N')) {
                return showInfoFlushbar1(
                  context,
                  'Tu QR aún no ha sido escaneado o es inválido',
                  'Para registrar tu visita a este parqueo tú código debe ser escaneado',
                );
              } else if ((visita_actualizada != 'N') &&
                  (widget.idVisitaInicial == 'N')) {
                //procesamientos

                Visitactual visita_actual = await visitasProvider.getById(
                    user_app.id, visita_actualizada);

                print('Usuario_app: ${visita_actual.toJson()}');

                String temporal_fecha_E =
                    visita_actual.timestampEntrada.substring(1, 11);
                String temporal_hora_E =
                    visita_actual.timestampEntrada.substring(11);

                String hora_E = temporal_hora_E.substring(0, 5);

                List<String> temporal_fechaE_slipt =
                    temporal_fecha_E.split('-');

                String dia_e = temporal_fechaE_slipt[2].trim();
                String mes_e = temporal_fechaE_slipt[1];
                String anio_e = temporal_fechaE_slipt[0];

                String fecha_E = '${dia_e}/${mes_e}/${anio_e}';
                String entrada = '${hora_E} - $fecha_E';

                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ParkingCodeScreenDetailsInit(
                            img_auto: visita_actual.imgAuto,
                            numero_placa: visita_actual.numeroPlaca,
                            timestamp_entrada: entrada,
                            email: visita_actual.email,
                            telefono: visita_actual.telefono,
                            id_visita: visita_actual.idVisitactual,
                            nombre_parqueo: visita_actual.nombreParqueo,
                            direccion: visita_actual.direccion,
                            latitude: visita_actual.latitude,
                            longitude: visita_actual.longitude)));
              } else {
                ResponseApi responseApifindparqueo =
                    await parqueosProvider.actual_visita(visita_actualizada);

                Parqueofirebase elparqueo =
                    Parqueofirebase.fromJson(responseApifindparqueo.data);

                return showInfoFlushbar1(
                  context,
                  'QR inválido: (Auto en algún parqueo)',
                  'Parqueo en uso:"${elparqueo.nombreEmpresa}"',
                );
              }
            },
          ),
        ),

        //invoiceDetailsWidget(context),
      ],
    );
  }
}

void showInfoFlushbar(BuildContext context) {
  Flushbar(
    title: 'Tu código aún no ha sido escaneado',
    message:
        'Para avanzar a la siguiente pantalla tú código debe ser escaneado',
    icon: Icon(
      Icons.info_outline,
      size: 28,
      color: Colors.blue.shade300,
    ),
    leftBarIndicatorColor: Colors.blue.shade300,
    duration: Duration(seconds: 3),
  )..show(context);
}

void showInfoFlushbar1(BuildContext context, String mensaje1, String mensaje2) {
  Flushbar(
    title: mensaje1,
    message: mensaje2,
    icon: Icon(
      Icons.info_outline,
      size: 28,
      color: Colors.blue.shade300,
    ),
    leftBarIndicatorColor: Colors.blue.shade300,
    duration: Duration(seconds: 3),
  )..show(context);
}
