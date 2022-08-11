import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:parkline/models/usuarios_app.dart';
import 'package:parkline/providers/usuarios_app_provider.dart';
import 'package:parkline/utils/colors.dart';
import 'package:parkline/utils/custom_style.dart';
import 'package:parkline/utils/dimensions.dart';
import 'package:parkline/utils/shared_pref.dart';
import 'package:parkline/screens/dashboard_screen.dart';
import 'package:parkline/models/response_api.dart';
import 'package:parkline/services/services.dart';
import 'package:parkline/providers/usuarios_provider.dart';
import 'package:parkline/models/user.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  UsuarioProvider usuarioProvider = new UsuarioProvider();
  UsuarioAppProvider usuarioAppProvider = new UsuarioAppProvider();
  SharedPref _sharedPref = new SharedPref();

  bool _toggleVisibility = true;

  @override
  Widget build(BuildContext context) {
    usuarioProvider.init(context); //iniciando servicios

    // User user = User.fromJson(await _sharedPref.read('user'));

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      left: Dimensions.marginSize,
                      top: Dimensions.marginSize,
                      bottom: Dimensions.marginSize),
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
                signInWidget(context)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget signInWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          left: Dimensions.defaultPaddingSize,
          right: Dimensions.defaultPaddingSize),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Entra a tu cuenta',
            style: TextStyle(
                color: Colors.black,
                fontSize: Dimensions.extraLargeTextSize * 1.5),
          ),
          SizedBox(
            height: Dimensions.heightSize * 2,
          ),
          Form(
              key: formKey,
              child: Column(
                children: [
                  TextFormField(
                    style: CustomStyle.textStyle,
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Por favor completa el campo';
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                      labelText: 'Correo Electrónico',
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 10.0),
                      labelStyle: CustomStyle.textStyle,
                      filled: true,
                      fillColor: Colors.white,
                      hintStyle: CustomStyle.textStyle,
                      focusedBorder: CustomStyle.focusBorder,
                      enabledBorder: CustomStyle.focusErrorBorder,
                      focusedErrorBorder: CustomStyle.focusErrorBorder,
                      errorBorder: CustomStyle.focusErrorBorder,
                    ),
                  ),
                  SizedBox(
                    height: Dimensions.heightSize,
                  ),
                  TextFormField(
                    style: CustomStyle.textStyle,
                    controller: passwordController,
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Por favor completa el campo';
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                      labelText: 'Contraseña',
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 10.0),
                      labelStyle: CustomStyle.textStyle,
                      focusedBorder: CustomStyle.focusBorder,
                      enabledBorder: CustomStyle.focusErrorBorder,
                      focusedErrorBorder: CustomStyle.focusErrorBorder,
                      errorBorder: CustomStyle.focusErrorBorder,
                      filled: true,
                      fillColor: Colors.white,
                      hintStyle: CustomStyle.textStyle,
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _toggleVisibility = !_toggleVisibility;
                          });
                        },
                        icon: _toggleVisibility
                            ? Icon(
                                Icons.visibility_off,
                                color: Colors.black,
                              )
                            : Icon(
                                Icons.visibility,
                                color: Colors.black,
                              ),
                      ),
                    ),
                    obscureText: _toggleVisibility,
                  ),
                  SizedBox(height: Dimensions.heightSize),
                ],
              )),
          SizedBox(height: Dimensions.heightSize * 3),
          GestureDetector(
            child: Container(
              height: 50.0,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: CustomColor.primaryColor,
                  borderRadius:
                      BorderRadius.all(Radius.circular(Dimensions.radius))),
              child: Center(
                child: Text(
                  'INICIAR SESIÓN',
                  style: TextStyle(
                      color: Colors.white, fontSize: Dimensions.largeTextSize),
                ),
              ),
            ),
            onTap: () async {
              String email = emailController.text.trim();
              String password = passwordController.text.trim();

              ResponseApi responseApitrue =
                  await usuarioAppProvider.login(email, password);

              if (responseApitrue.success) {
                UsuarioApp user_app = UsuarioApp.fromJson(responseApitrue.data);
                _sharedPref.save('usuario_app', user_app.toJson());

                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => DashboardScreen(
                          nombre_usuario: user_app.nombre,
                          email_usuario: user_app.email,
                          foto_perfil: user_app.fotoPerfil,
                        )));
              } else {
                return showInfoFlushbar1(
                    context, 'Login Fallido', responseApitrue.message);
              }
            },
          ),
          SizedBox(height: Dimensions.heightSize * 3),
        ],
      ),
    );
  }

  void showInfoFlushbar1(
      BuildContext context, String mensaje1, String mensaje2) {
    Flushbar(
      title: mensaje1,
      message: mensaje2,
      icon: Icon(
        Icons.cancel_rounded,
        size: 28,
        color: CustomColor.redColor,
      ),
      leftBarIndicatorColor: CustomColor.redColor,
      duration: Duration(seconds: 3),
    )..show(context);
  }
}
