import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'lista_contactos.dart'; // Asegúrate de importar tu pantalla ListaContactos

void main() async {
  WidgetsFlutterBinding.ensureInitialized();


  Directory appDocDir = await getApplicationDocumentsDirectory();
  Hive.init(appDocDir.path); 

  
  await Hive.openBox('contactos');

  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false, 
      title: 'Contactos Plus',
      home: ListaContactosPage(), 
    );
  }
}