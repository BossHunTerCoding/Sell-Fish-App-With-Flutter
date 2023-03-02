import 'package:flutter/material.dart';
import 'package:sell_fish/pages/homepage.dart';

main() {
  for (int index = 0; index < FishData.nameFish.length ; index++) {
    FishData.valueFishPrice.addAll({FishData.nameFish[index]:0.0});
    FishData.valueFishMass.addAll({FishData.nameFish[index]:0.0});
  }
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
          borderSide: BorderSide(width: 3, color: Colors.blue),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 3, color: Colors.white),
        ),
      ),
    );
  }
}

class FishData {
  static List<String> nameFish = ['ปลานิล', 'ปลาบึก'];
  static Map<String, double> valueFishPrice = {};
  static Map<String, double> valueFishMass = {};
  static String? selectFish;

  static double calFishPriceKG({required double mass, required double bath}) {
    return mass * bath;
  }

  static String imageFish(var fish) {
    String pathImage = '';
    switch (fish) {
      case 'ปลานิล':
        {
          pathImage = 'assets/tilapia.jpg';
          break;
        }
      case 'ปลาบึก':
        {
          pathImage = 'assets/giant_catfish.jpg';
          break;
        }
      default:
        {
          pathImage = 'assets/fish_icon.png';
          break;
        }
    }
    return pathImage;
  }

  static double priceFish(var fish) {
    double price = 0;
    switch (fish) {
      case 'ปลานิล':
        {
          price = 80;
          break;
        }
      case 'ปลาบึก':
        {
          price = 100;
          break;
        }
      default:
        {
          price = 0;
          break;
        }
    }
    return price;
  }
}
