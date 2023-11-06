import 'package:flutter/material.dart';
import 'package:peaje_control/model/pasada.dart';
import 'package:peaje_control/screen/util/util.dart';
import 'package:intl/intl.dart';

class PasadasDialog extends StatefulWidget {
  const PasadasDialog({super.key, required this.pasadas});

  final List<Pasada> pasadas;

  @override
  State<PasadasDialog> createState() => _PasadasDialogState();
}

class _PasadasDialogState extends State<PasadasDialog> {
  ///Lista de pasadas ordenadas desde la más reciente a la más antigua
  List<Pasada> _listaPasadas = [];

  ///Lista de pasadas que se mostrarán según la variable _cantidadRegistros
  List<Pasada> _listaPasadasMostrar = [];

  ///cantidad de últimos registros a ver
  int _cantidasRegistros = 10;

  @override
  void initState() {
    super.initState();
    _listaPasadas = widget.pasadas;
    _listaPasadas.sort((a, b) => (b.fechaPasada.compareTo(a.fechaPasada)));
    _loadInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Util().appBarUtil('Lista de Pasadas'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: List.generate(
              _listaPasadasMostrar.length, (index) => _cardPasada(index)),
        ),
      ),
    );
  }

  ///Carga la información inicial, la lista de pasadas o recargas según el campo _cantidadRegistros
  _loadInfo() {
    _listaPasadasMostrar = [];
    if (_listaPasadasMostrar.length <= _cantidasRegistros) {
      setState(() {
        _listaPasadasMostrar = _listaPasadas;
      });
    } else {
      for (int i = 0; i < _cantidasRegistros; i++) {
        setState(() {
          _listaPasadasMostrar.add(_listaPasadas[i]);
        });
      }
    }
  }

  ///Widget para mostrar la pasada
  Widget _cardPasada(int index) {
    return ListTile(
      title: Text(
        '${_listaPasadasMostrar[index].recarga ? '+' : '-'} ${_listaPasadasMostrar[index].valorPasada.toStringAsFixed(2)}',
        style: TextStyle(
            color: _listaPasadasMostrar[index].recarga
                ? Colors.green
                : Colors.redAccent),
      ),
      subtitle: Text(_fechaString(_listaPasadasMostrar[index].fechaPasada)),
      trailing: Column(
        children: [
          const Text('Saldo'),
          Text(
            _listaPasadas[index].saldoRestante.toStringAsFixed(2),
            style: const TextStyle(fontSize: 18),
          ),
        ],
      ),
    );
  }

  ///Transformación de Datetime a Stringfecha
  String _fechaString(var data) {
    var df = DateFormat('dd-MM-yyyy HH:mm:ss');
    return df.format(data);
  }
}
