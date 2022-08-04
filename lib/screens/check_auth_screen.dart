import 'package:flutter/material.dart';
import 'package:parkline/models/usuarios_app.dart';
import 'package:parkline/providers/parqueos_provider.dart';
import 'package:parkline/screens/dashboard_screen.dart';
import 'package:parkline/screens/onboard/on_board_screen.dart';
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

                String latitude = await authService.readlatitude();

                String longitude = await authService.readlongitude();

                final ServiciosadminProvider serviciosadminProvider =
                    new ServiciosadminProvider();

                final ParqueosProvider parqueosProvider =
                    new ParqueosProvider();

                ResponseApi responseApi2 = await serviciosadminProvider
                    .getById(idserviciointerrumpido);

                print('Respuesta object: ${responseApi2}');
                print('RESPUESTA: ${responseApi2.toJson()}');

                if (responseApi2.success) {
                  print('EXITO');
                } else {
                  print('FALLO');
                  //NotificationsService.showSnackbar(responseApi2.message);
                }

                Servicioadmin serviciorecuperado =
                    Servicioadmin.fromJson(responseApi2.data);

                ResponseApi responseApiUsuario = await usuarioProvider
                    .getById(int.parse(serviciorecuperado.idUsuario));

                User user = User.fromJson(responseApiUsuario.data);

                //Consulta de media hora y hora

                ResponseApi responseApitafias = await parqueosProvider
                    .getprize(serviciorecuperado.idParqueo);

                Prize prize = Prize.fromJson(responseApitafias.data);

                String algo = serviciorecuperado.precio;

                if (algo == 'Por Definir') {
                  Navigator.pushReplacement(
                      context,
                      PageRouteBuilder(
                          pageBuilder: (_, __, ___) => ParkingCodeScreen(
                                direccion: serviciorecuperado.direccion,
                                idparqueo: serviciorecuperado.idParqueo,
                                imagenes: serviciorecuperado.imagenes,
                                nombreparqueo: serviciorecuperado.nombreParqueo,
                                idservicio: serviciorecuperado.idServicio,
                                media_hora: prize.mediaHora,
                                hora: prize.hora,
                                controlPagos:
                                    serviciorecuperado.parqueoControlPagos,
                                idusuario: serviciorecuperado.idUsuario,
                                nombreusuario: serviciorecuperado.nombreUsuario,
                                telefono: serviciorecuperado.telefono,
                                modelo_auto: serviciorecuperado.modeloAuto,
                                placa_auto: serviciorecuperado.placaAuto,
                                imagen_usuario: user.imagen,
                                latitude: double.parse(latitude),
                                longitude: double.parse(longitude),
                              ),
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
