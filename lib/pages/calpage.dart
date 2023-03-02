import 'package:flutter/material.dart';
import 'package:sell_fish/main.dart';

class CalPage extends StatefulWidget {
  const CalPage({super.key, required this.mapPrice, required this.mapMass});
  final Map<String, double> mapPrice;
  final Map<String, double> mapMass;

  @override
  State<CalPage> createState() => _CalPageState();
}

class _CalPageState extends State<CalPage> {
  @override
  Widget build(BuildContext context) {
    List<String> nameFish = widget.mapMass.keys.toList();
    List<double> massFish = widget.mapMass.values.toList();
    List<double> priceFish = widget.mapPrice.values.toList();
    return Scaffold(
      appBar: setAppbar('สรุปผลราคาน้ำหนักปลา', true),
      body: setBody(name: nameFish, mass: massFish, price: priceFish),
      bottomNavigationBar: setBottomNavBar(),
      floatingActionButton: setFloatingButton(),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
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

  Widget setBody(
      {required List name, required List mass, required List price}) {
    for (int index = 0; index < mass.length; index++) {
      if (mass[index] == 0.0) {
        name.removeAt(index);
        mass.removeAt(index);
        price.removeAt(index);
      }
    }
    return ListView.builder(
        itemCount: mass.length,
        itemBuilder: (context, index) {
          print(mass);
          return mass.isEmpty == true ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text('ไม่มีข้อมูลน้ำหนักปลา',
              style: TextStyle(color: Colors.white,fontSize: 30,fontWeight: FontWeight.bold),)
            ],
          ) : fishShow(
              title: name[index], kg: mass[index], bath: price[index]);
        });
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
    return SizedBox(
      width: 200,
      child: FloatingActionButton(
        hoverColor: Colors.blue,
        backgroundColor: Colors.lightBlue,
        onPressed: () {
          setState(() {
            Navigator.pop(context);
          });
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: const FittedBox(
          fit: BoxFit.fitWidth,
          child: Text(
            'Confirm',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
      ),
    );
  }

  Padding fishShow(
      {required String title,
      required double kg,
      required double bath,
      Color color = Colors.blue}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        color: color,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        child: ElevatedButton(
          style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(color)),
          onPressed: () {
            setState(() {
              FishData.selectFish = title;
              Navigator.pop(context);
            });
          },
          child: SizedBox(
            width: 300,
            height: 400,
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                child: Container(
                  width: 300,
                  decoration: BoxDecoration(
                    border: Border.all(width: 8, color: Colors.lightBlue),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FittedBox(
                        fit: BoxFit.fitWidth,
                        child: Image.asset(FishData.imageFish(title))),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  title,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 25),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'น้ำหนักปลา : $kg กก.\nราคารวม : ${(kg * FishData.priceFish(title, newprice: bath)).toStringAsFixed(2)} บาท',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
              const Align(
                alignment: Alignment.bottomRight,
                child: Icon(Icons.edit, color:Colors.white,size: 25,),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
