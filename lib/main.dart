import 'package:flutter/material.dart';
import 'package:sell_fish/pages/homepage.dart';

main() {
  addFishStart(listFish: FishData.nameFish);
  runApp(const Myapp());
}

void addFishStart({required List listFish, String values = '0.0'}) {
  for (int index = 0; index < FishData.nameFish.length; index++) {
    FishData.valueFishPrice.addAll({listFish[index]: values});
    FishData.valueFishMass.addAll({listFish[index]: values});
    FishData.valuecurrentPrice.addAll({listFish[index]: values});
    FishData.valuecurrentMass.addAll({listFish[index]: values});
  }
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
  static var groupFish = [];
  static List<String> nameFish = ['ปลานิล', 'ปลาบึก'];
  static Map<String?, String?> valueFishPrice = {};
  static Map<String?, String?> valueFishMass = {};
  static Map<String?, String?> valuecurrentPrice = {};
  static Map<String?, String?> valuecurrentMass = {};
  static String? selectFish;
  static TextEditingController inputPrice = TextEditingController();
  static TextEditingController inputMass = TextEditingController();

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

  static double priceFish(var fish, {double newprice = 0.0}) {
    double price = 0;
    switch (fish) {
      case 'ปลานิล':
        {
          price = newprice == 0.0 ? 80 : newprice;
          break;
        }
      case 'ปลาบึก':
        {
          price = newprice == 0.0 ? 100 : newprice;
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
