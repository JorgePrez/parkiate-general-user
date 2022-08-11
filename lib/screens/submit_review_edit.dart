import 'package:flutter/material.dart';
import 'package:parkline/models/resenia_app.dart';
import 'package:parkline/models/usuarios_app.dart';
import 'package:parkline/providers/usuarios_app_provider.dart';
import 'package:parkline/utils/dimensions.dart';
import 'package:parkline/utils/custom_style.dart';
import 'package:parkline/utils/colors.dart';
import 'package:parkline/screens/dashboard_screen.dart';
import 'package:parkline/providers/usuarios_provider.dart';
import 'package:parkline/models/response_api.dart';
import 'package:parkline/models/user.dart';
import 'package:parkline/utils/shared_pref.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:intl/intl.dart';

import 'package:parkline/providers/resenias_provider.dart';

class SubmitReviewEdit extends StatefulWidget {
  final String idusuario, idparqueo, comentario, imagenusuario;
  final double rating;

  SubmitReviewEdit(
      {Key key,
      this.idusuario,
      this.idparqueo,
      this.comentario,
      this.imagenusuario,
      this.rating})
      : super(key: key);

  @override
  _SubmitReviewEditState createState() => _SubmitReviewEditState();
}

class _SubmitReviewEditState extends State<SubmitReviewEdit> {
  TextEditingController commentController = TextEditingController();

  UsuarioProvider usuarioProvider = new UsuarioProvider();
  double valoracion = 5.0;

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
    double rating = widget.rating;

    final DateTime now = DateTime.now();

    final DateFormat formatter = DateFormat('dd-MM-yyyy');
    final String formatted = formatter.format(now);

    final ReseniasProvider reseniasProvider = new ReseniasProvider();
    final UsuarioAppProvider usuarioAppProvider = new UsuarioAppProvider();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: Dimensions.heightSize * 3),
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
                controller: commentController..text = widget.comentario,
                keyboardType: TextInputType.name,
                validator: (String value) {
                  if (value.isEmpty) {
                    return 'Por favor completa el campo';
                  } else {
                    return null;
                  }
                },
                decoration: InputDecoration(
                  hintText: 'Nos ayudan en el proceso de mejora continua',
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
                      'Editar Reseña'.toUpperCase(),
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: Dimensions.largeTextSize,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                onTap: () async {
                  String comentario = commentController.text.trim();
                  print('Comentario: $comentario');

                  Resenia_app resenia = new Resenia_app(
                      idUsuarioMovil: widget.idusuario,
                      idParqueo: widget.idparqueo,
                      calificacion: rating.toString(),
                      comentario: comentario);

                  ResponseApi responseApir =
                      await reseniasProvider.create_update(resenia);

                  if (responseApir.success) {
                    ResponseApi user_app_true = await usuarioAppProvider
                        .getById(int.parse(widget.idusuario)); //○8

                    UsuarioApp user2 = UsuarioApp.fromJson(user_app_true.data);

                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => DashboardScreen(
                              nombre_usuario: user2.nombre,
                              email_usuario: user2.email,
                              foto_perfil: user2.fotoPerfil,
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
