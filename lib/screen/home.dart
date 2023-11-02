import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:peaje_control/model/peajeregistro.dart';
import 'package:peaje_control/model/placa.dart';
import 'package:peaje_control/screen/dialog/nuevo_registro.dart';
import 'package:peaje_control/screen/dialog/placa_dialog.dart';
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
  void initState(){
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
        'Control de Saldo de Peajes',
        style: TextStyle(
            fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blueGrey),
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
      child: Column(
        children: [
          Wrap(
            spacing: 10,
            children: [
              Text(
                _placas[index].placa,
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueGrey),
              ),
              IconButton(
                  onPressed: () {
                    _openDialogPeaje(index);
                  },
                  icon: const Icon(
                    Icons.add,
                    color: Colors.blue,
                  ))
            ],
          ),
          const SizedBox(height: 10),
          Column(
            children: List.generate(_placas[index].peajes.length, (indexPeaje) {
              return _cardPeaje(index, indexPeaje);
            }),
          ),
        ],
      ),
    );
  }

  ///Información de cada peaje con su saldo.
  Widget _cardPeaje(int indexPlaca, int indexPeaje) {
    return ListTile(
      title: Text(_placas[indexPlaca].peajes[indexPeaje].peaje.nombre),
      trailing: Text(
        _placas[indexPlaca].peajes[indexPeaje].saldo.toStringAsFixed(2),
        style: const TextStyle(color: Colors.red),
      ),
      subtitle: Wrap(
        spacing: 5,
        children: [
          ElevatedButton(onPressed: () {}, child: const Text('Recarga')),
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
          )
        ],
      ),
    );
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
      await PeajeService().registerPeajeInPlaca(pr, indexPlaca);
      await _loadInfo();
    }
  }

  ///Registra una placa nueva en el sistema
  Future _registerPlaca(String placa) async {
    if (placa.isNotEmpty) {
      await PeajeService().createPlaca(placa);
      await _loadInfo();
    }
  }
}
