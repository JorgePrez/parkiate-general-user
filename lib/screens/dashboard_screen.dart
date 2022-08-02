import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:parkline/models/direccion.dart';
import 'package:parkline/models/servicioadmin.dart';
import 'package:parkline/models/user.dart';
import 'package:parkline/models/espacios.dart';
import 'package:parkline/models/response_api.dart';
import 'package:parkline/models/resenia.dart';
import 'package:parkline/models/parqueo.dart';
import 'package:parkline/models/visita.dart';
import 'package:parkline/pages/map_markers_search.dart';
import 'package:parkline/pages/mapa_page.dart';
import 'package:parkline/pages/mapa_page_copy.dart';
import 'package:parkline/providers/usuarios_provider.dart';
import 'package:parkline/providers/visitas_provider.dart';
import 'package:parkline/screens/dashboard/direction_history_screen.dart';
import 'package:parkline/screens/dashboard/filter.dart';
import 'package:parkline/screens/dashboard/parking_history_screen_full.dart';
import 'package:parkline/screens/dashboard_screen_filter.dart';
import 'package:parkline/services/parqueos_service.dart';
import 'package:parkline/utils/dimensions.dart';
import 'package:parkline/utils/custom_style.dart';
import 'package:parkline/utils/colors.dart';
import 'package:parkline/utils/vehichle.dart';
import 'package:parkline/screens/parking_point_details_screen.dart';
import 'package:parkline/screens/dashboard/parking_history_screen.dart';
import 'package:parkline/screens/dashboard/add_vehicle_screen.dart';
import 'package:parkline/screens/dashboard/my_account_screen.dart';
import 'package:parkline/utils/shared_pref.dart';
import 'package:parkline/providers/parqueos_provider.dart';
import 'package:parkline/providers/resenias_provider.dart';
import 'package:parkline/providers/serviciosadmin_provider.dart';

import 'package:parkline/screens/onboard/on_board_screen.dart';
import 'package:parkline/pages/map_markers.dart';
import 'package:provider/provider.dart';
import 'package:parkline/widgets/color_button.dart';

String selectedVehicle = 'assets/images/vehicle/filter.png';
String selectedVehicle2;

String vehiculo = 'assets/images/vehicle/tourism.png';
String moto = 'assets/images/vehicle/motorbike2.png';
String camion = 'assets/images/vehicle/truck.png';
String bus = 'assets/images/vehicle/bus.png';

bool uno = false;
bool dos = false;
bool tres = false;
bool cuatro = false;
bool cinco = false;
bool seis = false;
bool siete = false;
bool ocho = false;
bool nueve = false;
bool a = false;
bool b = false;
bool c = false;

bool d = false;

RangeValues rangeValues = const RangeValues(0, 40);

class DashboardScreen extends StatefulWidget {
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

