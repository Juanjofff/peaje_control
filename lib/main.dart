import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:peaje_control/model/pasada.dart';
import 'package:peaje_control/model/peaje.dart';
import 'package:peaje_control/model/peajeregistro.dart';
import 'package:peaje_control/model/placa.dart';
import 'package:peaje_control/screen/home.dart';


void main() async{

  await Hive.initFlutter();
  Hive.registerAdapter(PeajeAdapter());
  Hive.registerAdapter(PasadaAdapter());
  Hive.registerAdapter(PeajeRegistroAdapter());
  Hive.registerAdapter(PlacaAdapter());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  /// This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Peaje Control',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

