import 'package:hive/hive.dart';

part 'peaje.g.dart';

@HiveType(typeId: 0)
class Peaje {
  @HiveField(0)
  String nombre = '';
  @HiveField(1)
  double valorPasada = 0;

  Peaje(this.nombre, this.valorPasada);
}

