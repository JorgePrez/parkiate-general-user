part of 'mi_ubicacion_bloc.dart';

@immutable
abstract class MiUbicacionEvent {}
//creando un evento que modifica el state

class OnUbicacionCambio extends MiUbicacionEvent {
  final LatLng ubicacion;
  OnUbicacionCambio(this.ubicacion);
}
