import 'package:flutter/material.dart';
import 'package:parkline/models/resenia.dart';
import 'package:parkline/utils/dimensions.dart';
import 'package:parkline/utils/custom_style.dart';
import 'package:parkline/utils/colors.dart';
import 'package:parkline/screens/dashboard_screen.dart';
import 'package:parkline/providers/usuarios_provider.dart';
import 'package:parkline/models/response_api.dart';
import 'package:parkline/services/services.dart';
import 'package:parkline/models/user.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:intl/intl.dart';

import 'package:parkline/providers/resenias_provider.dart';
import 'package:provider/provider.dart';

class SubmitReviewScreen extends StatefulWidget {
  final String idusuario, idparqueo, nombreusuario, imagenusuario;
  //double rating = 5.0;

  SubmitReviewScreen(
      {Key key,
      this.idusuario,
      this.idparqueo,
      this.nombreusuario,
      this.imagenusuario})
      : super(key: key);

  @override
  _SubmitReviewScreenState createState() => _SubmitReviewScreenState();
}

class _SubmitReviewScreenState extends State<SubmitReviewScreen> {
  TextEditingController commentController = TextEditingController();
  UsuarioProvider usuarioProvider = new UsuarioProvider();
  double valoracion = 5.0;
  double rating = 5.0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: bodyWidget(context),
        ),
      ),
    );
  }

  bodyWidget(BuildContext context) {
    final DateTime now = DateTime.now();

    final DateFormat formatter = DateFormat('dd-MM-yyyy');
    final String formatted = formatter.format(now);

    final ReseniasProvider reseniasProvider = new ReseniasProvider();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: Dimensions.heightSize * 3),
        Padding(
          padding: EdgeInsets.only(
            left: Dimensions.marginSize,
            right: Dimensions.marginSize,
          ),
        ),
        SizedBox(
          height: Dimensions.heightSize * 1, //2
        ),
        Padding(
          padding: const EdgeInsets.only(
              left: Dimensions.marginSize, right: Dimensions.marginSize),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Tu calificación del parqueo',
                style: TextStyle(
                    fontSize: Dimensions.extraLargeTextSize,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              SizedBox(
                height: Dimensions.heightSize,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center, //.start
                      children: [
                        Text(
                          'Tu Valoración',
                          style: TextStyle(
                              fontSize: Dimensions.largeTextSize,
                              color: Colors.black),
                        ),
                        SizedBox(
                          height: Dimensions.heightSize * 0.5, //0.5
                        ),
                        /*MyRating(
                            // rating: '5',
                            )*/
                        SmoothStarRating(
                          allowHalfRating: true,
                          onRated: (v) {
                            // print("rating value-> $v");
                            rating = v;
                            //  var valor = rating;
                            print('rating: $rating');
                          },
                          starCount: 5,
                          rating: rating,
                          size: 40.0,
                          isReadOnly: false,
                          filledIconData: Icons.star,
                          halfFilledIconData: Icons.star_half,
                          color: CustomColor.primaryColor,
                          borderColor: CustomColor.secondaryColor,
                          spacing: 0.0,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: Dimensions.heightSize * 1.5, //2
              ),

              SizedBox(
                height: Dimensions.heightSize * 1.5,
              ), //3
              Text(
                'Tus comentarios',
                style: TextStyle(
                    fontSize: Dimensions.extraLargeTextSize,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              SizedBox(height: Dimensions.heightSize),
              TextFormField(
                style: CustomStyle.textStyle,
                controller: commentController,
                keyboardType: TextInputType.name,
                validator: (String value) {
                  if (value.isEmpty) {
                    return 'Por favor completa el campo';
                  } else {
                    return null;
                  }
                },
                decoration: InputDecoration(
                  hintText: 'Nos ayuda en el proceso de mejora continua',
                  contentPadding: EdgeInsets.symmetric(
                      vertical: 29.0, horizontal: 4.0), // 40.0  - 10.0
                  labelStyle: CustomStyle.textStyle,
                  filled: true,
                  fillColor: Colors.white,
                  hintStyle: CustomStyle.hintTextStyle,
                  focusedBorder: CustomStyle.focusBorder,
                  enabledBorder: CustomStyle.focusErrorBorder,
                  focusedErrorBorder: CustomStyle.focusErrorBorder,
                  errorBorder: CustomStyle.focusErrorBorder,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: Dimensions.heightSize * 1.5, //3
        ),
        Padding(
          padding: const EdgeInsets.only(
              left: Dimensions.marginSize, right: Dimensions.marginSize),
          child: Column(
            children: [
              GestureDetector(
                child: Container(
                  height: 50.0,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: CustomColor.primaryColor,
                      borderRadius: BorderRadius.all(
                          Radius.circular(Dimensions.radius * 0.5))),
                  child: Center(
                    child: Text(
                      'Enviar Reseña'.toUpperCase(),
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: Dimensions.largeTextSize,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                onTap: () async {
                  final authService =
                      Provider.of<AuthService>(context, listen: false);

                  await authService.logout2();

                       await authService.clear_latitude();

                  await authService.clear_longitude();

                  String comentario = commentController.text.trim();
                  print('Comentario: $comentario');

                  print('rating: $rating');

                  Resenia resenia = new Resenia(
                      nombreUsuario: widget.nombreusuario,
                      imagenUsuario: widget.imagenusuario,
                      fecha: formatted,
                      calificacion: rating.toString(),
                      comentario: comentario,
                      idParqueo: widget.idparqueo);

                  ResponseApi responseApi =
                      await reseniasProvider.create(resenia);

                  print('RESPUESTA: ${responseApi.toJson()}');

                  ResponseApi responseApi2 = await usuarioProvider
                      .getById(int.parse(widget.idusuario));

                  print('Respuesta object: ${responseApi2}');
                  print('RESPUESTA: ${responseApi2.toJson()}');

                  if (responseApi2.success) {
                    User user = User.fromJson(responseApi2.data);

                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DashboardScreen(
                                  id: user.id,
                                  email: user.email,
                                  nombre: user.nombre,
                                  telefono: user.telefono,
                                  imagen: user.imagen,
                                  session_token: user.sessionToken,
                                  modelo_auto: user.modeloAuto,
                                  placa_auto: user.placaAuto,
                                  imagen_auto: user.imagenAuto,
                                  tipo_auto: user.tipoAuto,
                                )));
                  } else {
                    // NotificationsService.showSnackbar(responseApi2.message);
                  }
                },
              ),
              SizedBox(
                height: Dimensions.heightSize,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
