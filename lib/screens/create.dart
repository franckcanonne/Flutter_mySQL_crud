import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../env.dart';
import '../widgets/form.dart';

class Create extends StatefulWidget {
  final Function refreshAchatList;

  Create({this.refreshAchatList});

  @override
  _CreateState createState() => _CreateState();
}

class _CreateState extends State<Create> {
  // Required for form validations
  final formKey = GlobalKey<FormState>();

  // Handles text onchange
  TextEditingController nameController = new TextEditingController();
  TextEditingController ageController = new TextEditingController();

  // Http post request to create new data
  Future _createAchat() async {
    return await http.post(
      Uri.parse("${Env.URL_PREFIX}/create.php"),
      body: {
        "name": nameController.text,
        "age": ageController.text,
      },
    );
  }

  void _onConfirm(context) async {
    await _createAchat();

    // Remove all existing routes until the Home.dart, then rebuild Home.
    Navigator.of(context)
        .pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ajout"),
      ),
      bottomNavigationBar: BottomAppBar(
        child: RaisedButton(
          child: Text("Confirmer"),
          color: Color.fromARGB(255, 0, 255, 0),
          textColor: Colors.black,
          onPressed: () {
            if (formKey.currentState.validate()) {
              _onConfirm(context);
            }
          },
        ),
      ),
      body: Container(
        height: double.infinity,
        padding: EdgeInsets.all(20),
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(12),
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
