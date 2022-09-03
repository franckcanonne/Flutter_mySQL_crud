import 'package:flutter/material.dart';

import './screens/create.dart';
import './screens/details.dart';
import './screens/edit.dart';
import './screens/home.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Liste de courses',
      initialRoute: '/',
      routes: {
        '/': (context) => const Home(),
        '/create': (context) => Create(),
        '/details': (context) => Details(),
        '/edit': (context) => Edit(),
      },
    );
  }
}
