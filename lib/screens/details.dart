// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import './edit.dart';
import '../env.dart';
import '../models/produit.dart';

class Details extends StatefulWidget {
  final Achat achat;

  // ignore: prefer_const_constructors_in_immutables
  Details({Key key, this.achat}) : super(key: key);

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  void deleteAchat(context) async {
    await http.post(
      Uri.parse("${Env.URL_PREFIX}/delete.php"),
      body: {
        'id': widget.achat.id.toString(),
      },
    );
    // Navigator.pop(context);
    Navigator.of(context)
        .pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
  }

  void confirmDelete(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content:
              const Text('Etes-vous sur de vouloir supprimer cet article ?'),
          actions: <Widget>[
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.red, // background
                onPrimary: Colors.white, // foreground
              ),
              onPressed: () => Navigator.of(context).pop(),
              child: const Icon(Icons.cancel),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.blue, // background
                onPrimary: Colors.white, // foreground
              ),
              onPressed: () => deleteAchat(context),
              child: const Icon(Icons.check_circle),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Détails'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () => confirmDelete(context),
          ),
        ],
      ),
      body: Container(
        height: 270.0,
        padding: const EdgeInsets.all(35),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Produit : ${widget.achat.name}",
              style: const TextStyle(fontSize: 20),
            ),
            const Padding(
              padding: EdgeInsets.all(10),
            ),
            Text(
              "Quentité : ${widget.achat.age}",
              style: const TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.edit),
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) => Edit(achat: widget.achat),
          ),
        ),
      ),
    );
  }
}
