import 'package:hive/hive.dart';
import 'package:peaje_control/model/pasada.dart';
import 'package:peaje_control/model/peaje.dart';

part 'peajeregistro.g.dart';

@HiveType(typeId: 2)
class PeajeRegistro {
  @HiveField(0)
  Peaje peaje = Peaje('', 0);
  @HiveField(1)
  DateTime fechaCreacion = DateTime.now();
  @HiveField(2)
  double saldoInicial = 0;
  @HiveField(3)
  double recargas = 0;
  @HiveField(4)
  double pasadas = 0;
  @HiveField(5)
  double saldo = 0;
  @HiveField(6)
  List<Pasada> listaPasadas = [];
  

  PeajeRegistro(this.peaje, this.fechaCreacion, this.saldoInicial,
      this.recargas, this.pasadas, this.saldo, this.listaPasadas);
}
