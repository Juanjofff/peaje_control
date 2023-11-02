import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:peaje_control/enums/enum.dart';
import 'package:peaje_control/model/peaje.dart';
import 'package:peaje_control/model/peajeregistro.dart';

class NuevoRegistro extends StatefulWidget {
  const NuevoRegistro({super.key});

  @override
  State<NuevoRegistro> createState() => _NuevoRegistroState();
}

class _NuevoRegistroState extends State<NuevoRegistro> {
  ///registra el saldo inicial del peaje
  final TextEditingController _saldoController = TextEditingController();

  ///lista de todos los peajes registrados en el sistema
  List<Peaje> _listaPeajes = [];

  ///peaje a ser seleccionado
  String _peaje = '';

  ///indice de la lista de peajes
  int _index = 0;

  ///muestra si hay un mensaje de error
  bool _showMessage = false;

  ///mensaje de error en el diálogo
  String _message = '';

  @override
  void initState(){
    super.initState();
    _loadInfo();
  }

  ///carga la información inicial de los peajes creados
  Future _loadInfo() async {
    var data = await Hive.openBox(Database.peaje.val);
    setState(() {
      _listaPeajes = List.from(data.values);
    });
  }

  @override
  void dispose(){
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Nuevo Registro'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Column(
            children: List.generate(_listaPeajes.length, (index) {
              return RadioListTile(
                title: Text(_listaPeajes[index].nombre),
                value: _listaPeajes[index].nombre,
                groupValue: _peaje,
                onChanged: (value) {
                  setState(() {
                    _peaje = value!;
                    _index = index;
                  });
                },
              );
            }),
          ),
          TextField(
            controller: _saldoController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              hintText: 'Saldo Inicial',
              labelText: 'Saldo',
            ),
          ),
          Visibility(visible: _showMessage, child: Text(_message))
        ],
      ),
      actions: [
        TextButton(
            onPressed: () {
              _saveData();
            },
            child: const Text('Guardar', style: TextStyle(color: Colors.blue))),
        TextButton(
            onPressed: () {
              _returnClear();
            },
            child: const Text('Cancelar',
                style: TextStyle(color: Colors.redAccent)))
      ],
    );
  }

  ///Retorna el diálogo con información vacía
  _returnClear() {
    Navigator.of(context)
        .pop(PeajeRegistro(Peaje('', []), DateTime.now(), 0, 0, 0, 0, []));
  }

  ///Valida la información del nuevo registro creado y retorna el diálogo con la información seleccionada.
  _saveData() {
    if (_saldoController.text.trim().isNotEmpty) {
      try {
        double saldo = double.parse(_saldoController.text);
        if (saldo > 0) {
          if (_peaje.isNotEmpty) {
            Navigator.of(context).pop(PeajeRegistro(
                _listaPeajes[_index], DateTime.now(), saldo, 0, 0, saldo, []));
          } else {
            _showMessage = true;
            _message = 'Seleccione un peaje';
          }
        } else {
          _showMessage = true;
          _message = 'El saldo debe ser mayor a 0';
        }
      } catch (e) {
        _showMessage = true;
        _message = 'El saldo inicial está mal ingresado';
      }
    } else {
      setState(() {
        _showMessage = true;
        _message = 'Ingrese un saldo inicial';
      });
    }
  }
}