  DashboardScreen({
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
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  List<Parqueo> listaconcidencias = [];

  SharedPref _sharedPref = new SharedPref();

  /* @override
  void initState() {
    if (widget.tipo_auto == 'V') {
      selectedVehicle2 = vehiculo;
    } else if (widget.tipo_auto == 'M') {
      selectedVehicle2 = moto;
    } else if (widget.tipo_auto == 'A') {
      selectedVehicle2 = bus;
    } else if (widget.tipo_auto == 'C') {
      selectedVehicle2 = camion;
    }

    super.initState();
  }*/

  User user;

  TextEditingController searchController = TextEditingController();

  TimeOfDay selectedEntranceTime = TimeOfDay.now();
  String entranceTime = '00:00';

  TimeOfDay selectedExitTime = TimeOfDay.now();
  String exitTime = '01:00';

  bool isConfirm = true;

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final ServiciosadminProvider serviciosProvider =
        new ServiciosadminProvider();

    final parqueosService = Provider.of<ParqueosService>(context);
    final VisitasProvider visitasProvider = new VisitasProvider();
    //Agregando psuedo estado

    return SafeArea(
      child: Scaffold(
          key: scaffoldKey,
          drawer: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                DrawerHeader(
                  child: profileWidget(context),
                  decoration: BoxDecoration(
                    color: CustomColor.primaryColor,
                  ),
                ),
                ListTile(
                  title: Text(
                    'Historial de Visitas a Parqueos',
                    style: CustomStyle.listStyle,
                  ),
                  trailing: Icon(Icons.history),
                  onTap: () async {
                    List<Visita> lista_visitas =
                        await visitasProvider.getbyuser("8");

                    Navigator.of(context).pop();
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ParkingHistoryScreenFull(
                            listaservicios: lista_visitas)));
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: Dimensions.marginSize,
                      right: Dimensions.marginSize),
                  child: Divider(
                    color: Colors.black.withOpacity(0.4),
                  ),
                ),
                ListTile(
                  title: Text(
                    'Historial de Parqueos OLD',
                    style: CustomStyle.listStyle,
                  ),
                  trailing: Icon(Icons.history),
                  onTap: () async {
                    List<Servicioadmin> lista =
                        await serviciosProvider.userhistory(widget.id);

                    print(lista);

                    Navigator.of(context).pop();
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            ParkingHistoryScreen(listaservicios: lista)));
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: Dimensions.marginSize,
                      right: Dimensions.marginSize),
                  child: Divider(
                    color: Colors.black.withOpacity(0.4),
                  ),
                ),
                ListTile(
                  title: Text(
                    'Mi Cuenta',
                    style: CustomStyle.listStyle,
                  ),
                  trailing: Icon(Icons.account_box),
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => MyAccountScreen(
                              id: widget.id,
                              email: widget.email,
                              nombre: widget.nombre,
                              telefono: widget.telefono,
                              imagen: widget.imagen,
                              session_token: widget.session_token,
                              modelo_auto: widget.modelo_auto,
                              placa_auto: widget.placa_auto,
                              imagen_auto: widget.imagen_auto,
                              tipo_auto: widget.tipo_auto,
                            )));
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: Dimensions.marginSize,
                      right: Dimensions.marginSize),
                  child: Divider(
                    color: Colors.black.withOpacity(0.4),
                  ),
                ),
                ListTile(
                  title: Text(
                    'Mi Vehículo',
                    style: CustomStyle.listStyle,
                  ),
                  trailing: Icon(Icons.airport_shuttle_outlined),
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => AddVehicleScreen(
                              id: widget.id,
                              email: widget.email,
                              modelo_auto: widget.modelo_auto,
                              placa_auto: widget.placa_auto,
                              imagen_auto: widget.imagen_auto,
                              tipo_auto: widget.tipo_auto,
                            )));
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: Dimensions.marginSize,
                      right: Dimensions.marginSize),
                  child: Divider(
                    color: Colors.black.withOpacity(0.4),
                  ),
                ),
                ListTile(
                  title: Text(
                    'Mis direcciones',
                    style: CustomStyle.listStyle,
                  ),
                  trailing: Icon(Icons.add_location_outlined),
                  onTap: () async {
                    UsuarioProvider usuarioProvider = new UsuarioProvider();

                    List<Direccion> lista =
                        await usuarioProvider.getDirections(widget.id);

                    print(lista);

                    Navigator.of(context).pop();
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => DirectionHistoryScreen(
                            listaservicios: lista, id_usuario: widget.id)));
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: Dimensions.marginSize,
                      right: Dimensions.marginSize),
                  child: Divider(
                    color: Colors.black.withOpacity(0.4),
                  ),
                ),
                ListTile(
                  title: Text(
                    "Regresar a Dashboard",
                    style: CustomStyle.listStyle,
                  ),
                  trailing: Icon(Icons.person_search_outlined),
                  onTap: () {
                    Navigator.of(context).pop();

/*
                             Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => Filter()));

                        */

                    /*
                    Navigator.of(context).pop();*/
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: Dimensions.marginSize,
                      right: Dimensions.marginSize),
                  child: Divider(
                    color: Colors.black.withOpacity(0.4),
                  ),
                ),
                ListTile(
                  title: Text(
                    'CERRAR SESIÓN',
                    style: CustomStyle.listStyle,
                  ),
                  trailing: Icon(Icons.logout),
                  onTap: () {
                    //   Navigator.pushReplacementNamed(context, 'signin');

                    _sharedPref.logout();

                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => OnBoardScreen()));
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: Dimensions.marginSize,
                      right: Dimensions.marginSize),
                  child: Divider(
                    color: Colors.black.withOpacity(0.4),
                  ),
                ),
              ],
            ),
          ),
          body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  //TODO: aqui debe estar el verdadero mapa, no importa dad
                  /*   child: MapaPageCopy(
                   )*/

                  child: MapMarkers(
                    idusuario: widget.id,
                    nombreusuario: widget.nombre,
                    telefono: widget.telefono,
                    modelo_auto: widget.modelo_auto,
                    placa_auto: widget.placa_auto,
                    imagen_usuario: widget.imagen,
                  ),

                  /*child: MapMarkers(
                      idusuario: widget.id,
                      nombreusuario: widget.nombre,
                      telefono: widget.telefono,
                      modelo_auto: widget.modelo_auto,
                      placa_auto: widget.placa_auto,
                      imagen_usuario: widget.imagen),*/
                ),
                DraggableScrollableSheet(
                  builder: (context, scrollController) {
                    return Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(Dimensions.radius * 3),
                              topRight:
                                  Radius.circular(Dimensions.radius * 5))),
                      child: SingleChildScrollView(
                        child: isConfirm
                            ? bodyWidget(context)
                            : parkingPointWidget(context),
                        controller: scrollController,
                      ),
                    );
                  },
                  initialChildSize: 0.25,
                  minChildSize: 0.25,
                  maxChildSize: 1.0,
                ),
                Positioned(
                  top: Dimensions.heightSize * 2,
                  left: Dimensions.marginSize,
                  right: Dimensions.marginSize,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          if (scaffoldKey.currentState.isDrawerOpen) {
                            scaffoldKey.currentState.openEndDrawer();
                          } else {
                            scaffoldKey.currentState.openDrawer();
                          }
                        },
                        child: Icon(
                          Icons.menu,
                          color: CustomColor.primaryColor,
                        ), //your button
                      ),
                    ],
                  ),
                )
              ],
            ),
          )),
    );
  }

  profileWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: Dimensions.heightSize * 3,
      ),
      child: ListTile(
        leading: Image.network(
          widget.imagen,
        ),
        title: Text(
          '${widget?.nombre ?? ''}',
          style: TextStyle(
              color: Colors.white,
              fontSize: Dimensions.largeTextSize,
              fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          '${widget?.email ?? ''}',
          style: TextStyle(
            color: Colors.white,
            fontSize: Dimensions.defaultTextSize,
          ),
        ),
      ),
    );
  }

  bodyWidget(BuildContext context) {
    final ParqueosProvider parqueosProvider = new ParqueosProvider();

    return Padding(
      padding: const EdgeInsets.only(
          left: Dimensions.marginSize,
          right: Dimensions.marginSize,
          top: Dimensions.heightSize * 3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //TODO: titulin
          /*Text('Bienvenido ${widget?.nombre ?? ''}!!!',
              style: CustomStyle.textStyle),
          Text(
            '¿Donde deseas estacionarte?',
            style: TextStyle(
              fontSize: Dimensions.largeTextSize * 1.5,
              color: Colors.black,
            ),
          ),
          SizedBox(
            height: Dimensions.heightSize,
          ),*/
          Row(
            children: [
              Expanded(
                flex: 4,
                child: TextFormField(
                  style: CustomStyle.textStyle,
                  controller: searchController,
                  keyboardType: TextInputType.emailAddress,
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Por favor completa el campo';
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                      labelText: 'Buscar Parqueos',
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
                      prefixIcon: Icon(
                        Icons.search,
                        color: CustomColor.primaryColor,
                      )),
                ),
              ),
              SizedBox(
                width: Dimensions.widthSize,
              ),
              Expanded(
                flex: 1,
                child: GestureDetector(
                  child: Container(
                    height: 50.0,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                            Radius.circular(Dimensions.radius)),
                        border:
                            Border.all(color: Colors.black.withOpacity(0.1))),
                    child: Image.asset(selectedVehicle),
                  ),
                  onTap: () {
                    showVehicleBottomSheet(context);
                  },
                ),
              )
            ],
          ),

          //TODO:QUITANDO ESPACIOS
          SizedBox(
            height: Dimensions.heightSize,
          ),

          /*
          Divider(
            color: Colors.black.withOpacity(0.50),
          ),
          SizedBox(
            height: Dimensions.heightSize,
          ),
          SizedBox(
            height: Dimensions.heightSize,
          ),*/
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
                  'Buscar',
                  style: TextStyle(
                      color: Colors.white, fontSize: Dimensions.largeTextSize),
                ),
              ),
            ),
            onTap: () async {
              String keyword = searchController.text.trim();
              listaconcidencias = await parqueosProvider.buscar(keyword);
              List<Parqueo> listaconcidenciasfiltradas = [];

              List<Parqueo> resultfiltrados = [];

              print(keyword);

              String caracteristicasObjetivo = "";

              if (uno == true) {
                caracteristicasObjetivo = caracteristicasObjetivo + "1 ";
              }

              if (dos == true) {
                caracteristicasObjetivo = caracteristicasObjetivo + "2 ";
              }

              if (tres == true) {
                caracteristicasObjetivo = caracteristicasObjetivo + "3 ";
              }

              if (cuatro == true) {
                caracteristicasObjetivo = caracteristicasObjetivo + "4 ";
              }

              if (cinco == true) {
                caracteristicasObjetivo = caracteristicasObjetivo + "5 ";
              }

              if (seis == true) {
                caracteristicasObjetivo = caracteristicasObjetivo + "6 ";
              }

              if (siete == true) {
                caracteristicasObjetivo = caracteristicasObjetivo + "7 ";
              }

              if (ocho == true) {
                caracteristicasObjetivo = caracteristicasObjetivo + "8 ";
              }

              if (nueve == true) {
                caracteristicasObjetivo = caracteristicasObjetivo + "9 ";
              }

              if (a == true) {
                caracteristicasObjetivo = caracteristicasObjetivo + "A ";
              }

              if (b == true) {
                caracteristicasObjetivo = caracteristicasObjetivo + "B ";
              }

              if (c == true) {
                caracteristicasObjetivo = caracteristicasObjetivo + "C ";
              }

              if (d == true) {
                caracteristicasObjetivo = caracteristicasObjetivo + "D ";
              }

              //  print(caracteristicasObjetivo);

              List<String> porfiltrar = caracteristicasObjetivo.split(" ");

              for (int i = 0; i < listaconcidencias.length; i++) {
                Parqueo actual = listaconcidencias[i];

                int contador = 0;

                String caracteristicas_parqueo = actual.detalles;

                for (int i = 0; i < porfiltrar.length; i++) {
                  if (caracteristicas_parqueo.contains(porfiltrar[i])) {
                    contador++;
                  }
                }

                if (contador == porfiltrar.length) {
                  listaconcidenciasfiltradas.add(actual);
                }
              }

              for (int i = 0; i < listaconcidenciasfiltradas.length; i++) {
                Parqueo actual = listaconcidenciasfiltradas[i];

                if (rangeValues.start <= double.parse(actual.hora) &&
                    double.parse(actual.hora) <= rangeValues.end) {
                  resultfiltrados.add(actual);
                }
              }

              // print(resultfiltrados);

              User user = User.fromJson(await _sharedPref.read('user') ?? {});

              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => DashboardScreenFilter(
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
                        listaconcidencias: resultfiltrados,
                      )));

              /*

              setState(() {
                isConfirm = !isConfirm;
                print(isConfirm.toString());
              });  */
            },
          ),
        ],
      ),
    );
  }

  parkingPointWidget(BuildContext context) {
    final ReseniasProvider reseniasProvider = new ReseniasProvider();
    final ParqueosProvider parqueosProvider = new ParqueosProvider();

    return Padding(
      padding: const EdgeInsets.only(top: Dimensions.heightSize * 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
                left: Dimensions.marginSize, right: Dimensions.marginSize),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      child: Icon(Icons.arrow_back),
                      onTap: () async {
                        User user =
                            User.fromJson(await _sharedPref.read('user') ?? {});

                        Navigator.of(context).pushReplacement(MaterialPageRoute(
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
                        /*setState(() {
                          isConfirm = !isConfirm;
                          print(isConfirm.toString());
                        });*/
                      },
                    ),
                    Text('Desliza para hallar más',
                        style: CustomStyle.textStyle),
                  ],
                ),
                SizedBox(
                  height: Dimensions.heightSize,
                ),
                Text(
                  'Resultados:',
                  style: TextStyle(
                    fontSize: Dimensions.largeTextSize * 1.5,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: Dimensions.heightSize,
          ),
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: ListView.builder(
                itemCount:
                    listaconcidencias.length, //parqueosService.parqueos.length,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  Parqueo parkingPoint = listaconcidencias[index];

                  var longlatitud = double.parse(parkingPoint.latitude);
                  var longlongitud = double.parse(parkingPoint.longitude);
                  var arr = parkingPoint.detalles.split(' ');

                  return Padding(
                    padding:
                        const EdgeInsets.only(bottom: Dimensions.heightSize),
                    child: GestureDetector(
                      child: Container(
                        height: 100,
                        color: CustomColor.secondaryColor,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: Dimensions.marginSize,
                              right: Dimensions.marginSize),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                flex: 1,
                                child: Image.network(parkingPoint
                                    .imagenes), //  child: Image.asset(parkingPoint.image),
                              ),
                              SizedBox(
                                width: Dimensions.widthSize,
                              ),
                              Expanded(
                                flex: 4,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      parkingPoint
                                          .nombreEmpresa, //                                      parkingPoint.name,

                                      style: TextStyle(
                                          fontSize: Dimensions.largeTextSize,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: Dimensions.heightSize * 0.5,
                                    ),
                                    Text(
                                      parkingPoint.direccion,
                                      style: CustomStyle.textStyle,
                                    ),
                                    SizedBox(
                                      height: Dimensions.heightSize * 0.5,
                                    ),
                                    Text(
                                      'Q${parkingPoint.hora} por hora',
                                      style: TextStyle(
                                          fontSize: Dimensions.largeTextSize,
                                          color: CustomColor.primaryColor),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      onTap: () async {
                        List<Resenia> listar = await reseniasProvider
                            .reviewsbyPark2(parkingPoint.idParqueo);

                        //Obtener cantidad de espacios disponbiles

                        // print(listar);

                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ParkingPointDetailsScreen(
                                idpark: parkingPoint.idParqueo,
                                name: parkingPoint
                                    .nombreEmpresa, //        name: parkingPoint.name,
                                amount: parkingPoint.capacidadMaxima,
                                image: parkingPoint.imagenes,
                                address: parkingPoint.direccion,
                                slots: parkingPoint.capacidadMaxima,
                                mediahora: parkingPoint.mediaHora,
                                hora: parkingPoint.hora,
                                dia: parkingPoint.dia,
                                mes: parkingPoint.mes,
                                lunesEntrada: parkingPoint.lunesApertura,
                                lunesCierre: parkingPoint.lunesCierre,
                                martesEntrada: parkingPoint.martesApertura,
                                martesSalida: parkingPoint.martesCierre,
                                detalles: arr,
                                cantidad_detalles: arr.length,
                                latitude: longlatitud,
                                longitude: longlongitud,
                                miercolesEntrada:
                                    parkingPoint.miercolesApertura,
                                miercolesSalida: parkingPoint.miercolesCierre,
                                juevesEntrada: parkingPoint.juevesApertura,
                                juevesSalida: parkingPoint.juevesCierre,
                                viernesEntrada: parkingPoint.viernesApertura,
                                viernesSalida: parkingPoint.viernesCierre,
                                sabadoEntrada: parkingPoint.sabadoApertura,
                                sabadoSalida: parkingPoint.sabadoCierre,
                                domingoEntrada: parkingPoint.domingoApertura,
                                domingoSalida: parkingPoint.domingoCierre,
                                controlPagos: parkingPoint.controlPagos,
                                idusuario: widget.id,
                                nombreusuario: widget.nombre,
                                telefono: widget.telefono,
                                modelo_auto: widget.modelo_auto,
                                placa_auto: widget.placa_auto,
                                imagen_usuario: widget.imagen,
                                listaresenias: listar)));
                      },
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }

  void showVehicleBottomSheet(BuildContext context) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (builder) {
          return Filter();
        });
  }
}

