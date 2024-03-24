import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:immunity_frontend/avk/avk_even_layout_grid.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

import 'types/person.dart';
import 'widgets/person_card.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green.shade800),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Immunity'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Person> pop = [];

  Future<void> initialize() async {
    final Dio dio = Dio();

    Response res = await dio.get('http://localhost:3000/initialize-population');

    setState(() {
      pop = List<Person>.from(res.data["json"].map((x) => Person.fromJson(x)))
        ..sort((a, b) => a.id.compareTo(b.id));
      ;
    });
  }

  Future<void> evolve() async {
    final Dio dio = Dio();

    Response res = await dio.get('http://localhost:3000/evolve-population');

    setState(() {
      pop = List<Person>.from(res.data["json"].map((x) => Person.fromJson(x)))
        ..sort((a, b) => a.id.compareTo(b.id));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Gap(16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton.icon(
                  label: const Text('Evolve'),
                  icon: const Icon(Symbols.next_plan),
                  onPressed: evolve,
                ),
                TextButton.icon(
                  label: const Text('Restart'),
                  icon: const Icon(Symbols.restart_alt),
                  onPressed: initialize,
                ),
              ],
            ),
            const Gap(16),
            AvkEvenLayoutGrid(
              columnCount: 8,
              children: pop.map((p) => PersonCard(person: p)).toList(),
            ),
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
