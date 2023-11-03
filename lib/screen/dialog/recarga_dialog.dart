import 'package:flutter/material.dart';

class RecargaDialog extends StatefulWidget {
  const RecargaDialog({super.key, required this.placa, required this.peaje});

  final String placa;
  final String peaje;

  @override
  State<RecargaDialog> createState() => _RecargaDialogState();
}

class _RecargaDialogState extends State<RecargaDialog> {
  final TextEditingController _recargaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
