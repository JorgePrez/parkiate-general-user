import 'package:flutter/material.dart';
import 'package:parkline/utils/colors.dart';
import 'package:parkline/utils/dimensions.dart';
import 'package:parkline/screens/auth/sign_up_screen.dart';
import 'package:parkline/screens/auth/sign_in_screen.dart';

class MultipleSignUpScreen extends StatefulWidget {
  @override
  _MultipleSignUpScreenState createState() => _MultipleSignUpScreenState();
}

class _MultipleSignUpScreenState extends State<MultipleSignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    top: Dimensions.heightSize * 3,
                    left: Dimensions.marginSize * 2,
                    right: Dimensions.marginSize * 2),
                child: Text(
                  'Registrarte',
                  style: TextStyle(
                      fontSize: Dimensions.extraLargeTextSize * 2,
                      color: Colors.black),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: Dimensions.heightSize * 3,
                    left: Dimensions.marginSize * 2,
                    right: Dimensions.marginSize * 2),
                child: Text(
                  'Con tu cuenta además de (encontrar parqueos) podrás introducir tu auto, ver tu historial, reseñar parqueos y más funciones interesantes',
                  style: TextStyle(
                    fontSize: Dimensions.defaultTextSize * 1.5,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.only(
                    left: Dimensions.marginSize,
                    right: Dimensions.marginSize,
                    bottom: Dimensions.heightSize * 3),
                child: Column(
                  children: [
                    GestureDetector(
                      child: Container(
                        height: 60,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: CustomColor.primaryColor,
                            borderRadius: BorderRadius.all(
                                Radius.circular(Dimensions.radius))),
                        child: Center(
                          child: Text(
                            'REGISTRATE GRATIS',
                            style: TextStyle(
                                fontSize: Dimensions.extraLargeTextSize,
                                color: Colors.white),
                          ),
                        ),
                      ),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => SignUpScreen()));
                      },
                    ),
                    SizedBox(
                      height: Dimensions.heightSize,
                    ),
                    SizedBox(
                      height: Dimensions.heightSize * 2,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '¿Ya tienes una cuenta?',
                          style:
                              TextStyle(fontSize: Dimensions.defaultTextSize),
                        ),
                        GestureDetector(
                          child: Text(
                            'Iniciar Sesión',
                            style: TextStyle(
                                fontSize: Dimensions.defaultTextSize,
                                color: CustomColor.primaryColor,
                                fontWeight: FontWeight.bold),
                          ),
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                //tambien podriamos mandarlo directamente a dashborad
                                builder: (context) => SignInScreen()));
                          },
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
