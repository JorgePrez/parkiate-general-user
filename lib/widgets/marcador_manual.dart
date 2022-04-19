part of 'widgets.dart';

class MarcadorManual extends StatelessWidget {

      final String id_usuario;

  const MarcadorManual({Key key, this.id_usuario}) : super(key: key);


  @override
  Widget build(BuildContext context) {

    //return _BuildMarcadorManual();

    return BlocBuilder<BusquedaBloc, BusquedaState>(
      builder: (context, state) {
        return _BuildMarcadorManual(id_usuario: id_usuario,);


        //con esta desaparece al ponerle !state.seleccionManual
       
       //CONDICION QUE ES LALAMA DESDE EL Search destinatio0n
       /* if (state.seleccionManual) {
          return _BuildMarcadorManual();
        } else {
          return Container();
        }*/
      },
    );
  }
}

class _BuildMarcadorManual extends StatelessWidget {

      final String id_usuario;

  const _BuildMarcadorManual({Key key, @required this.id_usuario}) : super(key: key);





  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        //Boton regresar
        Positioned(
            top: 50,
            left: 20,
            child: FadeInLeft(
              duration: Duration(milliseconds: 150),
              child: CircleAvatar(
                maxRadius: 25,
                backgroundColor: Colors.white,
                child: IconButton(
                    icon: Icon(Icons.arrow_back, color: Colors.black87),
                    onPressed: () {


                    Navigator.of(context).pop();


                      /*context
                          .bloc<BusquedaBloc>()
                          .add(OnDesactivarMarcadorManual());*/
                    }),
              ),
            )),

        Center(
          child: Transform.translate(
            offset: Offset(0, -12),
            child: BounceInDown(
                child:
                    Icon(Icons.location_on, size: 50, color: Colors.black87)),
          ),
        ),

        //Boton de CONFIRMAR DESTINO

