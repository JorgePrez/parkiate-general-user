import 'package:flutter/material.dart';

import 'package:parkline/utils/dimensions.dart';
import 'package:parkline/utils/custom_style.dart';
import 'package:parkline/utils/colors.dart';
import 'package:parkline/utils/shared_pref.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:parkline/providers/usuarios_provider.dart';
import 'package:parkline/models/response_api.dart';
import 'package:parkline/services/services.dart';
import 'package:parkline/screens/dashboard_screen.dart';
import 'package:parkline/models/user.dart';

//TODO: UNUSED

class MyAccountScreen extends StatefulWidget {
  final String id,
      email,
      nombre,
      telefono,
      imagen,
      session_token,
      modelo_auto,
      placa_auto,
      imagen_auto,
      tipo_auto;

  MyAccountScreen({
    Key key,
    this.id,
    this.email,
    this.nombre,
    this.telefono,
    this.imagen,
    this.session_token,
    this.modelo_auto,
    this.placa_auto,
    this.imagen_auto,
    this.tipo_auto,
  }) : super(key: key);

  @override
  _MyAccountScreenState createState() => _MyAccountScreenState();
}

class _MyAccountScreenState extends State<MyAccountScreen> {
  File _image;
  String finalpath;

  // Condiciones de que si no cambian las imagen

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController emailController;
  TextEditingController phoneController;
  TextEditingController addressController = TextEditingController();
  UsuarioProvider usuarioProvider = new UsuarioProvider();
  SharedPref _sharedPref = new SharedPref();

