import 'package:flutter/material.dart';
import 'todo_app.dart';

void main() {
  runApp(const TodoKuApp());
}

class TodoKuApp extends StatelessWidget {
  const TodoKuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TodoKu',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const TodoApp(),
      debugShowCheckedModeBanner: false,
    );
  }
}