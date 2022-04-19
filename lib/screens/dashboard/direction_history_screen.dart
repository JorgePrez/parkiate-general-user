import 'package:flutter/material.dart';
import 'package:parkline/models/direccion.dart';
import 'package:parkline/models/search_result.dart';
import 'package:parkline/models/user.dart';
import 'package:parkline/pages/mapa_page_copy.dart';
import 'package:parkline/pages/mapa_page_ruta_dir.dart';
import 'package:parkline/screens/dashboard_screen.dart';
import 'package:parkline/screens/parking_code_screen_qr2.dart';

import 'package:parkline/utils/dimensions.dart';
import 'package:parkline/utils/custom_style.dart';
import 'package:parkline/utils/colors.dart';
import 'package:parkline/models/servicioadmin.dart';
import 'package:parkline/utils/shared_pref.dart';

class DirectionHistoryScreen extends StatefulWidget {
  final List<Direccion> listaservicios;

  final String id_usuario;

  DirectionHistoryScreen({Key key, this.listaservicios, this.id_usuario}) : super(key: key);

  @override
  _DirectionHistoryScreenState createState() => _DirectionHistoryScreenState();
}

class _DirectionHistoryScreenState extends State<DirectionHistoryScreen> {

    SharedPref _sharedPref = new SharedPref();



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
                    onTap: () async {

                      

                          User user = User.fromJson(
                      await _sharedPref.read('user') ?? {});

        
                                    Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                DashboardScreen(
                                                  id: user.id,
                                                  email: user.email,
                                                  nombre: user.nombre,
                                                  telefono: user.telefono,
                                                  imagen: user.imagen,
                                                  session_token:
                                                      user.sessionToken,
                                                  modelo_auto: user.modeloAuto,
                                                  placa_auto: user.placaAuto,
                                                  imagen_auto: user.imagenAuto,
                                                  tipo_auto: user.tipoAuto,
                                                )));

                                                
                    },
                  ),
                ),
                SizedBox(
                  height: Dimensions.heightSize ,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: Dimensions.marginSize,
                      right: Dimensions.marginSize),
                  child: Text(
                    'Para ver la ruta en el mapa presiona sobre la dirección',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: Dimensions.largeTextSize ),
                  ),
                ),
                SizedBox(
                  height: Dimensions.heightSize ,
                ),

                  /*ListView(
        children: [
          ListTile(
            leading: Icon(Icons.location_on),
            title: Text('Colocar ubicación manualmente'),
            onTap: () {
               print('Manualmebnte');
              //this.close(context, SearchResult(cancelo: false, manual: true));
            },
          ),
          ...this
              .historial
              .map((result) => ListTile(
                    leading: Icon(Icons.history),
                    title: Text(result.nombreDestino),
                    subtitle: Text(result.descripcion),
                    onTap: () {
                      this.close(context, result);
                    },
                  ))
              .toList()
        ],
      ),
*/

      Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                     child:
                ListView(
                  
        children: [
          ListTile(
            selectedColor: CustomColor.primaryColor,
            selected: true,

            leading: Icon(Icons.location_on),
            title: Text('Agregar nueva dirección'),
            onTap: () {
            //   print('Manualmebnte');

            SearchResult(cancelo: false, manual: true);


              Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => MapaPageCopy(id_usuario: widget.id_usuario)  
                              ));



              
              //this.close(context, SearchResult(cancelo: false, manual: true));
            },
          ),

             SizedBox(
                  height: Dimensions.heightSize ,
                ),

          //TODOS LOS DEMAS LISTTILE VENDRAN DE UNA LISTA que conecta con el backend



           





        ...widget.listaservicios
              .map((result) => ListTile(

                   minVerticalPadding: 10,


                    leading: Icon(Icons.history),
                    title: Text(result.nombre),
                    subtitle: Text(result.nombreDetallado),
                    onTap: () {

                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => MapaPageRutaDir(
                             
                              latitude: double.parse(result.latitude),
                              longitude: double.parse(result.longitude)
                              )));
                      


                    },
                  )
                  
                  
                  )
                  


              .toList()


         
        ],

      ),

      ),

     

    
       
                /*Container(
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
                                                          1))), //0.5
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
                )*/
              ],
            ),
          ),
        ),
      ),
    );
  }
}