//Filter widget modal /////////////////////////////////////////

class Filter extends StatefulWidget {
  const Filter({Key key}) : super(key: key);

  @override
  _FilterState createState() => _FilterState();
}

class _FilterState extends State<Filter> {
  int timeIndex = 0;
  double sliderValue = 0;

  int paymentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 20, top: 20, right: 20),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.85,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: Stack(
        children: [
          ListView(
            padding: const EdgeInsets.only(bottom: 60),
            children: [
              Row(
                children: [
                  GestureDetector(
                    child: Icon(
                      Icons.arrow_back,
                      color: CustomColor.primaryColor,
                    ),
                    onTap: () {
                      uno = false;
                      dos = false;
                      tres = false;
                      cuatro = false;
                      cinco = false;
                      seis = false;
                      siete = false;
                      ocho = false;
                      nueve = false;
                      a = false;
                      b = false;
                      c = false;
                      d = false;

                      rangeValues = const RangeValues(0, 40);
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Center(
                child: Text(
                  'Búsqueda por filtros',
                  style: TextStyle(
                    fontSize: Dimensions.extraLargeTextSize * 1,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "Rango de precios(precio por hora)",
                style: Theme.of(context).textTheme.bodyText1.copyWith(
                      fontSize: Dimensions.largeTextSize,
                    ),
              ),
              const SizedBox(
                height: 30,
              ),
              RangeSlider(
                  divisions: 100,
                  labels: RangeLabels('Q${rangeValues.start.toString()}',
                      'Q${rangeValues.end.toString()}'),
                  activeColor: CustomColor.primaryColor,
                  min: 0,
                  max: 100,
                  values: rangeValues,
                  onChanged: (value) {
                    setState(() {
                      print(rangeValues);
                      rangeValues = value;
                    });
                  }),
              const SizedBox(
                height: 30,
              ),
              Text(
                'Caracteristicas del parqueo',
                style: Theme.of(context).textTheme.bodyText1.copyWith(
                      fontSize: Dimensions.largeTextSize,
                    ),
              ),
              const SizedBox(
                height: 10,
              ),
              Wrap(
                children: [
                  TextBox1("Baños"),
                  TextBox2("Bajo techo"),
                  TextBox3("Asfalto"),
                  TextBox4("Seguridad Privada"),
                  TextBox5("Espacio para furgoneta o camión"),
                  TextBox6("Lavado"),
                  TextBox7("Iluminado"),
                  TextBox8("Puerta de Seguridad"),
                  TextBox9("Apto para discapacitados"),
                  TextBoxA("Cámara de Seguridad"),
                  TextBoxB("Amplio Espacio"),
                  TextBoxC("Sótano"),
                  TextBoxD("Pago con tarjeta"),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
          PositionedDirectional(
            bottom: 20,
            start: 20,
            end: 20,
            child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const SizedBox(
                    height: 55,
                    child: ColorButton(
                      'Aplicar filtros',
                    ))),
          ),
        ],
      ),
    );
  }
}

///////////////////////////////////////////////////////////////////////////

class TextBox1 extends StatefulWidget {
  final String title;
  const TextBox1(this.title, {Key key}) : super(key: key);

  @override
  _TextBox1State createState() => _TextBox1State();
}

class _TextBox1State extends State<TextBox1> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          uno = !uno;

          //uno=isSelected;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(right: 7, top: 10),
        padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 5),
        decoration: BoxDecoration(
            color: uno ? CustomColor.primaryColor : CustomColor.secondaryColor,
            borderRadius: BorderRadius.circular(20)),
        child: Text(
          widget.title,
          style: Theme.of(context).textTheme.bodyText1.copyWith(
              fontSize: Dimensions.defaultTextSize,
              color: uno ? Colors.white : Colors.black),
        ),
      ),
    );
  }
}

class TextBox2 extends StatefulWidget {
  final String title;
  const TextBox2(this.title, {Key key}) : super(key: key);

  @override
  _TextBox2State createState() => _TextBox2State();
}

class _TextBox2State extends State<TextBox2> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          dos = !dos;

          //uno=isSelected;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(right: 7, top: 10),
        padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 5),
        decoration: BoxDecoration(
            color: dos ? CustomColor.primaryColor : CustomColor.secondaryColor,
            borderRadius: BorderRadius.circular(20)),
        child: Text(
          widget.title,
          style: Theme.of(context).textTheme.bodyText1.copyWith(
              fontSize: Dimensions.defaultTextSize,
              color: dos ? Colors.white : Colors.black),
        ),
      ),
    );
  }
}

