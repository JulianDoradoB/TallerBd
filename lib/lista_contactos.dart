import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class ListaContactosPage extends StatefulWidget {
  const ListaContactosPage({super.key});

  @override
  State<ListaContactosPage> createState() => _ListaContactosPageState();
}

class _ListaContactosPageState extends State<ListaContactosPage> {
  Box? contactosBox;
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _telefonoController = TextEditingController();
  final TextEditingController _correoController = TextEditingController();
  final TextEditingController _direccionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    contactosBox = Hive.box('contactos');  
  }

  
  void _addContact() {
    if (_nombreController.text.isNotEmpty && _telefonoController.text.isNotEmpty) {
      final newContact = {
        'nombre': _nombreController.text,
        'telefono': _telefonoController.text,
        'correo': _correoController.text,
        'direccion': _direccionController.text,
      };
      setState(() {
        contactosBox?.add(newContact);
      });
      _clearFields();
    }
  }

 
  void _deleteContact(int index) {
    setState(() {
      contactosBox?.deleteAt(index);
    });
  }

  
  void _clearFields() {
    _nombreController.clear();
    _telefonoController.clear();
    _correoController.clear();
    _direccionController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Contactos'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextField(
                  controller: _nombreController,
                  decoration: const InputDecoration(
                    labelText: 'Nombre',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: _telefonoController,
                  decoration: const InputDecoration(
                    labelText: 'Teléfono',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: _correoController,
                  decoration: const InputDecoration(
                    labelText: 'Correo',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: _direccionController,
                  decoration: const InputDecoration(
                    labelText: 'Dirección',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: _addContact,
                  child: const Text('Agregar Contacto'),
                ),
              ],
            ),
          ),
          
          // Lista de contactos
          Expanded(
            child: contactosBox != null && contactosBox!.isNotEmpty
                ? ListView.builder(
                    itemCount: contactosBox!.length,
                    itemBuilder: (context, index) {
                      final contact = contactosBox!.getAt(index);
                      return ListTile(
                        title: Text(contact['nombre']),
                        subtitle: Text('Tel: ${contact['telefono']}'),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () => _deleteContact(index),  
                        ),
                      );
                    },
                  )
                : const Center(
                    child: Text('No hay contactos agregados aún'),
                  ),
          ),
        ],
      ),
    );
  }
}