import 'package:flutter/material.dart';
import 'package:sell_fish/pages/homepage.dart';

main() {
  runApp(const Myapp());
}

class Myapp extends StatefulWidget {
  const Myapp({super.key});

  @override
  State<Myapp> createState() => _MyappState();
}

class _MyappState extends State<Myapp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sell Fishes',
      theme: setThemeData(),
      home: const HomePage(),
    );
  }

  ThemeData setThemeData() {
    return ThemeData(
      appBarTheme: const AppBarTheme(
        color: Colors.blue,
      ),
      scaffoldBackgroundColor: const Color.fromARGB(255, 66, 179, 240),
      colorSchemeSeed: Colors.blue,
      brightness: Brightness.dark,
      inputDecorationTheme: const InputDecorationTheme(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 3, color: Colors.white),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 3, color: Colors.blue),
        ),
      ),
    );
  }
}