class TextBox3 extends StatefulWidget {
  final String title;
  const TextBox3(this.title, {Key key}) : super(key: key);

  @override
  _TextBox3State createState() => _TextBox3State();
}

class _TextBox3State extends State<TextBox3> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          tres = !tres;

          //uno=isSelected;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(right: 7, top: 10),
        padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 5),
        decoration: BoxDecoration(
            color: tres ? CustomColor.primaryColor : CustomColor.secondaryColor,
            borderRadius: BorderRadius.circular(20)),
        child: Text(
          widget.title,
          style: Theme.of(context).textTheme.bodyText1.copyWith(
              fontSize: Dimensions.defaultTextSize,
              color: tres ? Colors.white : Colors.black),
        ),
      ),
    );
  }
}

class TextBox4 extends StatefulWidget {
  final String title;
  const TextBox4(this.title, {Key key}) : super(key: key);

  @override
  _TextBox4State createState() => _TextBox4State();
}

class _TextBox4State extends State<TextBox4> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          cuatro = !cuatro;

          //uno=isSelected;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(right: 7, top: 10),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
        decoration: BoxDecoration(
            color:
                cuatro ? CustomColor.primaryColor : CustomColor.secondaryColor,
            borderRadius: BorderRadius.circular(20)),
        child: Text(
          widget.title,
          style: Theme.of(context).textTheme.bodyText1.copyWith(
              fontSize: Dimensions.defaultTextSize,
              color: cuatro ? Colors.white : Colors.black),
        ),
      ),
    );
  }
}

