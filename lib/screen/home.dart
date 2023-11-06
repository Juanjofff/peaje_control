import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:peaje_control/model/peajeregistro.dart';
import 'package:peaje_control/model/placa.dart';
import 'package:peaje_control/screen/dialog/nuevo_registro.dart';
import 'package:peaje_control/screen/dialog/pasadas_dialog.dart';
import 'package:peaje_control/screen/dialog/placa_dialog.dart';
import 'package:peaje_control/screen/dialog/recarga_dialog.dart';
import 'package:peaje_control/screen/util/util.dart';
import 'package:peaje_control/services/peaje_service.dart';

import '../enums/enum.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Util util = Util();

  ///lista de placas registradas
  List<Placa> _placas = [];

  @override
  void initState() {
    super.initState();
    _loadInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 5,
        title: const Text('Control de Peaje'),
        leading: IconButton(
            onPressed: () {
              _openDialogPlaca();
            },
            icon: const Icon(Icons.add)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: _body(),
        ),
      ),
    );
  }

  ///Lista de widgets con toda la estructura de la aplicación
  List<Widget> _body() {
    List<Widget> cols = [];
    cols.add(const Center(
      child: Text(
        'Registre sus placas con sus respectivos peajes',
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 22, fontWeight: FontWeight.bold, color: Colors.blueGrey),
      ),
    ));
    cols.add(Column(
      children: List.generate(_placas.length, (index) {
        return _cardPlaca(index);
      }),
    ));
    return cols;
  }

  ///Card con la información de cada placa y la lista de los peajes asignado a cada una
  Widget _cardPlaca(int index) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Column(
          children: [
            const SizedBox(height: 5),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _placas[index].placa,
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueGrey),
                ),
                Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          _openDialogPeaje(index);
                        },
                        icon: const Icon(
                          Icons.add,
                          color: Colors.blue,
                        )),
                    IconButton(
                        onPressed: () {
                          _openDialogDeletePlaca(index, _placas[index].placa);
                        },
                        icon: const Icon(
                          Icons.delete_outline,
                          color: Colors.redAccent,
                        )),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10),
            Column(
              children:
                  List.generate(_placas[index].peajes.length, (indexPeaje) {
                return _cardPeaje(index, indexPeaje);
              }),
            ),
          ],
        ),
      ),
    );
  }

  ///Información de cada peaje con su saldo.
  Widget _cardPeaje(int indexPlaca, int indexPeaje) {
    return ListTile(
      title:
          Util().textPeaje(_placas[indexPlaca].peajes[indexPeaje].peaje.nombre),
      trailing: Wrap(
        alignment: WrapAlignment.center,
        direction: Axis.vertical,
        children: [
          Text(
            _placas[indexPlaca].peajes[indexPeaje].saldo.toStringAsFixed(2),
            style: TextStyle(
                color:
                    _colorSaldo(_placas[indexPlaca].peajes[indexPeaje].saldo),
                fontSize: 20),
          ),
          IconButton(
              onPressed: () {
                _openDialogDeletePeaje(
                    _placas[indexPlaca].placa,
                    _placas[indexPlaca].peajes[indexPeaje].peaje.nombre,
                    indexPeaje,
                    indexPlaca);
              },
              icon: const Icon(
                Icons.delete_forever,
                color: Colors.red,
              ))
        ],
      ),
      leading: Column(
        children: [
          IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) => PasadasDialog(
                        pasadas: _placas[indexPlaca]
                            .peajes[indexPeaje]
                            .listaPasadas));
              },
              icon: const Icon(Icons.list)),
        ],
      ),
      subtitle: Wrap(
        spacing: 5,
        children: [
          Row(
            children: List.generate(
                _placas[indexPlaca].peajes[indexPeaje].peaje.valorPasada.length,
                (index) {
              return ElevatedButton(
                  onPressed: () async {
                    await PeajeService().updatePeajeInPlaca(
                        indexPlaca,
                        indexPeaje,
                        _placas[indexPlaca]
                            .peajes[indexPeaje]
                            .peaje
                            .valorPasada[index]);
                    await _loadInfo();
                  },
                  child: Text(_placas[indexPlaca]
                      .peajes[indexPeaje]
                      .peaje
                      .valorPasada[index]
                      .toStringAsFixed(2)));
            }),
          ),
          ElevatedButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) => RecargaDialog(
                        placa: _placas[indexPlaca].placa,
                        peaje: _placas[indexPlaca]
                            .peajes[indexPeaje]
                            .peaje
                            .nombre)).then((value) async {
                  double d = double.tryParse(value.toString()) ?? 0;
                  if (d > 0) {
                    await PeajeService()
                        .updateRecargaPeajeInPlaca(indexPlaca, indexPeaje, d);
                    await _loadInfo();
                  }
                });
              },
              child: const Text('Recarga')),
        ],
      ),
    );
  }

  Color _colorSaldo(double val) {
    if (val > 5) {
      return Colors.green;
    } else if (val > 0) {
      return Colors.deepOrangeAccent;
    } else {
      return Colors.red;
    }
  }

  ///abre el dialogo para crear una placa
  _openDialogPlaca() {
    showDialog(context: context, builder: (context) => const PlacaDialog())
        .then((value) => _registerPlaca(value));
  }

  ///abre el diálogo para registrar un peaje
  _openDialogPeaje(int indexPlaca) {
    showDialog(context: context, builder: (context) => const NuevoRegistro())
        .then((value) => _registerPeaje(value, indexPlaca));
  }

  ///Borra el peaje asignado a una placa
  _openDialogDeletePeaje(
      String placa, String peaje, int indexPeaje, int indexPlaca) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(placa),
              content: Text('¿Está seguro de borrar el peaje $peaje'),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop('S');
                    },
                    child: const Text(
                      'Sí',
                      style: TextStyle(color: Colors.blue),
                    )),
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop('N');
                    },
                    child:
                        const Text('No', style: TextStyle(color: Colors.red)))
              ],
            )).then((value) async {
      if (value == 'S') {
        await PeajeService().removePeajeInPlaca(indexPeaje, indexPlaca);
        await _loadInfo();
      }
    });
  }

  ///borra el diálogo de una placa
  _openDialogDeletePlaca(int index, String placa) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text('Borrar placa'),
              content: Text('¿Está seguro que desea borrar la placa $placa?'),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop('S');
                    },
                    child: const Text(
                      'Sí',
                      style: TextStyle(color: Colors.blue),
                    )),
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop('N');
                    },
                    child:
                        const Text('No', style: TextStyle(color: Colors.red)))
              ],
            )).then((value) async {
      if (value == 'S') {
        await PeajeService().removePlaca(index);
        await _loadInfo();
      }
    });
  }

  ///carga la información inicial
  Future _loadInfo() async {
    await PeajeService().createPeajes();
    var data = await Hive.openBox(Database.registros.val);
    setState(() {
      _placas = List.from(data.values);
    });
  }

  ///registra un peaje nuevo a una placa
  Future _registerPeaje(PeajeRegistro pr, int indexPlaca) async {
    if (pr.peaje.nombre.isNotEmpty) {
      if (_validarPeajeRegistrado(
          pr.peaje.nombre, _placas[indexPlaca].peajes)) {
        await PeajeService().registerPeajeInPlaca(pr, indexPlaca);
        await _loadInfo();
      } else {}
    }
  }

  ///valida si un peaje ya está registrado en esa placa
  bool _validarPeajeRegistrado(String peaje, List<PeajeRegistro> peajes) {
    for (var p in peajes) {
      if (p.peaje.nombre == peaje) {
        return false;
      }
    }
    return true;
  }

  ///Registra una placa nueva en el sistema
  Future _registerPlaca(String placa) async {
    if (placa.isNotEmpty) {
      await PeajeService().createPlaca(placa);
      await _loadInfo();
    }
  }
}
