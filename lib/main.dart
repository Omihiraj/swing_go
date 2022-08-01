import 'package:curved_navigation_bar/curved_navigation_bar.dart';

import 'package:flutter/material.dart';
import 'package:swim_app/main_page.dart';

import 'package:swim_app/views/contact.dart';
import 'package:swim_app/views/lessons.dart';
import 'package:swim_app/views/trainer.dart';
import 'package:firebase_core/firebase_core.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Swimming App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int index = 0;
  final screens = [
    const MainPage(),
    const Lesson(),
    const TrainerLoging(),
    const Contact()
  ];
  @override
  Widget build(BuildContext context) {
    final items = <Widget>[
      const Icon(Icons.home, size: 30),
      const Icon(Icons.book, size: 30),
      const Icon(Icons.person, size: 30),
      const Icon(Icons.settings, size: 30),
    ];
    return Scaffold(
      backgroundColor: Colors.grey[100],
      bottomNavigationBar: Theme(
        data: Theme.of(context)
            .copyWith(iconTheme: const IconThemeData(color: Colors.white)),
        child: CurvedNavigationBar(
          color: Colors.lightBlueAccent,
          backgroundColor: Colors.transparent,
          height: 60,
          index: index,
          items: items,
          onTap: (index) => setState(() {
            this.index = index;
          }),
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent,
        title: const Text(
          "Swing Go",
          style: TextStyle(
              fontSize: 32, letterSpacing: 4.0, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        bottom: const PreferredSize(
            child: SizedBox(), preferredSize: Size.fromHeight(10)),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(50.0),
              bottomRight: Radius.circular(50)),
        ),
      ),
      body: screens[index],
    );
  }
}
