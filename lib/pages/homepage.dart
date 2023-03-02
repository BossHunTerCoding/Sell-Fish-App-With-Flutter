import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sell_fish/main.dart';
import 'package:sell_fish/pages/calpage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController inputPrice = TextEditingController();
  TextEditingController inputMass = TextEditingController();

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
      actions: [
        FloatingActionButton.small(
          backgroundColor: Colors.white,
          onPressed: () {
            showDialog(
                context: context,
                builder: (builderUI) {
                  return const CupertinoAlertDialog(
                    title: Text('คู่มือการคำนวน'),
                    content: Text(
                        '1 กิโลกรัม เท่ากับ 10 ขีด\n1 ขีด เท่ากับ 100 กรัม\n1 กิโลกรัม เท่ากับ 1,000 กรัม\n1 เมตริกตัน เท่ากับ 1,000 กิโลกรัม'),
                  );
                });
          },
          child: const Icon(
            Icons.question_mark_outlined,
            color: Colors.blue,
          ),
        )
      ],
    );
  }

  Widget setBody() {
    var fishField = Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Column(
        children: [
          listSelectFish(),
          fishfield(
              title:
                  'ราคา ${FishData.selectFish ?? ''} ${FishData.selectFish == null ? '' : '(เดิมราคา ${FishData.priceFish(FishData.selectFish)})'}',
              hinttextfield: FishData.valueFishPrice[FishData.selectFish] ==
                      null
                  ? ''
                  : '${FishData.valueFishPrice[FishData.selectFish] == 0.0 ? 'กรุณากรอกราคาที่ต้องการเปลี่ยน' : FishData.valueFishPrice[FishData.selectFish]}',
              unit: 'บาท',
              textinput: inputPrice),
          fishfield(
              title: 'น้ำหนัก ${FishData.selectFish ?? ''}',
              hinttextfield: FishData.valueFishMass[FishData.selectFish] == null
                  ? ''
                  : '${FishData.valueFishMass[FishData.selectFish] == 0.0 ? 'กรุณากรอกน้ำหนัก (กิโลกรัม)' : FishData.valueFishMass[FishData.selectFish]}',
              unit: 'กก.',
              textinput: inputMass),
        ],
      ),
    );

    return SingleChildScrollView(
      child: Center(
        child: Column(
          children: [logoBanner(FishData.selectFish), fishField],
        ),
      ),
    );
  }

  Widget logoBanner(String? nameImage) {
    double checkWidth = nameImage == null ? 200 : 300;
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Image.asset(
        FishData.imageFish(nameImage),
        height: 200,
        width: checkWidth,
        fit: BoxFit.fill,
      ),
    );
  }

  Card listSelectFish() {
    return Card(
      color: Colors.blue,
      child: SizedBox(
        width: 280,
        child: DropdownButton(
            hint: const Center(
              child: Padding(
                padding: EdgeInsets.only(left: 30.0),
                child: Text(
                  'กรุณาเลือกชนิดปลา',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            itemHeight: 60,
            isExpanded: true,
            icon: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                'assets/fish_icon.png',
                width: 30,
                height: 30,
              ),
            ),
            underline: const Text(''),
            borderRadius: const BorderRadius.all(Radius.circular(22)),
            alignment: AlignmentDirectional.center,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
            dropdownColor: Colors.blue,
            value: FishData.selectFish,
            items: FishData.nameFish
                .map((value) => DropdownMenuItem(
                      value: value,
                      child: Center(
                          child: Text(
                        value,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      )),
                    ))
                .toList(),
            onChanged: (newValue) {
              setState(() {
                inputPrice.clear();
                inputMass.clear();
                FishData.selectFish = newValue;
              });
            }),
      ),
    );
  }

  Padding fishfield(
      {String title = 'ปลา ...',
      String hinttextfield = '',
      TextEditingController? textinput,
      String unit = 'หน่วย'}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 18.0),
                child: Card(
                  color: Colors.blue,
                  child: SizedBox(
                    width: 280,
                    child: TextField(
                      controller: textinput,
                      decoration: InputDecoration(
                        enabled: FishData.selectFish == null ? false : true,
                        hintText: hinttextfield,
                        hintStyle: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      textAlign: TextAlign.center,
                      onChanged: (value) {
                        setState(() {
                          try {
                            FishData.valueFishPrice[FishData.selectFish!] =
                                double.parse(inputPrice.text);
                            FishData.valueFishMass[FishData.selectFish!] =
                                double.parse(inputMass.text);
                            // ignore: empty_catches
                          } catch (e) {}
                        });
                      },
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  unit,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
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
          Iterable<double> value = FishData.valueFishPrice.values;
          print(value);
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
}
