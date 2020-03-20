import 'package:flutter/material.dart';
import 'beginner/bin2dec.dart';

void main() => runApp(MyApp());

final routes = {'/beginner/bin2dec': (context) => Bin2Dec()};

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: Map.of(routes)
        ..addAll({
          '/': (context) => MainActivity(),
        }),
      initialRoute: '/',
      title: 'App ideas flutter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}

class MainActivity extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: FlutterLogo(),
        title: Text('App ideas flutter'),
      ),
      body: ListView(
        children: routes.keys.map((it) {
          return ListTile(
            title: Hero(
              tag: 'title',
              child: Text(it),
            ),
            onTap: () {
              Navigator.of(context).pushNamed(it);
            },
          );
        }).toList(),
      ),
    );
  }
}
