import 'package:flutter/material.dart';

import 'board.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chess',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Chess'),
        ),
        backgroundColor: Colors.blueGrey,
        body: Board(),
      ),
    );
  }
}
