import 'package:flutter/material.dart';
import 'package:parkline/models/fresenias.dart';
import 'package:parkline/models/response_api.dart';
import 'package:parkline/models/user.dart';
import 'package:parkline/providers/parqueos_provider.dart';
import 'package:parkline/providers/usuarios_provider.dart';

import 'package:parkline/screens/dashboard_screen.dart';
import 'package:parkline/services/auth_service.dart';

import 'package:parkline/utils/dimensions.dart';
import 'package:parkline/utils/custom_style.dart';
import 'package:parkline/utils/colors.dart';
import 'package:parkline/screens/submit_review_screen.dart';
import 'package:provider/provider.dart';

//TODO: no esta en uso.

class PaymentScreen extends StatefulWidget {
  final String idservicio, precio, idusuario, idparqueo;
  final String duracion;
  final String nombreusuario, imagenusuario;

  PaymentScreen(
      {Key key,
      this.idservicio,
      this.precio,
      this.duracion,
      this.idusuario,
      this.idparqueo,
      this.nombreusuario,
      this.imagenusuario})
      : super(key: key);

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

enum SingingCharacter { cash, card, mobileBanking }

class _PaymentScreenState extends State<PaymentScreen> {
  SingingCharacter _character = SingingCharacter.cash;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: const EdgeInsets.only(top: Dimensions.heightSize * 2),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      left: Dimensions.marginSize,
                      right: Dimensions.marginSize,
                    ),
                  ),
                  SizedBox(
                    height: Dimensions.heightSize * 2,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: Dimensions.heightSize * 3,
                        left: Dimensions.marginSize,
                        right: Dimensions.marginSize),
                    child: Text(
                      'Pago del servicio actual:',
                      style: TextStyle(
                          fontSize: Dimensions.extraLargeTextSize,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ),
                  SizedBox(
                    height: Dimensions.heightSize * 2,
                  ),
                  invoiceWidget(context),
                  SizedBox(
                    height: Dimensions.heightSize * 2,
                  ),
                  cardWidget(context)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  invoiceWidget(BuildContext context) {
    String horas = widget.duracion.substring(0, 1);
    String minutos = widget.duracion.substring(2);

    return Padding(
      padding: const EdgeInsets.only(
          left: Dimensions.marginSize, right: Dimensions.marginSize),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Id del servicio actual:',
                    style: CustomStyle.textStyle,
                  ),
                  SizedBox(
                    height: Dimensions.heightSize * 0.5,
                  ),
                  Text(
                    widget.idservicio,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: Dimensions.defaultTextSize),
                  ),
                ],
              ),
              //  Icon(Icons.copy)
            ],
          ),
          SizedBox(height: Dimensions.heightSize),
          Container(
            height: 150.0,
            decoration: BoxDecoration(
                color: CustomColor.secondaryColor,
                borderRadius:
                    BorderRadius.all(Radius.circular(Dimensions.radius))),
            child: Padding(
              padding: const EdgeInsets.all(Dimensions.marginSize),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Tiempo(${horas} horas con ${minutos} minutos )',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: Dimensions.defaultTextSize),
                      ),
                      Text(
                        'Q${widget.precio}.00', //112
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: Dimensions.defaultTextSize),
                      ),
                    ],
                  ),
                  Divider(
                    color: Colors.black.withOpacity(0.5),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: Dimensions.defaultTextSize),
                      ),
                      Text(
                        'Q${widget.precio}.00',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: Dimensions.defaultTextSize),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  cardWidget(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(Dimensions.marginSize * 2),
            topRight: Radius.circular(Dimensions.marginSize * 2)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.only(
            top: Dimensions.heightSize * 3,
            left: Dimensions.marginSize,
            right: Dimensions.marginSize),
        child: Column(
          children: [
            Container(
              height: 60.0,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black.withOpacity(0.1)),
                  borderRadius:
                      BorderRadius.all(Radius.circular(Dimensions.radius))),
              child: ListTile(
                title: Text(
                  'EN EFECTIVO',
                  style: CustomStyle.textStyle,
                ),
                leading: Radio(
                  value: SingingCharacter.cash,
                  toggleable: true,
                  autofocus: true,
                  groupValue: _character,
                  onChanged: (SingingCharacter value) {
                    setState(() {
                      _character = value;
                      print('value: ' + _character.toString());
                    });
                  },
                ),
              ),
            ),
            SizedBox(
              height: Dimensions.heightSize,
            ),
            _character.toString() == 'SingingCharacter.card'
                ? Column(
                    children: [],
                  )
                : Container(),
            SizedBox(
              height: Dimensions.heightSize,
            ),
            SizedBox(
              height: Dimensions.heightSize * 1.5, //2
            ),
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
                    'YA HE PAGADO',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: Dimensions.largeTextSize,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              onTap: () async {
                final ParqueosProvider parqueosProvider =
                    new ParqueosProvider();
                final UsuarioProvider usuarioProvider = new UsuarioProvider();

                ResponseApi responseApiespacios = await parqueosProvider
                    .getreviews(widget.idparqueo, widget.nombreusuario);

                Fresenias fresenias =
                    Fresenias.fromJson(responseApiespacios.data);

                String ocupados = fresenias.cantidadResenias;
                int cantidadDeResenias = int.parse(ocupados);

                if (cantidadDeResenias > 0) {
                  final authService =
                      Provider.of<AuthService>(context, listen: false);

                  await authService.logout2();

                  await authService.clear_latitude();

                  await authService.clear_longitude();

                  ResponseApi responseApi2 = await usuarioProvider
                      .getById(int.parse(widget.idusuario));

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

                  //Obtener todos los datos que le permiten navegar
                } else {
                  _showPaymentSuccessDialog();
                }
              },
            )
          ],
        ),
      ),
    );
  }

  Future<bool> _showPaymentSuccessDialog() async {
    return (await showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) => new AlertDialog(
            content: Container(
              height: MediaQuery.of(context).size.height * 0.5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset('assets/images/thanks.png'),
                  Text(
                    'Gracias por utilizar la aplicación Parkiate-ki, ahora califica el servicio del parqueo actual', // Strings.nowCheckYourEmail2,
                    style: TextStyle(
                      fontSize: Dimensions.extraLargeTextSize,
                      color: CustomColor.primaryColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  GestureDetector(
                    child: Container(
                      height: 60.0,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: Color(0xFFF5F5F6),
                          borderRadius: BorderRadius.all(
                              Radius.circular(Dimensions.radius))),
                      child: Center(
                        child: Text(
                          'Danos tu reseña'.toUpperCase(),
                          style: TextStyle(
                              fontSize: Dimensions.extraLargeTextSize,
                              color: CustomColor.primaryColor,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => SubmitReviewScreen(
                              idusuario: widget.idusuario,
                              idparqueo: widget.idparqueo,
                              nombreusuario: widget.nombreusuario,
                              imagenusuario: widget.imagenusuario)));
                    },
                  )
                ],
              ),
            ),
          ),
        )) ??
        false;
  }
}
