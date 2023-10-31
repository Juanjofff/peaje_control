import 'package:hive/hive.dart';

part 'pasada.g.dart';

@HiveType(typeId: 1)
class Pasada {
  @HiveField(0)
  double saldoRestante = 0;
  @HiveField(1)
  DateTime fechaPasada = DateTime.now();
  @HiveField(2)
  bool recarga = false;

  Pasada(this.saldoRestante, this.fechaPasada, this.recarga);
}
