import 'package:flutter/material.dart';
import 'package:flutter_assignment/src/assignment/dart_assignment/dart_assignment.dart';
import 'package:flutter_assignment/src/assignment/flutter_assignment/flutter_assignment.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: const FlutterAssignment(),
      
      home: const ReorderableApp(),
    );
  }
}
