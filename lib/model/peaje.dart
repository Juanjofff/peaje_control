import 'package:hive/hive.dart';

part 'peaje.g.dart';

@HiveType(typeId: 0)
///Peajes registrados
class Peaje {
  @HiveField(0)
  ///Nombre del peaje
  String nombre = '';
  @HiveField(1)
  ///Lista del valor de la pasada según el peaje
  List<double> valorPasada = [];

  Peaje(this.nombre, this.valorPasada);
}

