import 'package:flutter/material.dart';
import 'package:peaje_control/screen/util/util.dart';

class RecargaDialog extends StatefulWidget {
  const RecargaDialog({super.key, required this.placa, required this.peaje});

  ///Placa utilizada para la recarga
  final String placa;

  ///Nombre del peaje en el cuál se realizará la recarga
  final String peaje;

  @override
  State<RecargaDialog> createState() => _RecargaDialogState();
}

class _RecargaDialogState extends State<RecargaDialog> {
  ///Controller del valor de la recarga
  final TextEditingController _recargaController = TextEditingController();

  ///se activa cuando existe algún error y muestra el mensaje
  bool _showMessage = false;

  ///mensaje de error
  String _message = '';

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('${widget.placa}-${widget.peaje}'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(5),
            child: TextField(
              controller: _recargaController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: 'Recarga',
                labelText: 'Recarga',
              ),
            ),
          ),
          Util().visibleUtil(_showMessage, _message),
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

  ///Retorna información vacía al presionar cancelar
  _returnClear() {
    Navigator.of(context).pop(0);
  }

  ///Valida la información del campo recarga y retorna a la pantalla anterior.
  _saveData() {
    if (_recargaController.text.trim().isNotEmpty) {
      double d = double.tryParse(_recargaController.text.trim()) ?? 0;
      if (d > 0) {
        Navigator.of(context).pop(d);
      } else {}
    } else {
      setState(() {
        _showMessage = true;
        _message = 'Ingrese información de recarga';
      });
    }
  }
}
