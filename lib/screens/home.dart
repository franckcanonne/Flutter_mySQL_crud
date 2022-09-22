import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import './create.dart';
import './details.dart';
import '../env.dart';
import '../models/produit.dart';
import '../page_transitions.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  Future<List<Achat>> achats;
  final studentListKey = GlobalKey<HomeState>();

  @override
  void initState() {
    super.initState();
    achats = getAchatList();
  }

  Future<List<Achat>> getAchatList() async {
    final response = await http.get(Uri.parse("${Env.URL_PREFIX}/list.php"));

    final items = json.decode(response.body).cast<Map<String, dynamic>>();
    List<Achat> achats = items.map<Achat>((json) {
      return Achat.fromJson(json);
    }).toList();

    return achats;
  }

  void refreshStudentList() {
    setState(() {
      achats = getAchatList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: studentListKey,
      appBar: AppBar(
        title: const Text('Liste courses'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              refreshStudentList();
            },
          )
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/fond.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: FutureBuilder<List<Achat>>(
          future: achats,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            // By default, show a loading spinner.
            if (!snapshot.hasData) return const CircularProgressIndicator();
            // Franck.

            // Render student lists
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                var data = snapshot.data[index];
                return Card(
                  child: ListTile(
                    leading: const Icon(Icons.person),
                    trailing: const Icon(Icons.view_list),
                    title: Text(
                      data.name,
                      style: const TextStyle(fontSize: 20),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        EnterExitRoute(
                          exitPage: const Home(),
                          enterPage: Details(achat: data),
                        ),
                      );
                    },
                  ),
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) {
            return Create();
          }));
        },
      ),
    );
  }
}
