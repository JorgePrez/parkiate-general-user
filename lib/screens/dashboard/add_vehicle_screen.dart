import 'package:flutter/material.dart';

import 'package:parkline/utils/dimensions.dart';
import 'package:parkline/utils/custom_style.dart';
import 'package:parkline/utils/colors.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:parkline/providers/usuarios_provider.dart';
import 'package:parkline/models/user.dart';
import 'package:parkline/services/services.dart';
import 'package:parkline/utils/shared_pref.dart';
import 'package:parkline/screens/dashboard_screen.dart';
import 'package:parkline/models/response_api.dart';

class AddVehicleScreen extends StatefulWidget {
  final String id, email, modelo_auto, placa_auto, imagen_auto, tipo_auto;

  AddVehicleScreen(
      {Key key,
      this.id,
      this.email,
      this.modelo_auto,
      this.placa_auto,
      this.imagen_auto,
      this.tipo_auto})
      : super(key: key);

  @override
  _AddVehicleScreenState createState() => _AddVehicleScreenState();
}

class _AddVehicleScreenState extends State<AddVehicleScreen> {
  File _image;
  String finalpath;
  String selectVehicleType;
  String select2;

  @override
  void initState() {
    if (widget.tipo_auto == 'V') {
      selectVehicleType = 'Automóvil';
    } else if (widget.tipo_auto == 'M') {
      selectVehicleType = 'Motocicleta';
    } else if (widget.tipo_auto == 'A') {
      selectVehicleType = 'Autobus';
    } else if (widget.tipo_auto == 'C') {
      selectVehicleType = 'Camión';
    }

    super.initState();
  }

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  List<dynamic> vehicleTypeList = [
    'Automóvíl',
    'Motocicleta',
    'Autobus',
    'Camión'
  ];

  TextEditingController licenseController;
  TextEditingController modelController;
  UsuarioProvider usuarioProvider = new UsuarioProvider();
  SharedPref _sharedPref = new SharedPref();

  @override
  Widget build(BuildContext context) {
    //selectVehicleType = 'Automóvíl';

    if (widget.placa_auto == 'N/A') {
      licenseController = TextEditingController();
    } else {
      licenseController = TextEditingController(text: widget.placa_auto);
    }

    if (widget.modelo_auto == 'N/A') {
      modelController = TextEditingController();
    } else {
      modelController = TextEditingController(text: widget.modelo_auto);
    }

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
                height: Dimensions.heightSize * 1, // 2
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: Dimensions.marginSize, right: Dimensions.marginSize),
                child: Text(
                  'Mi Vehículo',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: Dimensions.extraLargeTextSize * 1), // 1.5
                ),
              ),
              SizedBox(
                height: Dimensions.heightSize * 1, //2
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
      Padding(
        padding: const EdgeInsets.only(
            left: Dimensions.marginSize,
            right: Dimensions.marginSize,
            top: Dimensions.heightSize * 1 //*2
            ),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              Container(
                height: 70.0, //50.0
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black.withOpacity(0.1)),
                    borderRadius: BorderRadius.circular(Dimensions.radius)),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: Dimensions.marginSize,
                      right: Dimensions.marginSize,
                      top: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Tipo de Vehículo',
                        style: TextStyle(
                            color: Colors.black.withOpacity(0.4),
                            fontSize: Dimensions.smallTextSize),
                      ),
                      DropdownButton<String>(
                        items: vehicleTypeList.map((value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: Dimensions.defaultTextSize),
                            ),
                          );
                        }).toList(),
                        hint: Text(
                          selectVehicleType,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: Dimensions.defaultTextSize),
                        ),
                        onChanged: (value) {
                          setState(() {
                            selectVehicleType = value;
                          });
                        },
                        underline: Container(),
                        isExpanded: true,
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: Dimensions.heightSize,
              ),
              Container(
                height: 60.0, // 70.00
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black.withOpacity(0.1)),
                    borderRadius: BorderRadius.circular(Dimensions.radius)),
                child: TextFormField(
                  style: CustomStyle.textStyle,
                  controller: licenseController,
                  keyboardType: TextInputType.emailAddress,
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Por favor completa el campo';
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                    labelText: 'Número de Placa',
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
                height: 60.0, // 70.0
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black.withOpacity(0.1)),
                    borderRadius: BorderRadius.circular(Dimensions.radius)),
                child: TextFormField(
                  style: CustomStyle.textStyle,
                  controller: modelController,
                  keyboardType: TextInputType.text,
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Por favor completa el campo';
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                    labelText: 'Modelo del vehículo',
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
              )
            ],
          ),
        ),
      ),
      SizedBox(
        height: Dimensions.heightSize * 1, //1.5

        ///3
      ),
      Padding(
        padding: const EdgeInsets.only(
          left: Dimensions.marginSize,
          right: Dimensions.marginSize,
        ),
        child: GestureDetector(
          child: Container(
            height: 25.0, // 25.0
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: CustomColor.primaryColor,
                borderRadius:
                    BorderRadius.all(Radius.circular(Dimensions.radius))),
            child: Center(
              child: Text(
                'Actualizar',
                style: TextStyle(
                    color: Colors.white, fontSize: Dimensions.largeTextSize),
              ),
            ),
          ),
          onTap: () async {
            final String imageUrl =
                await usuarioProvider.uploadImage(finalpath);

            print(imageUrl);

            String placa = licenseController.text.trim();
            String vehiculo = modelController.text.trim();
            String tipovehiculo = 'V';

            if (selectVehicleType == 'Automóvil') {
              tipovehiculo = 'V';
            } else if (selectVehicleType == 'Motocicleta') {
              tipovehiculo = 'M';
            } else if (selectVehicleType == 'Autobus') {
              tipovehiculo = 'A';
            } else if (selectVehicleType == 'Camión') {
              tipovehiculo = 'C';
            }

            ResponseApi responseApi = await usuarioProvider.updateauto(
                int.parse(widget.id), vehiculo, placa, imageUrl, tipovehiculo);

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
          height: 100, //150
          width: 100, //150
          padding: EdgeInsets.all(1),
          decoration: BoxDecoration(
            color: CustomColor.secondaryColor,
            borderRadius: BorderRadius.circular(75.0),
          ),
          child: _image == null
              ? Image.network(widget.imagen_auto)
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

    if (file == null) {
      Fluttertoast.showToast(msg: 'No File Selected');
    } else {
      finalpath = file.path;

      setState(() {
        _image = file;
      });
      //_upload();
    }
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
      finalpath = file.path;

      setState(() {
        _image = file;
      });
      //_upload();
    }
  }
}