class TextBox5 extends StatefulWidget {
  final String title;
  const TextBox5(this.title, {Key key}) : super(key: key);

  @override
  _TextBox5State createState() => _TextBox5State();
}

class _TextBox5State extends State<TextBox5> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          cinco = !cinco;

          //uno=isSelected;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(right: 7, top: 10),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        decoration: BoxDecoration(
            color:
                cinco ? CustomColor.primaryColor : CustomColor.secondaryColor,
            borderRadius: BorderRadius.circular(20)),
        child: Text(
          widget.title,
          style: Theme.of(context).textTheme.bodyText1.copyWith(
              fontSize: Dimensions.defaultTextSize,
              color: cinco ? Colors.white : Colors.black),
        ),
      ),
    );
  }
}

class TextBox6 extends StatefulWidget {
  final String title;
  const TextBox6(this.title, {Key key}) : super(key: key);

  @override
  _TextBox6State createState() => _TextBox6State();
}

class _TextBox6State extends State<TextBox6> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          seis = !seis;

          //uno=isSelected;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(right: 7, top: 10),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        decoration: BoxDecoration(
            color: seis ? CustomColor.primaryColor : CustomColor.secondaryColor,
            borderRadius: BorderRadius.circular(20)),
        child: Text(
          widget.title,
          style: Theme.of(context).textTheme.bodyText1.copyWith(
              fontSize: Dimensions.defaultTextSize,
              color: seis ? Colors.white : Colors.black),
        ),
      ),
    );
  }
}

