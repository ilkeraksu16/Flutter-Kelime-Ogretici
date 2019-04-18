import 'package:flutter/material.dart';
import 'package:kelimeler/kelimeler.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kelimeler',
      debugShowCheckedModeBanner: false,
      home: Kelimeler(),
    );
  }
}