  @override
  Widget build(BuildContext context) {
    emailController = TextEditingController(text: widget.email);
    phoneController = TextEditingController(text: widget.telefono);

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          height: MediaQuery.of(context).size.height,
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
              SizedBox(
                height: Dimensions.heightSize * 1, //2
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: Dimensions.marginSize, right: Dimensions.marginSize),
                child: Text(
                  'Mi cuenta',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: Dimensions.extraLargeTextSize * 1), //1.5
                ),
              ),
              SizedBox(
                height: Dimensions.heightSize * 1, //1.5
              ),
              bodyWidget(context)
            ],
          ),
        ),
      ),
    );
  }

  bodyWidget(BuildContext context) {
    return Column(children: [
      addImageWidget(context),
      SizedBox(
        height: Dimensions.heightSize,
      ),
      Padding(
        padding: const EdgeInsets.only(
          left: Dimensions.marginSize,
          right: Dimensions.marginSize,
        ),
        child: Column(
          children: [
            Text(
              '${widget?.nombre ?? ''}',
              style: TextStyle(
                  fontSize: Dimensions.extraLargeTextSize * 1, //1.5
                  color: Colors.black),
            ),
            SizedBox(
              height: Dimensions.heightSize * 0.5,
            ),
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(
          left: Dimensions.marginSize,
          right: Dimensions.marginSize,
          top: Dimensions.heightSize * 1, //3
        ),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              Container(
                height: 60.0, //70
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black.withOpacity(0.1)),
                    borderRadius: BorderRadius.circular(Dimensions.radius)),
                child: TextFormField(
                  style: CustomStyle.textStyle,
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  //initialValue: "adadadas",

                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Por favor completa el campo';
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                    labelText: 'Correo Electrónico',
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                    labelStyle: CustomStyle.textStyle,
                    filled: true,
                    fillColor: Colors.white,
                    hintStyle: CustomStyle.listStyle,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedErrorBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                  ),
                ),
              ),
              SizedBox(
                height: Dimensions.heightSize,
              ),
              Container(
                height: 60.0, //70
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black.withOpacity(0.1)),
                    borderRadius: BorderRadius.circular(Dimensions.radius)),
                child: TextFormField(
                  style: CustomStyle.textStyle,
                  controller: phoneController,
                  keyboardType: TextInputType.text,
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Por favor completa el campo';
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                    labelText: 'Teléfono',
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                    labelStyle: CustomStyle.textStyle,
                    filled: true,
                    fillColor: Colors.white,
                    hintStyle: CustomStyle.listStyle,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedErrorBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                  ),
                ),
              ),
              SizedBox(
                height: Dimensions.heightSize,
              ),
            ],
          ),
        ),
      ),
      SizedBox(
        height: Dimensions.heightSize * 1, //3
      ),
      Padding(
        padding: const EdgeInsets.only(
          left: Dimensions.marginSize,
          right: Dimensions.marginSize,
        ),
        child: GestureDetector(
          child: Container(
            height: 30.0, //50.00
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: CustomColor.secondaryColor,
                borderRadius:
                    BorderRadius.all(Radius.circular(Dimensions.radius))),
            child: Center(
              child: Text(
                'ACTUALIZAR CUENTA',
                style: TextStyle(
                    color: CustomColor.primaryColor,
                    fontSize: Dimensions.largeTextSize,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          onTap: () async {
            final String imageUrl =
                await usuarioProvider.uploadImage(finalpath);

            String email = emailController.text.trim();
            String telefono = phoneController.text.trim();

            ResponseApi responseApi = await usuarioProvider.update(
                int.parse(widget.id), email, widget.nombre, telefono, imageUrl);

            if (responseApi.success) {
              NotificationsService.showSnackbar("Actualizado correctamente");

              ResponseApi responseApi2 =
                  await usuarioProvider.getById(int.parse(widget.id));

              print('Respuesta object: ${responseApi2}');
              print('RESPUESTA: ${responseApi2.toJson()}');

              if (responseApi2.success) {
                User user = User.fromJson(responseApi2.data);
                //   _sharedPref.logout();
                _sharedPref.save('user', user.toJson());

                Navigator.of(context).push(MaterialPageRoute(
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
                NotificationsService.showSnackbar(responseApi2.message);
              }
            } else {
              NotificationsService.showSnackbar(responseApi.message);
            }
          },
        ),
      ),
    ]);
  }

  addImageWidget(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Stack(children: <Widget>[
        Container(
          height: 125, //150
          width: 125, //150
          padding: EdgeInsets.all(1),
          decoration: BoxDecoration(
            color: CustomColor.secondaryColor,
            borderRadius: BorderRadius.circular(75.0),
          ),
          child: _image == null
              // ? Image.asset('assets/images/profile.png')
              ? Image.network(widget.imagen)
              : Image.file(
                  _image,
                  fit: BoxFit.cover,
                ),
        ),
        Positioned(
          right: 0,
          bottom: 20,
          child: Container(
            height: 40.0,
            width: 40.0,
            decoration: BoxDecoration(
                color: CustomColor.primaryColor,
                borderRadius: BorderRadius.circular(20.0)),
            child: IconButton(
              onPressed: () {
                _openImageSourceOptions(context);
              },
              padding: EdgeInsets.only(left: 5, right: 5),
              iconSize: 24,
              icon: Icon(
                Icons.camera_enhance,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ]),
    );
  }

  Future<void> _openImageSourceOptions(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  child: Icon(
                    Icons.camera_alt,
                    size: 40.0,
                    color: Colors.blue,
                  ),
                  onTap: () {
                    Navigator.of(context).pop();
                    _chooseFromCamera();
                  },
                ),
                GestureDetector(
                  child: Icon(
                    Icons.photo,
                    size: 40.0,
                    color: Colors.green,
                  ),
                  onTap: () {
                    Navigator.of(context).pop();
                    _chooseFromGallery();
                  },
                ),
              ],
            ),
          );
        });
  }

  File file;
  void _chooseFromGallery() async {
    // ignore: deprecated_member_use
    file = await ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 40);

    //  print('tenemos imagen ${file.path}');
    //path: null nada , path:http producto ya en la nube, mostrar con network image
    // path real telefon, http

    if (file == null) {
      //Si esto es nulo es porque el usuario no subio no imagen

      Fluttertoast.showToast(msg: 'No File Selected');
    } else {
      //   print('tenemos imagen ${file.path}');
      finalpath = file.path;

      // print(widget.finalpath);

      setState(() {
        _image = file;
      });
      //_upload();
    }
    // file.path;
  }

  _chooseFromCamera() async {
    print('open camera');
    //ignore: deprecated_member_use
    file = await ImagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 20);

    print('picked camera');
    if (file == null) {
      Fluttertoast.showToast(msg: 'No Capture Image');
    } else {
      //   print('tenemos imagen ${file.path}');
      finalpath = file.path;

      // print(widget.finalpath);

      setState(() {
        _image = file;
      });
      //_upload();
    }
  }
}