class TextBox7 extends StatefulWidget {
  final String title;
  const TextBox7(this.title, {Key key}) : super(key: key);

  @override
  _TextBox7State createState() => _TextBox7State();
}

class _TextBox7State extends State<TextBox7> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          siete = !siete;

          //uno=isSelected;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(right: 7, top: 10),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        decoration: BoxDecoration(
            color:
                siete ? CustomColor.primaryColor : CustomColor.secondaryColor,
            borderRadius: BorderRadius.circular(20)),
        child: Text(
          widget.title,
          style: Theme.of(context).textTheme.bodyText1.copyWith(
              fontSize: Dimensions.defaultTextSize,
              color: siete ? Colors.white : Colors.black),
        ),
      ),
    );
  }
}

class TextBox8 extends StatefulWidget {
  final String title;
  const TextBox8(this.title, {Key key}) : super(key: key);

  @override
  _TextBox8State createState() => _TextBox8State();
}

class _TextBox8State extends State<TextBox8> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          ocho = !ocho;

          //uno=isSelected;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(right: 7, top: 10),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        decoration: BoxDecoration(
            color: ocho ? CustomColor.primaryColor : CustomColor.secondaryColor,
            borderRadius: BorderRadius.circular(20)),
        child: Text(
          widget.title,
          style: Theme.of(context).textTheme.bodyText1.copyWith(
              fontSize: Dimensions.defaultTextSize,
              color: ocho ? Colors.white : Colors.black),
        ),
      ),
    );
  }
}

