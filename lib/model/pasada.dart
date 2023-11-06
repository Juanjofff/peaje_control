import 'package:hive/hive.dart';

part 'pasada.g.dart';

@HiveType(typeId: 1)

///Pasadas realizadas en el peaje
class Pasada {
  @HiveField(0)

  ///saldo restante al culminar la pasada
  double saldoRestante = 0;
  @HiveField(1)

  ///fecha y hora en la que registró la pasada
  DateTime fechaPasada = DateTime.now();
  @HiveField(2)

  ///true: aumenta el saldo, false: baja el saldo
  bool recarga = false;
  @HiveField(3)

  ///Valor de la pasada o la recarga
  double valorPasada = 0;

  Pasada(this.saldoRestante, this.fechaPasada, this.recarga, this.valorPasada);
}
