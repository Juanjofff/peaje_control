import 'package:flutter/material.dart';
import 'package:peaje_control/screen/util/util.dart';

class PlacaDialog extends StatefulWidget {
  const PlacaDialog({super.key});

  @override
  State<PlacaDialog> createState() => _PlacaDialogState();
}

class _PlacaDialogState extends State<PlacaDialog> {
  final TextEditingController _placaController = TextEditingController();
  bool _showMessage = false;
  String _message = '';

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Nueva Placa'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _placaController,
            keyboardType: TextInputType.name,
            decoration:
                const InputDecoration(hintText: 'Placa', labelText: 'Placa'),
          ),
          Util().visibleUtil(_showMessage, _message),
        ],
      ),
      actions: [
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
                onPressed: () {
                  if (_placaController.text.trim().isNotEmpty) {
                    Navigator.of(context)
                        .pop(_placaController.text.trim().toUpperCase());
                  } else {
                    setState(() {
                      _showMessage = true;
                      _message = 'Ingrese la información de placa';
                    });
                  }
                },
                icon: const Icon(
                  Icons.save,
                  color: Colors.green,
                )),
            IconButton(
                onPressed: () {
                  Navigator.of(context).pop('');
                },
                icon: const Icon(
                  Icons.do_disturb,
                  color: Colors.red,
                ))
          ],
        )
      ],
    );
  }
}
