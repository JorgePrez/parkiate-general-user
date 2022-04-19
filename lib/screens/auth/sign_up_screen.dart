import 'package:flutter/material.dart';
import 'package:parkline/models/response_api.dart';
import 'package:parkline/models/user.dart';
import 'package:parkline/providers/usuarios_provider.dart';
import 'package:parkline/screens/success_screen.dart';
import 'package:parkline/utils/colors.dart';
import 'package:parkline/utils/custom_style.dart';
import 'package:parkline/utils/dimensions.dart';
import 'package:parkline/services/services.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  UsuarioProvider usuarioProvider = new UsuarioProvider();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController telefonoController = TextEditingController();
  TextEditingController nombreController = TextEditingController();

  bool _toggleVisibility = true;

  DateTime selectedDate = DateTime.now();
  String dateOfBirth = 'Date of Birth';
  bool checkTermsConditions = false;

  @override
  Widget build(BuildContext context) {
    usuarioProvider.init(context); //iniciando

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(
                  left: Dimensions.marginSize,
                  top: Dimensions.marginSize * 2,
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
            signUpWidget(context)
          ],
        ),
      ),
    );
  }

  Widget signUpWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          left: Dimensions.defaultPaddingSize,
          right: Dimensions.defaultPaddingSize),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Crear una cuenta',
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
                    controller: nombreController,
                    keyboardType: TextInputType.name,
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Por favor completa el campo';
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                      labelText: "Nombre (Primer Nombre + Primer Apellido)",
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
                    controller: telefonoController,
                    keyboardType: TextInputType.phone,
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Por favor completa el campo';
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                      labelText: "Número de Teléfono",
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
                  TextFormField(
                    style: CustomStyle.textStyle,
                    controller: confirmPasswordController,
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Por favor completa el campo';
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                      labelText: 'Repetir Contraseña',
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 10.0),
                      labelStyle: CustomStyle.textStyle,
                      focusedBorder: CustomStyle.focusBorder,
                      enabledBorder: CustomStyle.focusErrorBorder,
                      focusedErrorBorder: CustomStyle.focusErrorBorder,
                      errorBorder: CustomStyle.focusErrorBorder,
                      filled: true,
                      fillColor: Colors.white,
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
                      hintStyle: CustomStyle.textStyle,
                    ),
                    obscureText: _toggleVisibility,
                  ),
                  SizedBox(height: Dimensions.heightSize),
                ],
              )),
          SizedBox(height: Dimensions.heightSize),
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
                  'CREAR UNA CUENTA',
                  style: TextStyle(
                      color: Colors.white, fontSize: Dimensions.largeTextSize),
                ),
              ),
            ),
            onTap: () async {
              String email = emailController.text.trim();
              String nombre = nombreController.text.trim();
              String telefono = telefonoController.text.trim();
              String password = passwordController.text.trim();
              String confirmpassword = confirmPasswordController.text.trim();

              if (email.isEmpty ||
                  nombre.isEmpty ||
                  telefono.isEmpty ||
                  password.isEmpty ||
                  confirmpassword.isEmpty) {
                NotificationsService.showSnackbar(
                    "Debes ingresar todos los campos");
                return;
              }

              if (confirmpassword != password) {
                NotificationsService.showSnackbar(
                    "Las contraseñas no coinciden");
                return;
              }

              if (password.length < 6) {
                NotificationsService.showSnackbar(
                    "Las contraseñas debe tener al menos 6 caracteres");
                return;
              }

              User user = new User(
                  email: emailController.text.trim(),
                  nombre: nombreController.text.trim(),
                  telefono: telefonoController.text.trim(),
                  imagen:
                      'https://res.cloudinary.com/parkiate-ki/image/upload/v1637572305/profile_f9zx3b.png',
                  password: passwordController.text.trim(),
                  modeloAuto: "N/A",
                  placaAuto: "N/A",
                  imagenAuto:
                      'https://res.cloudinary.com/parkiate-ki/image/upload/v1637573619/vehicle_rjori6.png',
                  tipoAuto: "V");

              ResponseApi responseApi = await usuarioProvider.create(user);
              //${} permtie llamar metodos dentro del objeto

              print('RESPUESTA: ${responseApi.toJson()}');

              if (responseApi.success) {
                NotificationsService.showSnackbar(responseApi.message);

                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => SuccessScreen()));
              } else {
                NotificationsService.showSnackbar(responseApi.message);
              }
            },
          ),
          SizedBox(height: Dimensions.heightSize * 2),
        ],
      ),
    );
  }
}
