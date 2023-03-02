import 'package:flutter/material.dart';

class CalPage extends StatefulWidget {
  const CalPage({super.key, required this.kgf1, required this.kgf2});
  final double kgf1;
  final double kgf2;

  @override
  State<CalPage> createState() => _CalPageState();
}

class _CalPageState extends State<CalPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: setAppbar('สรุปผลราคาน้ำหนักปลา', true),
      body: setBody(),
    );
  }

  AppBar setAppbar(String title, bool center, [IconData? icon]) {
    return AppBar(
      leading: Padding(
        padding: const EdgeInsets.only(left: 30),
        child: IconButton(
            padding: EdgeInsets.zero,
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios_new)),
      ),
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
    return SingleChildScrollView(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/fish_icon.png',
              height: 200,
              width: 200,
            ),
            fishShow(
                'ปลานิล ราคาที่ได้ (กก.ละ 80)', widget.kgf1, 80, Colors.blue),
            fishShow('ปลาบึก ราคาที่ได้ (กก.ละ 100)', widget.kgf2, 100,
                Colors.lightBlue)
          ],
        ),
      ),
    );
  }

  Padding fishShow(String title, double kg, double bath, Color color) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        color: color,
        child: SizedBox(
          width: 300,
          height: 200,
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                title,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'น้ำหนักปลา : $kg กก.\nราคารวม : ${(kg * bath).toStringAsFixed(2)} บาท',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
