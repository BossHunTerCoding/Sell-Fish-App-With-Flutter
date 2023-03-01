import 'package:flutter/material.dart';
import 'package:sell_fish/pages/calpage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController kgFishN = TextEditingController();
  TextEditingController kgFishB = TextEditingController();

  double namekgN = 0.0;
  double namekgB = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: setAppbar('Sell Fish', false, Icons.fitbit_sharp),
      body: setBody(),
      bottomNavigationBar: setBottomNavBar(),
      floatingActionButton: setFloatingButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  AppBar setAppbar(String title, bool center, [IconData? icon]) {
    return AppBar(
      centerTitle: center,
      title: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Icon(icon),
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  Widget setBody() {
    var logoBanner = Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Image.asset(
        'assets/fish.png',
        height: 200,
        width: 200,
      ),
    );

    var fishField = Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Column(
        children: [
          fishfield('ปลานิล กิโลกรัมละ 80 บาท', kgFishN),
          fishfield('ปลาบึก กิโลกรัมละ 100 บาท', kgFishB),
        ],
      ),
    );

    return SingleChildScrollView(
      child: Center(
        child: Column(
          children: [logoBanner, fishField],
        ),
      ),
    );
  }

  Padding fishfield(String title, TextEditingController kg) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(title,style: const TextStyle(fontWeight: FontWeight.bold)),
          ),
          TextField(
            controller: kg,
            decoration: const InputDecoration(
              hintText: 'กรุณากรอกหน่วย กิโลกรัม (กก.)',
              hintStyle: TextStyle(fontWeight: FontWeight.bold),
            ),
            textAlign: TextAlign.center,
          ),
        ]),
      ),
    );
  }

  Widget setBottomNavBar() {
    return BottomAppBar(
      color: Colors.blue,
      child: Container(
        height: 75,
      ),
    );
  }

  Widget setFloatingButton() {
    return FloatingActionButton(
      backgroundColor: Colors.white,
      child: const Icon(
        Icons.add,
        color: Colors.blue,
      ),
      onPressed: () {
        try {
          kgFishN.text == ''
              ? namekgN = 0.0
              : namekgN = double.parse(kgFishN.text);
          kgFishB.text == ''
              ? namekgB = 0.0
              : namekgB = double.parse(kgFishB.text);
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CalPage(
                      kgf1: namekgN,
                      kgf2: namekgB,
                    )),
          );
        } catch (e) {
          showDialog(
              context: context,
              builder: (builderUI) {
                return const AlertDialog(
                  elevation: 1,
                  content: Text('กรุณากรอกน้ำหนัก (กก.) ให้ถูกต้อง'),
                );
              });
        }
      },
    );
  }
}
