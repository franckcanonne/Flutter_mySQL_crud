import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import './create.dart';
import './details.dart';
import '../env.dart';
import '../models/achats.dart';
import '../page_transitions.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

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
        title: Text('Liste courses'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              refreshStudentList();
            },
          )
        ],
      ),
      body: Center(
        child: FutureBuilder<List<Achat>>(
          future: achats,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            // By default, show a loading spinner.
            if (!snapshot.hasData) return CircularProgressIndicator();

            // Render student lists
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                var data = snapshot.data[index];
                return Card(
                  child: ListTile(
                    leading: Icon(Icons.person),
                    trailing: Icon(Icons.view_list),
                    title: Text(
                      data.name,
                      style: TextStyle(fontSize: 20),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        EnterExitRoute(
                          exitPage: Home(),
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
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) {
            return Create();
          }));
        },
      ),
    );
  }
}
