part of 'widgets.dart';

class MarcadorManualRuta extends StatelessWidget {
  final double latitude, longitude;

  MarcadorManualRuta({
    Key key,
    this.latitude,
    this.longitude,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //return _BuildMarcadorManual();

    return BlocBuilder<BusquedaBloc, BusquedaState>(
      builder: (context, state) {
        //con esta desaparece al ponerle !state.seleccionManual

        return _BuildMarcadorManualRuta(
            latitude: this.latitude, longitude: this.longitude);
      },
    );
  }
}

class _BuildMarcadorManualRuta extends StatelessWidget {
  final double latitude, longitude;

  _BuildMarcadorManualRuta({
    Key key,
    this.latitude,
    this.longitude,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //return this.calcularDestino(context);

    final width = MediaQuery.of(context).size.width;

    final height = MediaQuery.of(context).size.height;
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        //Boton regresar

        //Boton de para mapa grande
        Positioned(
            bottom: 650, //70
            left: 10, //40
            child: FadeIn(
              child: MaterialButton(
                  //minWidth: width - 200, //120
                  minWidth: width - 75, //120

                  child: Text(' Ver o Actualizar Ruta',
                      style: TextStyle(color: Colors.white)),
                  color: Colors.red,
                  shape: StadiumBorder(),
                  elevation: 0, //0
                  splashColor: Colors.blue,
                  onPressed: () {
                    this.calcularDestino(context);
                  }),
            )),

        Positioned(
            bottom: 0, //70
            left: 0, //40
            child: FadeIn(
              child: MaterialButton(
                  //minWidth: width - 200, //120
                  minWidth: width - 120, //120

                  child: Text('Ver o Actualizar Ruta',
                      style: TextStyle(color: Colors.white)),
                  color: Colors.red,
                  //  shape: StadiumBorder(),
                  elevation: 0, //0
                  splashColor: Colors.blue,
                  onPressed: () {
                    this.calcularDestino(context);
                  }),
            )),
      ],
    );
  }

  void calcularDestino(BuildContext context) async {
    //E.E.L
    calculandoAlerta(context); // personalziar mensajes recibir como argumetnos

    final trafficService = new TrafficService();

    final mapaBloc = context.bloc<MapaBloc>();

    final inicio = context.bloc<MiUbicacionBloc>().state.ubicacion;
    //contexo o con provide, aqui puede ser cualquier ubicacion , ultima ubicacion conocida

    //final destino = mapaBloc.state.ubicacionCentral;
    //LanLng ,
    //final destino = LatLng(14.6432, -90.5177);
    double latitude = this.latitude;
    double longitude = this.longitude;

    final destino = LatLng(latitude, longitude);

    print("Este es el destino: ${destino}");

    //en lugar de tener una ubicacion central,
    //yo deseo la ubicacion guardada en la base de datos , la cual deberia estar en parking point details.

    //obteniendo informacion del destino
    final reverseQueryResponse =
        await trafficService.getCoordenadasInfo(destino);

    final trafficResponse =
        await trafficService.getCoordsInicioYDestino(inicio, destino);

    final geometry = trafficResponse.routes[0].geometry;
    final duracion = trafficResponse.routes[0].duration;
    final distancia = trafficResponse.routes[0].distance;
    final nombreDestino = reverseQueryResponse.features[0].text;

    //Decocificar los puntos del geometry
    final points = Poly.Polyline.Decode(encodedString: geometry, precision: 6)
        .decodedCoords;

    // final temp = points;

    final List<LatLng> rutaCoordenadas =
        points.map((point) => LatLng(point[0], point[1])).toList();

    mapaBloc.add(OnCrearRutaInicioDestino(
        rutaCoordenadas, distancia, duracion, nombreDestino));
    Navigator.of(context).pop();

    context.bloc<BusquedaBloc>().add(OnDesactivarMarcadorManual());
  }
}
