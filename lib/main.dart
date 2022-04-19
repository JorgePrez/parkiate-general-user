import 'package:flutter/material.dart';
import 'package:parkline/screens/auth/sign_in_screen.dart';
import 'package:parkline/screens/auth/sign_up_screen.dart';
import 'package:parkline/screens/splash_screen.dart';
import 'package:parkline/services/services.dart';
import 'package:parkline/utils/colors.dart';
import 'package:provider/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parkline/pages/acceso_gps_page.dart';
import 'package:parkline/screens/dashboard_screen.dart';
import 'package:parkline/pages/loading_page.dart';
import 'package:parkline/pages/mapa_page.dart';
import 'package:parkline/bloc/mi_ubicacion/mi_ubicacion_bloc.dart';
import 'package:parkline/bloc/mapa/mapa_bloc.dart';
import 'package:parkline/bloc/busqueda/busqueda_bloc.dart';
import 'package:parkline/screens/check_auth_screen.dart';
import 'package:parkline/screens/onboard/on_board_screen.dart';

void main() {
  runApp(AppState());
}

class AppState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ParqueosService()),
        ChangeNotifierProvider(
            create: (_) =>
                AuthService()), //tengo roda la informacion de mi auth service en cualquier parte
      ],
      child: MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => MiUbicacionBloc()),
        BlocProvider(create: (_) => MapaBloc()),
        BlocProvider(create: (_) => BusquedaBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primaryColor: CustomColor.primaryColor,
            visualDensity: VisualDensity.adaptivePlatformDensity,
            fontFamily: 'Ubuntu'),
        home: LoadingPage(),
        // home: MapaPage(),
        routes: {
          'mapa': (_) => MapaPage(),
          'loading': (_) => LoadingPage(),
          'acceso_gps': (_) => AccesoGpsPage(),
          'splashscreen': (_) => SplashScreen(),
          'dashboard': (_) => DashboardScreen(),
          'checking': (_) => CheckAuthScreen(),
          'signin': (_) => SignInScreen(),
          'signup': (_) => SignUpScreen(),
          'onboard': (_) => OnBoardScreen(),
        }, //home: SplashScreen(),
        scaffoldMessengerKey: NotificationsService.messengerKey,
      ),
    );
  }
}
