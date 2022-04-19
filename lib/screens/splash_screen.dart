import 'package:flutter/material.dart';
import 'package:parkline/screens/check_auth_screen.dart';
import 'package:parkline/utils/colors.dart';

import 'dart:async';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(Duration(seconds: 3), () => Navigator.of(context).pushReplacement(
        //  MaterialPageRoute(builder: (context) => OnBoardScreen())));
        MaterialPageRoute(builder: (context) => CheckAuthScreen())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.primaryColor,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Image.asset('assets/images/splash_logo.png'),
      ),
    );
  }
}
