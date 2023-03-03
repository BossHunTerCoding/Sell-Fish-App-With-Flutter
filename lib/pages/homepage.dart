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
        Padding(
          padding: const EdgeInsets.only(right: 4.0, top: 8, bottom: 8),
          child: ElevatedButton(
            style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Colors.white),
                shape: MaterialStatePropertyAll(CircleBorder())),
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
          ),
        )
      ],
    );
  }

  Widget setBody(BuildContext context) {
    var fishField = Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Column(
        children: [
          listSelectFish(),
          textField(
            context,
            getinput: FishData.inputPrice,
            texttitle:
                'ราคา ${FishData.selectFish ?? ''} ${FishData.selectFish == null ? '' : '(เดิมราคา ${FishData.priceFish(FishData.selectFish)} บาท )'}',
            textsubtitle: FishData.selectFish == null
                ? ''
                : FishData.valueFishPrice[FishData.selectFish] == '0.0'
                    ? 'กรุณากรอกราคาที่ต้องการเปลี่ยน'
                    : 'กรุณากรอกราคาที่ต้องการเปลี่ยน',
            unit: 'บาท',
            method: (velue) {
              setState(() {
                FishData.valueFishPrice
                    .addAll({FishData.selectFish: FishData.inputPrice.text});
              });
            },
          ),
          textField(
            context,
            getinput: FishData.inputMass,
            texttitle: 'น้ำหนัก ${FishData.selectFish ?? ''}',
            textsubtitle: FishData.valueFishMass[FishData.selectFish] == null
                ? ''
                : FishData.valueFishMass[FishData.selectFish] == '0.0'
                    ? 'กรุณากรอกน้ำหนัก (กิโลกรัม)'
                    : 'กรุณากรอกน้ำหนัก (กิโลกรัม)',
            unit: 'กก.',
            method: (value) {
              setState(() {
                FishData.valueFishMass
                    .addAll({FishData.selectFish: FishData.inputMass.text});
              });
            },
          ),
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
                FishData.valuecurrentPrice.addAll(FishData.valueFishPrice);
                FishData.valuecurrentMass.addAll(FishData.valueFishMass);
                FishData.selectFish = newValue;
                FishData.inputPrice.text =
                    FishData.valuecurrentPrice[FishData.selectFish].toString();
                FishData.inputMass.text =
                    FishData.valuecurrentMass[FishData.selectFish].toString();
                if (FishData.inputPrice.text == '0.0' ||
                    FishData.inputPrice.text == '' ||
                    FishData.inputPrice.text == '0') {
                  FishData.inputPrice.clear();
                }
                if (FishData.inputMass.text == '0.0' ||
                    FishData.inputMass.text == '' ||
                    FishData.inputMass.text == '0') {
                  FishData.inputMass.clear();
                }
              });
            }),
      ),
    );
  }

  Padding textField(
    BuildContext context, {
    required getinput,
    required String texttitle,
    String? textsubtitle,
    required String unit,
    required void Function(String?) method,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              texttitle,
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
                      keyboardType: const TextInputType.numberWithOptions(
                          signed: true, decimal: true),
                      onChanged: method,
                      controller: getinput,
                      decoration: InputDecoration(
                        enabled: FishData.selectFish == null ? false : true,
                        hintText: textsubtitle,
                        hintStyle: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      textAlign: TextAlign.center,
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
          if (FishData.selectFish != null) {
            Map<String, double> checkm = FishData.valueFishMass.map(
                (key, value) => MapEntry(
                    key!,
                    FishData.inputMass.text == ''
                        ? 0.0
                        : double.parse(value!)));
            Map<String, double> checkp = FishData.valueFishPrice.map(
                (key, value) => MapEntry(
                    key!,
                    FishData.inputPrice.text == ''
                        ? 0.0
                        : double.parse(value!)));
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => CalPage(
                        mapPrice: checkp,
                        mapMass: checkm,
                      )),
            ).then((value) {
              setState(() {});
            });
          } else {
            showDialog(
                context: context,
                builder: (builderUI) {
                  return const AlertDialog(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    elevation: 1,
                    content: SizedBox(
                        height: 100,
                        width: 250,
                        child: Center(child: Text('กรุณาเลือกชนิดปลา'))),
                  );
                });
          }
        } catch (e) {
          showDialog(
              context: context,
              builder: (builderUI) {
                return const AlertDialog(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  elevation: 1,
                  content: SizedBox(
                      height: 100,
                      width: 250,
                      child: Center(
                          child: Text('กรุณากรอกข้อมูลตัวเลขให้ถูกต้อง'))),
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
      body: setBody(context),
      bottomNavigationBar: setBottomNavBar(),
      floatingActionButton: setFloatingButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