class TextBox9 extends StatefulWidget {
  final String title;
  const TextBox9(this.title, {Key key}) : super(key: key);

  @override
  _TextBox9State createState() => _TextBox9State();
}

class _TextBox9State extends State<TextBox9> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          nueve = !nueve;

          //uno=isSelected;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(right: 7, top: 10),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        decoration: BoxDecoration(
            color:
                nueve ? CustomColor.primaryColor : CustomColor.secondaryColor,
            borderRadius: BorderRadius.circular(20)),
        child: Text(
          widget.title,
          style: Theme.of(context).textTheme.bodyText1.copyWith(
              fontSize: Dimensions.defaultTextSize,
              color: nueve ? Colors.white : Colors.black),
        ),
      ),
    );
  }
}

class TextBoxA extends StatefulWidget {
  final String title;
  const TextBoxA(this.title, {Key key}) : super(key: key);

  @override
  _TextBoxAState createState() => _TextBoxAState();
}

class _TextBoxAState extends State<TextBoxA> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          a = !a;

          //uno=isSelected;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(right: 7, top: 10),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        decoration: BoxDecoration(
            color: a ? CustomColor.primaryColor : CustomColor.secondaryColor,
            borderRadius: BorderRadius.circular(20)),
        child: Text(
          widget.title,
          style: Theme.of(context).textTheme.bodyText1.copyWith(
              fontSize: Dimensions.defaultTextSize,
              color: a ? Colors.white : Colors.black),
        ),
      ),
    );
  }
}

