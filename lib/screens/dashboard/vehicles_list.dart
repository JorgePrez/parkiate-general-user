import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:parkline/models/autos_user.dart';
import 'package:parkline/models/visita.dart';
import 'package:parkline/screens/parking_code_screen_details.dart';
import 'package:parkline/screens/parking_code_screen_qr2.dart';

import 'package:parkline/utils/dimensions.dart';
import 'package:parkline/utils/custom_style.dart';
import 'package:parkline/utils/colors.dart';
import 'package:parkline/models/servicioadmin.dart';

class VehiclesList extends StatefulWidget {
  final List<AutosUser> listaautos;

  VehiclesList({Key key, this.listaautos}) : super(key: key);

  @override
  _VehiclesListState createState() => _VehiclesListState();
}

class _VehiclesListState extends State<VehiclesList> {
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
                    'Listado de los autos registrados',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: Dimensions.extraLargeTextSize),
                  ),
                ),
                SizedBox(
                  height: Dimensions.heightSize,
                ),
                Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: ListView.builder(
                      itemCount: widget.listaautos.length,
                      itemBuilder: (context, index) {
                        AutosUser auto = widget.listaautos[index];

                        String temporal_fecha =
                            auto.fechaRegistroAuto.substring(1, 11);

                        List<String> temporal_fecha_slipt =
                            temporal_fecha.split('-');

                        String dia = temporal_fecha_slipt[2].trim();
                        String mes = temporal_fecha_slipt[1];
                        String anio = temporal_fecha_slipt[0];

                        String fecha = '${dia}/${mes}/${anio}';

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
                                Expanded(
                                  flex: 1, //1
                                  child: GestureDetector(
                                    onTap: () {},
                                    child: Image.network(auto.fotoDelante),
                                  ),
                                ),
                                Expanded(
                                  flex: 1, //
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center, //.start
                                    children: [
                                      SizedBox(
                                          height: Dimensions.heightSize *
                                              0.5), //heightSize
                                      Text(
                                        '   Placa : ${auto.placa}',
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
                                            '   Registro: $fecha',
                                            style: CustomStyle.textStyle,
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
