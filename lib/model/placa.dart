import 'package:peaje_control/model/peajeregistro.dart';
import 'package:hive/hive.dart';

part 'placa.g.dart';

@HiveType(typeId: 3)
///registro de placa con los peajes que tiene cada una
class Placa {
  @HiveField(0)
  ///placa registrada 
  String placa = '';
  @HiveField(1)
  ///lista de peajes
  List<PeajeRegistro> peajes = [];

  Placa(this.placa, this.peajes);
}