class TextBoxB extends StatefulWidget {
  final String title;
  const TextBoxB(this.title, {Key key}) : super(key: key);

  @override
  _TextBoxBState createState() => _TextBoxBState();
}

class _TextBoxBState extends State<TextBoxB> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          b = !b;

          //uno=isSelected;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(right: 7, top: 10),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        decoration: BoxDecoration(
            color: b ? CustomColor.primaryColor : CustomColor.secondaryColor,
            borderRadius: BorderRadius.circular(20)),
        child: Text(
          widget.title,
          style: Theme.of(context).textTheme.bodyText1.copyWith(
              fontSize: Dimensions.defaultTextSize,
              color: b ? Colors.white : Colors.black),
        ),
      ),
    );
  }
}

class TextBoxC extends StatefulWidget {
  final String title;
  const TextBoxC(this.title, {Key key}) : super(key: key);

  @override
  _TextBoxCState createState() => _TextBoxCState();
}

class _TextBoxCState extends State<TextBoxC> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          c = !c;

          //uno=isSelected;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(right: 7, top: 10),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        decoration: BoxDecoration(
            color: c ? CustomColor.primaryColor : CustomColor.secondaryColor,
            borderRadius: BorderRadius.circular(20)),
        child: Text(
          widget.title,
          style: Theme.of(context).textTheme.bodyText1.copyWith(
              fontSize: Dimensions.defaultTextSize,
              color: c ? Colors.white : Colors.black),
        ),
      ),
    );
  }
}

class TextBoxD extends StatefulWidget {
  final String title;
  const TextBoxD(this.title, {Key key}) : super(key: key);

  @override
  _TextBoxDState createState() => _TextBoxDState();
}

class _TextBoxDState extends State<TextBoxD> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          d = !d;

          //uno=isSelected;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(right: 7, top: 10),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        decoration: BoxDecoration(
            color: d ? CustomColor.primaryColor : CustomColor.secondaryColor,
            borderRadius: BorderRadius.circular(20)),
        child: Text(
          widget.title,
          style: Theme.of(context).textTheme.bodyText1.copyWith(
              fontSize: Dimensions.defaultTextSize,
              color: d ? Colors.white : Colors.black),
        ),
      ),
    );
  }
}

class TextBox extends StatefulWidget {
  final String title;
  const TextBox(this.title, {Key key}) : super(key: key);

  @override
  _TextBoxState createState() => _TextBoxState();
}

class _TextBoxState extends State<TextBox> {
  bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          uno = !uno;

          isSelected = uno;
          //uno=isSelected;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(right: 7, top: 10),
        padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 5),
        decoration: BoxDecoration(
            color: isSelected
                ? CustomColor.primaryColor
                : CustomColor.secondaryColor,
            borderRadius: BorderRadius.circular(20)),
        child: Text(
          widget.title,
          style: Theme.of(context).textTheme.bodyText1.copyWith(
              fontSize: Dimensions.defaultTextSize,
              color: isSelected ? Colors.white : Colors.black),
        ),
      ),
    );
  }
}