        Positioned(
            bottom: 70,
            left: 40,
            child: FadeIn(
              child: MaterialButton(
                  minWidth: width - 120,
                  child: Text('Confirmar Ubicación',
                      style: TextStyle(color: Colors.white)),
                  color: Colors.black,
                  shape: StadiumBorder(),
                  elevation: 0,
                  splashColor: Colors.transparent,
                  onPressed: () {
                    this.calcularDestino(context ,  id_usuario );
                  }),
            )),
      ],
    );
  }

  void calcularDestino(BuildContext context, String id_usuario) async {
    //E.E.L
   //calculandoAlerta(context); // personalziar mensajes recibir como argumetnos

    final trafficService = new TrafficService();

    final mapaBloc = context.bloc<MapaBloc>();

    final inicio = context.bloc<MiUbicacionBloc>().state.ubicacion;
    //contexo o con provide, aqui puede ser cualquier ubicacion , ultima ubicacion conocida

    final destino = mapaBloc.state.ubicacionCentral;

    print(destino);
    //LanLng ,
    // final destino = LatLng(14.6432, -90.5177);

    // print("Este es el destino: ${destino}");

    //en lugar de tener una ubicacion central,
    //yo deseo la ubicacion guardada en la base de datos , la cual deberia estar en parking point details.

    //obteniendo informacion del destino
    final reverseQueryResponse =
        await trafficService.getCoordenadasInfo(destino);

    final trafficResponse =
        await trafficService.getCoordsInicioYDestino(inicio, destino);

    /*final geometry = trafficResponse.routes[0].geometry;
    final duracion = trafficResponse.routes[0].duration;
    final distancia = trafficResponse.routes[0].distance;*/
    final nombreDestino = reverseQueryResponse.features[0].text; //.text;
        final nombredetallado = reverseQueryResponse.features[0].placeName; //.text;



    //Decocificar los puntos del geometry
   /* final points = Poly.Polyline.Decode(encodedString: geometry, precision: 6)
        .decodedCoords;

    // final temp = points;

    final List<LatLng> rutaCoordenadas =
        points.map((point) => LatLng(point[0], point[1])).toList();

    mapaBloc.add(OnCrearRutaInicioDestino(
        rutaCoordenadas, distancia, duracion, nombreDestino));
    //Navigator.of(context).pop();

    context.bloc<BusquedaBloc>().add(OnDesactivarMarcadorManual());*/
       _showPaymentSuccessDialog(context,nombreDestino,nombredetallado , destino.latitude , destino.longitude , id_usuario );
  }


  Future<bool> _showPaymentSuccessDialog(context,String nombre, String nombre_detallado, double latitude, double longitude, String id_usuario) async {

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

   TextEditingController  nombreController = TextEditingController(text: nombre);
   TextEditingController nombreDController = TextEditingController(text: nombre_detallado);

    

    return (await showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) => new AlertDialog(
            content: Container(
              height: MediaQuery.of(context).size.height * 0.50,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                     Form(
                       key: formKey,
                       child: Column(
                         children: [

                           Text(
                  'Datos de la ubicación ',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: Dimensions.largeTextSize * 1), //1.5
                ),

                           Container(
                             height: 60.0, //70
                             width: MediaQuery.of(context).size.width,
                             decoration: BoxDecoration(
                                 border: Border.all(color: Colors.black.withOpacity(0.1)),
                                 borderRadius: BorderRadius.circular(Dimensions.radius)),
                             child: TextFormField(
                               style: CustomStyle.textStyle,
                               controller: nombreController,
                               keyboardType: TextInputType.text,
                               //initialValue: "adadadas",

                               validator: (String value) {
                                 if (value.isEmpty) {
                                   return 'Por favor completa el campo';
                                 } else {
                                   return null;
                                 }
                               },
                               decoration: InputDecoration(
                                 labelText: 'Nombre:',
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
                             
                             height: 90.0, //70
                             width: MediaQuery.of(context).size.width,
                             decoration: BoxDecoration(
                                 border: Border.all(color: Colors.black.withOpacity(0.1)),
                                 borderRadius: BorderRadius.circular(Dimensions.radius)),
                             child: TextFormField(
                               style: CustomStyle.textStyle,
                               controller: nombreDController,
                               keyboardType: TextInputType.multiline,
                               maxLines: 3,
                               validator: (String value) {
                                 if (value.isEmpty) {
                                   return 'Por favor completa el campo';
                                 } else {
                                   return null;
                                 }
                               },
                               decoration: InputDecoration(
                                 labelText: 'Nombre detallado',
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
                             height: Dimensions.heightSize*1,
                           ),
                         ],
                       ),
                     ),

               
                
                 GestureDetector(
                    child: Container(
                      height: 60.0,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: CustomColor.redColor,
                          borderRadius: BorderRadius.all(
                              Radius.circular(Dimensions.radius))),
                      child: Center(
                        child: Text(
                          'Guardar Ubicación'.toUpperCase(),
                          style: TextStyle(
                                color: Colors.white,
                      fontSize: Dimensions.largeTextSize,
                      fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    onTap: () async{


                      
                        String nombre = nombreController.text.trim();
            String nombreB = nombreDController.text.trim();

        
                    UsuarioProvider usuarioProvider = new UsuarioProvider();

                    Direccion direccion = new Direccion(idUsuario: id_usuario , 
                                                         nombre: nombre,
                                                         nombreDetallado: nombreB ,
                                                         latitude: latitude.toString(),
                                                         longitude: longitude.toString());

                   ResponseApi responseApi = await usuarioProvider.createdireccion(direccion);
              
                         //Comprobar si Response Api es true



                    
                                  if (responseApi.success) {

                                   // TODO: obtener la lista de verdad


                               List<Direccion> lista = await usuarioProvider.getDirections(id_usuario);



                                                       Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) =>
                            DirectionHistoryScreen(listaservicios: lista, id_usuario: id_usuario)));


                                  }


                         


      





                      

                        
                    },
                  ),

                    SizedBox(
                height: Dimensions.heightSize * 1.5,
              ),

                  GestureDetector(
                    child: Container(
                      height: 60.0,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: Color(0xFFF5F5F6),
                          borderRadius: BorderRadius.all(
                              Radius.circular(Dimensions.radius))),
                      child: Center(
                        child: Text(
                          'Regresar'.toUpperCase(),
                          style: TextStyle(
                              fontSize: Dimensions.largeTextSize,
                              color: CustomColor.primaryColor,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    onTap: () {

                     // print("DUN DUN DANCE");
                       Navigator.of(context).pop();

                    
                    
                    /*

                    
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => SubmitReviewScreen(
                              idusuario: widget.idusuario,
                              idparqueo: widget.idparqueo,
                              nombreusuario: widget.nombreusuario,
                              imagenusuario: widget.imagenusuario)));
                              */
                    },
                  ),
                ],
              ),
            ),
          ),
        )) ??
        false;
  }

}
