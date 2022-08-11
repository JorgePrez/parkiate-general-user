import 'package:flutter/material.dart';
import 'package:parkline/models/usuarios_app.dart';
import 'package:parkline/providers/parqueos_provider.dart';
import 'package:parkline/screens/dashboard_screen.dart';
import 'package:parkline/screens/onboard/on_board_screen.dart';
import 'package:parkline/screens/parking_code_entry.dart';
import 'package:parkline/screens/parking_code_screen%20_recovery.dart';
import 'package:parkline/screens/parking_code_screen.dart';
import 'package:parkline/utils/shared_pref.dart';
import 'package:provider/provider.dart';
import 'package:parkline/models/user.dart';
import 'package:parkline/models/prize.dart';
import 'package:parkline/providers/usuarios_provider.dart';
import 'package:parkline/models/response_api.dart';
import 'package:parkline/services/services.dart';
import 'package:parkline/models/servicioadmin.dart';
import 'package:parkline/providers/serviciosadmin_provider.dart';

class CheckAuthScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);
    UsuarioProvider usuarioProvider = new UsuarioProvider();
    SharedPref _sharedPref = new SharedPref();

    return Scaffold(
      body: Center(
        child: FutureBuilder(
          future: authService.readService(),
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            if (!snapshot.hasData) return Text('');

            if (snapshot.data == '') {
              Future.microtask(() {
                Navigator.pushReplacement(
                    context,
                    PageRouteBuilder(
                        pageBuilder: (_, __, ___) => OnBoardScreen(),
                        transitionDuration: Duration(seconds: 0)));
              });
            } else {
              Future.microtask(() async {
                String idserviciointerrumpido = await authService.readService();
                print(idserviciointerrumpido);

                UsuarioApp user_app = UsuarioApp.fromJson(
                    await _sharedPref.read('usuario_app') ?? {});

                String id_parqueo_qr =
                    await _sharedPref.read('id_parqueo_qr') ?? '';

                if (id_parqueo_qr.length > 1) {
                  Navigator.pushReplacement(
                      context,
                      PageRouteBuilder(
                          pageBuilder: (_, __, ___) => ParkingCodeScreenEntry(
                              //ruta intermedia
                              idparqueo: id_parqueo_qr,
                              idusuario: user_app.id),
                          transitionDuration: Duration(seconds: 0)));
                } else {
                  final authService =
                      Provider.of<AuthService>(context, listen: false);

                  await authService.logout2();
                  await authService.clear_latitude();

                  await authService.clear_longitude();

                  Navigator.pushReplacement(
                      context,
                      PageRouteBuilder(
                          pageBuilder: (_, __, ___) => DashboardScreen(
                                nombre_usuario: user_app.nombre,
                                email_usuario: user_app.email,
                                foto_perfil: user_app.fotoPerfil,
                              ),
                          transitionDuration: Duration(seconds: 0)));
                }
              });
            }

            return Container();
          },
        ),
      ),
    );
  }
}
