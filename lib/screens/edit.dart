import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../env.dart';
import '../models/produit.dart';
import '../widgets/form.dart';

class Edit extends StatefulWidget {
  final Achat achat;

  Edit({this.achat});

  @override
  _EditState createState() => _EditState();
}

class _EditState extends State<Edit> {
  // Required for form validations
  final formKey = GlobalKey<FormState>();

  // Handles text onchange
  TextEditingController nameController;
  TextEditingController ageController;

  // Http post request to update data
  Future editAchat() async {
    return await http.post(
      Uri.parse("${Env.URL_PREFIX}/update.php"),
      body: {
        "id": widget.achat.id.toString(),
        "name": nameController.text,
        "age": ageController.text
      },
    );
  }

  void _onConfirm(context) async {
    await editAchat();

    // Remove all existing routes until the Home.dart, then rebuild Home.
    Navigator.of(context)
        .pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
  }

  @override
  void initState() {
    nameController = TextEditingController(text: widget.achat.name);
    ageController = TextEditingController(text: widget.achat.age.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Modifier"),
      ),
      bottomNavigationBar: BottomAppBar(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: const Color.fromARGB(255, 0, 255, 8), // background
            onPrimary: Colors.black, // foreground
          ),
          onPressed: () {
            _onConfirm(context);
          },
          child: const Text('Confirmer'),
        ),
      ),
      body: Container(
        height: double.infinity,
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: AppForm(
              formKey: formKey,
              nameController: nameController,
              ageController: ageController,
            ),
          ),
        ),
      ),
    );
  }
}
