import 'package:flutter/material.dart';
import 'package:parkline/models/direccion.dart';
import 'package:parkline/models/servicioadmin.dart';
import 'package:parkline/models/user.dart';
import 'package:parkline/models/espacios.dart';
import 'package:parkline/models/response_api.dart';
import 'package:parkline/models/resenia.dart';
import 'package:parkline/models/parqueo.dart';
import 'package:parkline/pages/map_markers_search.dart';
import 'package:parkline/pages/mapa_page.dart';
import 'package:parkline/pages/mapa_page_copy.dart';
import 'package:parkline/providers/usuarios_provider.dart';
import 'package:parkline/screens/dashboard/direction_history_screen.dart';
import 'package:parkline/screens/dashboard_screen.dart';
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

String selectedVehicle = 'assets/images/vehicle/tourism.png';
String selectedVehicle2;

String vehiculo = 'assets/images/vehicle/tourism.png';
String moto = 'assets/images/vehicle/motorbike2.png';
String camion = 'assets/images/vehicle/truck.png';
String bus = 'assets/images/vehicle/bus.png';

class DashboardScreenFilter extends StatefulWidget {
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

  List<Parqueo> listaconcidencias;

  DashboardScreenFilter(
      {Key key,
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
      this.listaconcidencias})
      : super(key: key);

  @override
  _DashboardScreenFilterState createState() => _DashboardScreenFilterState();
}

class _DashboardScreenFilterState extends State<DashboardScreenFilter> {
  List<Parqueo> listaconcidencias = [];

  SharedPref _sharedPref = new SharedPref();

  @override
  void initState() {
    listaconcidencias = widget.listaconcidencias;

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
  }

  User user;

  TextEditingController searchController = TextEditingController();

  TimeOfDay selectedEntranceTime = TimeOfDay.now();
  String entranceTime = '00:00';

  TimeOfDay selectedExitTime = TimeOfDay.now();
  String exitTime = '01:00';

  bool isConfirm = false;

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final ServiciosadminProvider serviciosProvider =
        new ServiciosadminProvider();

    final parqueosService = Provider.of<ParqueosService>(context);
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
                    'Historial de Parqueos',
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

                  child: MapMarkersSearch(
                      idusuario: widget.id,
                      nombreusuario: widget.nombre,
                      telefono: widget.telefono,
                      modelo_auto: widget.modelo_auto,
                      placa_auto: widget.placa_auto,
                      imagen_usuario: widget.imagen,
                      listadito: listaconcidencias),

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
                  'CONFIRMAR',
                  style: TextStyle(
                      color: Colors.white, fontSize: Dimensions.largeTextSize),
                ),
              ),
            ),
            onTap: () async {
              String keyword = searchController.text.trim();
              listaconcidencias = await parqueosProvider.buscar(keyword);

              print(keyword);
              setState(() {
                isConfirm = !isConfirm;
                print(isConfirm.toString());
              });
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
                      onTap: () {
                        setState(() async {
                          /* isConfirm = !isConfirm;
                          print(isConfirm.toString());*/

                          User user = User.fromJson(
                              await _sharedPref.read('user') ?? {});

                          Navigator.of(context)
                              .pushReplacement(MaterialPageRoute(
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
                        });
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
                            .reviewsbyPark(parkingPoint.idParqueo);

                        //Obtener cantidad de espacios disponbiles

                        ResponseApi responseApiespacios = await parqueosProvider
                            .getslots(parkingPoint.idParqueo);

                        Espacios espacios =
                            Espacios.fromJson(responseApiespacios.data);

                        String ocupados = espacios.espaciosOcupados;
                        int espaciodisponibles =
                            int.parse(parkingPoint.capacidadMaxima) -
                                int.parse(ocupados);

                        String espacioslibres = espaciodisponibles.toString();

                        print('ESPACIOS: ${espacioslibres}');

                        // print(listar);

                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ParkingPointDetailsScreen(
                                idpark: parkingPoint.idParqueo,
                                name: parkingPoint
                                    .nombreEmpresa, //        name: parkingPoint.name,
                                amount: parkingPoint.capacidadMaxima,
                                image: parkingPoint.imagenes,
                                address: parkingPoint.direccion,
                                slots: espacioslibres,
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
          return VehicleBottomSheet();
        });
  }
}

class VehicleBottomSheet extends StatefulWidget {
  @override
  _VehicleBottomSheetState createState() => _VehicleBottomSheetState();
}

class _VehicleBottomSheetState extends State<VehicleBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.6,
      color: Color(0xFF737373),
      child: new Container(
          decoration: new BoxDecoration(
              color: Colors.white,
              borderRadius: new BorderRadius.only(
                  topLeft: const Radius.circular(20.0),
                  topRight: const Radius.circular(20.0))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 30,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    //color: Colors.grey.withOpacity(0.3),
                    borderRadius: new BorderRadius.only(
                        topLeft: const Radius.circular(20.0),
                        topRight: const Radius.circular(20.0))),
                child: Center(
                  child: Container(
                    height: 5.0,
                    width: 100.0,
                    decoration: BoxDecoration(
                        color: CustomColor.primaryColor,
                        borderRadius: BorderRadius.all(
                            Radius.circular(Dimensions.radius))),
                  ),
                ),
              ),
              vehicleWidget(context)
            ],
          )),
    );
  }

  vehicleWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          left: Dimensions.marginSize,
          right: Dimensions.marginSize,
          top: Dimensions.heightSize * 3),
      child: Column(
        children: [
          Text(
            'Elige tu vehículo',
            style: TextStyle(
              fontSize: Dimensions.extraLargeTextSize * 1.5,
            ),
          ),
          SizedBox(
            height: Dimensions.heightSize * 1.5, //2
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.4,
            width: MediaQuery.of(context).size.width,
            child: GridView.count(
              crossAxisCount: 4,
              children: List.generate(VehicleList.list().length, (index) {
                Vehicle vehicle = VehicleList.list()[index];
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: GestureDetector(
                    child: Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                          border:
                              Border.all(color: Colors.black.withOpacity(0.1)),
                          borderRadius:
                              BorderRadius.all(Radius.circular(50.0))),
                      child: Image.asset(vehicle.image),
                    ),
                    onTap: () {
                      print('data: ' + vehicle.image);
                      setState(() {
                        selectedVehicle = vehicle.image;
                      });
                      Navigator.of(context).pop();
                    },
                  ),
                );
              }),
            ),
          ),
          SizedBox(
            height: Dimensions.heightSize * 1.5, //2
          ),
        ],
      ),
    );
  }
}
