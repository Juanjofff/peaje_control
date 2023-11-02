import 'package:hive/hive.dart';
import 'package:peaje_control/model/pasada.dart';
import 'package:peaje_control/model/peaje.dart';

part 'peajeregistro.g.dart';

@HiveType(typeId: 2)
///registros del peaje
class PeajeRegistro {
  @HiveField(0)
  ///nombre del peaje y valor de cada pasada
  Peaje peaje = Peaje('', []);
  @HiveField(1)
  ///fecha en la que creó el registro
  DateTime fechaCreacion = DateTime.now();
  @HiveField(2)
  ///saldo con el que empezó
  double saldoInicial = 0;
  @HiveField(3)
  ///valor total en recargas realizadas
  double recargas = 0;
  @HiveField(4)
  ///valor total en pasadas realizadas
  double pasadas = 0;
  @HiveField(5)
  ///saldo que tiene en ese momento, saldo inicial + recargas - pasadas
  double saldo = 0;
  @HiveField(6)
  ///lista de todas las pasadas realizadas
  List<Pasada> listaPasadas = [];
  

  PeajeRegistro(this.peaje, this.fechaCreacion, this.saldoInicial,
      this.recargas, this.pasadas, this.saldo, this.listaPasadas);
}
