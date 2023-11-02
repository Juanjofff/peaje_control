import 'package:hive/hive.dart';
import 'package:peaje_control/model/pasada.dart';
import 'package:peaje_control/model/peaje.dart';
import 'package:peaje_control/model/peajeregistro.dart';

import '../enums/enum.dart';
import '../model/placa.dart';

class PeajeService {

  ///Limpia la lista de peajes creados, y crea nuevos.
  Future createPeajes() async {
    var data = await Hive.openBox(Database.peaje.val);
    await data.clear();
    await data.add(Peaje('Guayasamín', [0.40]));
    await data.add(Peaje('Gral Rumiñahui', [0.39, 0.25]));
    await data.add(Peaje('Panavial', [1, 0.6]));
  }

  ///registra un nuevo peaje en una placa
  Future registerPeajeInPlaca(PeajeRegistro pr, int index) async {
    var data = await Hive.openBox(Database.registros.val);
    Placa placa = List.from(data.values)[index];
    placa.peajes.add(pr);
    await data.put(index, placa);
  }

  ///registra una nueva placa
  Future createPlaca(String placa) async {
    var data = await Hive.openBox(Database.registros.val);
    await data.add(Placa(placa, []));
  }

  ///actualiza el saldo de un peaje según el valor de la pasada
  Future updatePeajeInPlaca(int indexPlaca, int indexPeaje, double pasada) async {
    var data = await Hive.openBox(Database.registros.val);
    Placa placa = List.from(data.values)[indexPlaca];
    placa.peajes[indexPeaje].pasadas = placa.peajes[indexPeaje].pasadas + pasada;
    placa.peajes[indexPeaje].saldo = placa.peajes[indexPeaje].saldo - pasada;
    Pasada p = Pasada(placa.peajes[indexPeaje].saldo, DateTime.now(), false);
    placa.peajes[indexPeaje].listaPasadas.add(p);
    await data.put(indexPlaca, placa);
  }

  ///actualiza el saldo de un peaje según el valor de la pasada
  Future updateRecargaPeajeInPlaca(int indexPlaca, int indexPeaje, double pasada) async {
    var data = await Hive.openBox(Database.registros.val);
    Placa placa = List.from(data.values)[indexPlaca];
    placa.peajes[indexPeaje].recargas = placa.peajes[indexPeaje].recargas + pasada;
    placa.peajes[indexPeaje].saldo = placa.peajes[indexPeaje].saldo + pasada;
    Pasada p = Pasada(placa.peajes[indexPeaje].saldo, DateTime.now(), true);
    placa.peajes[indexPeaje].listaPasadas.add(p);
    await data.put(indexPlaca, placa);
  }
}
