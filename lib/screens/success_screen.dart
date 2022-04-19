import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:parkline/screens/auth/sign_in_screen.dart';
import 'package:parkline/utils/colors.dart';
import 'package:parkline/utils/dimensions.dart';

class SuccessScreen extends StatefulWidget {
  @override
  _SuccessScreenState createState() => _SuccessScreenState();
}

class _SuccessScreenState extends State<SuccessScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: const EdgeInsets.only(
                left: Dimensions.marginSize, right: Dimensions.marginSize),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 150,
                  width: 150,
                  decoration: BoxDecoration(
                      color: CustomColor.secondaryColor,
                      borderRadius: BorderRadius.all(Radius.circular(75.0))),
                  child: Icon(
                    FontAwesomeIcons.check,
                    size: 100,
                    color: CustomColor.primaryColor,
                  ),
                ),
                SizedBox(
                  height: Dimensions.heightSize * 3,
                ),
                Text(
                  "Registrado correctamente",
                  style: TextStyle(fontSize: Dimensions.extraLargeTextSize * 2),
                ),
                SizedBox(height: Dimensions.heightSize),
                GestureDetector(
                  child: Container(
                    height: 50.0,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: CustomColor.primaryColor,
                        borderRadius: BorderRadius.all(
                            Radius.circular(Dimensions.radius))),
                    child: Center(
                      child: Text(
                        "Ahora inicia sesión",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: Dimensions.largeTextSize),
                      ),
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => SignInScreen()));
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
