import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Buy_GPS extends StatefulWidget {
  const Buy_GPS({super.key});

  @override
  State<Buy_GPS> createState() => _Buy_GPSState();
}

class _Buy_GPSState extends State<Buy_GPS> {
  int _counter = 0;
  int _counter1 = 0;
  int _counter2 = 0;
  int _counter3 = 0;

  void _incrementCounter() {
    setState(() {
      if (_counter >= 0) {
        _counter++;
      } else {
        return;
      }
    });
  }

  void _decrement() {
    setState(() {
      if (_counter <= 0) {
        return;
      } else {
        _counter--;
      }
    });
  }

  void _incrementCounter1() {
    setState(() {
      if (_counter1 >= 0) {
        _counter1++;
      } else {
        return;
      }
    });
  }

  void _decrement1() {
    setState(() {
      if (_counter1 <= 0) {
        return;
      } else {
        _counter1--;
      }
    });
  }

  void _incrementCounter2() {
    setState(() {
      _counter2++;
    });
  }

  void _decrement2() {
    setState(() {
      if (_counter2 <= 0) {
        return;
      } else {
        _counter2--;
      }
    });
  }

  void _incrementCounter3() {
    setState(() {
      _counter3++;
    });
  }

  void _decrement3() {
    setState(() {
      if (_counter3 <= 0) {
        return;
      } else {
        _counter3--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var sizeh = MediaQuery.of(context).size.height;
    var sizew = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            )),
        backgroundColor: Colors.white,
        title: const Text(
          "Globe GPS",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: sizew * 0.06),
              child: Row(children: [
                Text(
                  "${'BuyGPS'.tr()} ",
                  style: const TextStyle(color: Colors.green, fontSize: 22),
                ),
              ]),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                children: const [
                  Text(
                    "Provide alternative phone number",
                    style: TextStyle(
                        color: Color.fromARGB(255, 5, 53, 116),
                        fontWeight: FontWeight.bold,
                        fontSize: 17),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: sizew * 0.05),
              child: TextFormField(
                // controller: Namecontroller,
                decoration: InputDecoration(
                  labelText: 'Phone Number',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(
                      color: Colors.grey,
                    ),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please Enter the field';
                  }
                  return null;
                },
              ),
            ),
            SizedBox(
              height: sizeh * 0.01,
            ),
            Text(
              "selecttobuy".tr(),
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                  color: Color.fromARGB(255, 2, 39, 70)),
            ),
            SizedBox(
              height: sizeh * 0.01,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: sizew * 0.1, vertical: sizeh * 0.01),
              child: Row(
                children: const [
                  Text(
                    "RV 09",
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
            Cuserbul(randomimglist: const [
              "images/RV09d.webp",
              "images/mt200.jpg",
              "images/mt200.jpg",
              "images/mt200.jpg",
              "images/mt200.jpg",
              "images/mt200.jpg",
              "images/mt200.jpg"
            ]),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: sizew * 0.1, vertical: sizeh * 0.01),
              child: Row(
                children: const [
                  Text(
                    "Price : 1800",
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    style: ButtonStyle(
                      overlayColor: MaterialStateProperty.all(
                          const Color.fromARGB(255, 230, 121, 93)),
                      backgroundColor: MaterialStateProperty.all(
                          const Color.fromARGB(255, 221, 238, 221)),
                      padding: MaterialStateProperty.all(EdgeInsets.symmetric(
                          horizontal: sizew * 0.13, vertical: sizeh * 0.01)),
                      textStyle: MaterialStateProperty.all(const TextStyle(
                          fontSize: 30, fontWeight: FontWeight.bold)),
                    ),
                    onPressed: _decrement,
                    child: const Icon(
                      Icons.remove,
                      color: Colors.black,
                    )),
                SizedBox(
                  width: sizew * 0.03,
                ),
                Container(
                  color: const Color.fromARGB(255, 215, 238, 184),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 11),
                  child: Text(
                    "$_counter",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  width: sizew * 0.03,
                ),
                ElevatedButton(
                    style: ButtonStyle(
                      overlayColor: MaterialStateProperty.all(
                          const Color.fromARGB(255, 10, 156, 83)),
                      backgroundColor: MaterialStateProperty.all(
                          const Color.fromARGB(255, 186, 233, 198)),
                      padding: MaterialStateProperty.all(EdgeInsets.symmetric(
                          horizontal: sizew * 0.13, vertical: sizeh * 0.01)),
                      textStyle: MaterialStateProperty.all(const TextStyle(
                          fontSize: 30, fontWeight: FontWeight.bold)),
                    ),
                    onPressed: _incrementCounter,
                    child: const Icon(Icons.add, color: Colors.black))
              ],
            ),
            SizedBox(
              height: sizeh * 0.03,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: sizew * 0.1, vertical: sizeh * 0.01),
              child: Row(
                children: const [
                  Text(
                    "We Track 140 RTO",
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
            Cuserbul(randomimglist: const [
              "images/we.webp",
              "images/RV09d.webp",
              "images/mt200.jpg",
              "images/mt200.jpg",
              "images/mt200.jpg",
              "images/mt200.jpg",
              "images/mt200.jpg",
              "images/mt200.jpg"
            ]),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: sizew * 0.1, vertical: sizeh * 0.01),
              child: Row(
                children: const [
                  Text(
                    "Price : 1900",
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    style: ButtonStyle(
                      overlayColor: MaterialStateProperty.all(
                          const Color.fromARGB(255, 230, 121, 93)),
                      backgroundColor: MaterialStateProperty.all(
                          const Color.fromARGB(255, 221, 238, 221)),
                      padding: MaterialStateProperty.all(
                          const EdgeInsets.symmetric(
                              horizontal: 50, vertical: 6)),
                      textStyle: MaterialStateProperty.all(const TextStyle(
                          fontSize: 30, fontWeight: FontWeight.bold)),
                    ),
                    onPressed: _decrement1,
                    child: const Icon(
                      Icons.remove,
                      color: Colors.black,
                    )),
                const SizedBox(
                  width: 11,
                ),
                Container(
                  color: const Color.fromARGB(255, 215, 238, 184),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 11),
                  child: Text(
                    "$_counter1",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  width: 11,
                ),
                ElevatedButton(
                    style: ButtonStyle(
                      overlayColor: MaterialStateProperty.all(
                          const Color.fromARGB(255, 10, 156, 83)),
                      backgroundColor: MaterialStateProperty.all(
                          const Color.fromARGB(255, 186, 233, 198)),
                      padding: MaterialStateProperty.all(
                          const EdgeInsets.symmetric(
                              horizontal: 50, vertical: 6)),
                      textStyle: MaterialStateProperty.all(const TextStyle(
                          fontSize: 30, fontWeight: FontWeight.bold)),
                    ),
                    onPressed: _incrementCounter1,
                    child: const Icon(Icons.add, color: Colors.black))
              ],
            ),
            SizedBox(
              height: sizeh * 0.03,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: sizew * 0.1, vertical: sizeh * 0.01),
              child: Row(
                children: const [
                  Text(
                    "ID card Device",
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
            Cuserbul(randomimglist: const [
              'images/id.webp',
              "images/we.webp",
              "images/RV09d.webp",
              "images/mt200.jpg",
              "images/mt200.jpg",
              "images/mt200.jpg",
              "images/mt200.jpg",
              "images/mt200.jpg",
              "images/mt200.jpg"
            ]),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: sizew * 0.1, vertical: sizeh * 0.01),
              child: Row(
                children: const [
                  Text(
                    "Price : 2200",
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    style: ButtonStyle(
                      overlayColor: MaterialStateProperty.all(
                          const Color.fromARGB(255, 230, 121, 93)),
                      backgroundColor: MaterialStateProperty.all(
                          const Color.fromARGB(255, 221, 238, 221)),
                      padding: MaterialStateProperty.all(EdgeInsets.symmetric(
                          horizontal: sizew * 0.13, vertical: sizeh * 0.01)),
                      textStyle: MaterialStateProperty.all(const TextStyle(
                          fontSize: 30, fontWeight: FontWeight.bold)),
                    ),
                    onPressed: _decrement2,
                    child: const Icon(
                      Icons.remove,
                      color: Colors.black,
                    )),
                SizedBox(
                  width: sizew * 0.03,
                ),
                Container(
                  color: const Color.fromARGB(255, 215, 238, 184),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 11),
                  child: Text(
                    "$_counter2",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  width: sizew * 0.03,
                ),
                ElevatedButton(
                    style: ButtonStyle(
                      overlayColor: MaterialStateProperty.all(
                          const Color.fromARGB(255, 10, 156, 83)),
                      backgroundColor: MaterialStateProperty.all(
                          const Color.fromARGB(255, 186, 233, 198)),
                      padding: MaterialStateProperty.all(EdgeInsets.symmetric(
                          horizontal: sizew * 0.13, vertical: sizeh * 0.01)),
                      textStyle: MaterialStateProperty.all(const TextStyle(
                          fontSize: 30, fontWeight: FontWeight.bold)),
                    ),
                    onPressed: _incrementCounter2,
                    child: const Icon(Icons.add, color: Colors.black))
              ],
            ),
            SizedBox(
              height: sizeh * 0.03,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: sizew * 0.1, vertical: sizeh * 0.01),
              child: Row(
                children: const [
                  Text(
                    "MT 200",
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
            Cuserbul(randomimglist: const [
              "images/mt200.jpg",
              'images/id.webp',
              "images/we.webp",
              "images/RV09d.webp",
              "images/mt200.jpg",
              "images/mt200.jpg",
              "images/mt200.jpg",
              "images/mt200.jpg",
              "images/mt200.jpg",
              "images/mt200.jpg"
            ]),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: sizew * 0.1, vertical: sizeh * 0.01),
              child: Row(
                children: const [
                  Text(
                    "price : 2000",
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    style: ButtonStyle(
                      overlayColor: MaterialStateProperty.all(
                          const Color.fromARGB(255, 230, 121, 93)),
                      backgroundColor: MaterialStateProperty.all(
                          const Color.fromARGB(255, 221, 238, 221)),
                      padding: MaterialStateProperty.all(
                          const EdgeInsets.symmetric(
                              horizontal: 50, vertical: 6)),
                      textStyle: MaterialStateProperty.all(const TextStyle(
                          fontSize: 30, fontWeight: FontWeight.bold)),
                    ),
                    onPressed: _decrement3,
                    child: const Icon(
                      Icons.remove,
                      color: Colors.black,
                    )),
                const SizedBox(
                  width: 11,
                ),
                Container(
                  color: const Color.fromARGB(255, 215, 238, 184),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 11),
                  child: Text(
                    "$_counter3",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  width: 11,
                ),
                ElevatedButton(
                    style: ButtonStyle(
                      overlayColor: MaterialStateProperty.all(
                          const Color.fromARGB(255, 10, 156, 83)),
                      backgroundColor: MaterialStateProperty.all(
                          const Color.fromARGB(255, 186, 233, 198)),
                      padding: MaterialStateProperty.all(
                          const EdgeInsets.symmetric(
                              horizontal: 50, vertical: 6)),
                      textStyle: MaterialStateProperty.all(const TextStyle(
                          fontSize: 30, fontWeight: FontWeight.bold)),
                    ),
                    onPressed: _incrementCounter3,
                    child: const Icon(Icons.add, color: Colors.black))
              ],
            ),
            SizedBox(
              height: sizeh * 0.03,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: sizew * 0.1, vertical: sizeh * 0.01),
              child: Row(
                children: const [
                  Text(
                    "MT 200",
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
            Cuserbul(randomimglist: const [
              "images/mt200.jpg",
              'images/id.webp',
              "images/we.webp",
              "images/RV09d.webp",
              "images/mt200.jpg",
              "images/mt200.jpg",
              "images/mt200.jpg",
              "images/mt200.jpg",
              "images/mt200.jpg",
              "images/mt200.jpg"
            ]),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: sizew * 0.1, vertical: sizeh * 0.01),
              child: Row(
                children: const [
                  Text(
                    "price : 2000",
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    style: ButtonStyle(
                      overlayColor: MaterialStateProperty.all(
                          const Color.fromARGB(255, 230, 121, 93)),
                      backgroundColor: MaterialStateProperty.all(
                          const Color.fromARGB(255, 221, 238, 221)),
                      padding: MaterialStateProperty.all(
                          const EdgeInsets.symmetric(
                              horizontal: 50, vertical: 6)),
                      textStyle: MaterialStateProperty.all(const TextStyle(
                          fontSize: 30, fontWeight: FontWeight.bold)),
                    ),
                    onPressed: _decrement3,
                    child: const Icon(
                      Icons.remove,
                      color: Colors.black,
                    )),
                const SizedBox(
                  width: 11,
                ),
                Container(
                  color: const Color.fromARGB(255, 215, 238, 184),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 11),
                  child: Text(
                    "$_counter3",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  width: 11,
                ),
                ElevatedButton(
                    style: ButtonStyle(
                      overlayColor: MaterialStateProperty.all(
                          const Color.fromARGB(255, 10, 156, 83)),
                      backgroundColor: MaterialStateProperty.all(
                          const Color.fromARGB(255, 186, 233, 198)),
                      padding: MaterialStateProperty.all(
                          const EdgeInsets.symmetric(
                              horizontal: 50, vertical: 6)),
                      textStyle: MaterialStateProperty.all(const TextStyle(
                          fontSize: 30, fontWeight: FontWeight.bold)),
                    ),
                    onPressed: _incrementCounter3,
                    child: const Icon(Icons.add, color: Colors.black))
              ],
            ),
            SizedBox(
              height: sizeh * 0.03,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: sizew * 0.1, vertical: sizeh * 0.01),
              child: Row(
                children: const [
                  Text(
                    "MT 200",
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
            Cuserbul(randomimglist: const [
              "images/mt200.jpg",
              'images/id.webp',
              "images/we.webp",
              "images/RV09d.webp",
              "images/mt200.jpg",
              "images/mt200.jpg",
              "images/mt200.jpg",
              "images/mt200.jpg",
              "images/mt200.jpg",
              "images/mt200.jpg"
            ]),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: sizew * 0.1, vertical: sizeh * 0.01),
              child: Row(
                children: const [
                  Text(
                    "price : 2000",
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    style: ButtonStyle(
                      overlayColor: MaterialStateProperty.all(
                          const Color.fromARGB(255, 230, 121, 93)),
                      backgroundColor: MaterialStateProperty.all(
                          const Color.fromARGB(255, 221, 238, 221)),
                      padding: MaterialStateProperty.all(
                          const EdgeInsets.symmetric(
                              horizontal: 50, vertical: 6)),
                      textStyle: MaterialStateProperty.all(const TextStyle(
                          fontSize: 30, fontWeight: FontWeight.bold)),
                    ),
                    onPressed: _decrement3,
                    child: const Icon(
                      Icons.remove,
                      color: Colors.black,
                    )),
                const SizedBox(
                  width: 11,
                ),
                Container(
                  color: const Color.fromARGB(255, 215, 238, 184),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 11),
                  child: Text(
                    "$_counter3",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  width: 11,
                ),
                ElevatedButton(
                    style: ButtonStyle(
                      overlayColor: MaterialStateProperty.all(
                          const Color.fromARGB(255, 10, 156, 83)),
                      backgroundColor: MaterialStateProperty.all(
                          const Color.fromARGB(255, 186, 233, 198)),
                      padding: MaterialStateProperty.all(
                          const EdgeInsets.symmetric(
                              horizontal: 50, vertical: 6)),
                      textStyle: MaterialStateProperty.all(const TextStyle(
                          fontSize: 30, fontWeight: FontWeight.bold)),
                    ),
                    onPressed: _incrementCounter3,
                    child: const Icon(Icons.add, color: Colors.black))
              ],
            ),
            SizedBox(
              height: sizeh * 0.03,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: sizew * 0.1, vertical: sizeh * 0.01),
              child: Row(
                children: const [
                  Text(
                    "MT 200",
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
            Cuserbul(randomimglist: const [
              "images/mt200.jpg",
              'images/id.webp',
              "images/we.webp",
              "images/RV09d.webp",
              "images/mt200.jpg",
              "images/mt200.jpg",
              "images/mt200.jpg",
              "images/mt200.jpg",
              "images/mt200.jpg",
              "images/mt200.jpg"
            ]),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: sizew * 0.1, vertical: sizeh * 0.01),
              child: Row(
                children: const [
                  Text(
                    "price : 2000",
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    style: ButtonStyle(
                      overlayColor: MaterialStateProperty.all(
                          const Color.fromARGB(255, 230, 121, 93)),
                      backgroundColor: MaterialStateProperty.all(
                          const Color.fromARGB(255, 221, 238, 221)),
                      padding: MaterialStateProperty.all(
                          const EdgeInsets.symmetric(
                              horizontal: 50, vertical: 6)),
                      textStyle: MaterialStateProperty.all(const TextStyle(
                          fontSize: 30, fontWeight: FontWeight.bold)),
                    ),
                    onPressed: _decrement3,
                    child: const Icon(
                      Icons.remove,
                      color: Colors.black,
                    )),
                const SizedBox(
                  width: 11,
                ),
                Container(
                  color: const Color.fromARGB(255, 215, 238, 184),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 11),
                  child: Text(
                    "$_counter3",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  width: 11,
                ),
                ElevatedButton(
                    style: ButtonStyle(
                      overlayColor: MaterialStateProperty.all(
                          const Color.fromARGB(255, 10, 156, 83)),
                      backgroundColor: MaterialStateProperty.all(
                          const Color.fromARGB(255, 186, 233, 198)),
                      padding: MaterialStateProperty.all(
                          const EdgeInsets.symmetric(
                              horizontal: 50, vertical: 6)),
                      textStyle: MaterialStateProperty.all(const TextStyle(
                          fontSize: 30, fontWeight: FontWeight.bold)),
                    ),
                    onPressed: _incrementCounter3,
                    child: const Icon(Icons.add, color: Colors.black))
              ],
            ),
            SizedBox(
              height: sizeh * 0.03,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: sizew * 0.1, vertical: sizeh * 0.01),
              child: Row(
                children: const [
                  Text(
                    "MT 200",
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
            Cuserbul(randomimglist: const [
              "images/mt200.jpg",
              'images/id.webp',
              "images/we.webp",
              "images/RV09d.webp",
              "images/mt200.jpg",
              "images/mt200.jpg",
              "images/mt200.jpg",
              "images/mt200.jpg",
              "images/mt200.jpg",
              "images/mt200.jpg"
            ]),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: sizew * 0.1, vertical: sizeh * 0.01),
              child: Row(
                children: const [
                  Text(
                    "price : 2000",
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    style: ButtonStyle(
                      overlayColor: MaterialStateProperty.all(
                          const Color.fromARGB(255, 230, 121, 93)),
                      backgroundColor: MaterialStateProperty.all(
                          const Color.fromARGB(255, 221, 238, 221)),
                      padding: MaterialStateProperty.all(
                          const EdgeInsets.symmetric(
                              horizontal: 50, vertical: 6)),
                      textStyle: MaterialStateProperty.all(const TextStyle(
                          fontSize: 30, fontWeight: FontWeight.bold)),
                    ),
                    onPressed: _decrement3,
                    child: const Icon(
                      Icons.remove,
                      color: Colors.black,
                    )),
                const SizedBox(
                  width: 11,
                ),
                Container(
                  color: const Color.fromARGB(255, 215, 238, 184),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 11),
                  child: Text(
                    "$_counter3",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  width: 11,
                ),
                ElevatedButton(
                    style: ButtonStyle(
                      overlayColor: MaterialStateProperty.all(
                          const Color.fromARGB(255, 10, 156, 83)),
                      backgroundColor: MaterialStateProperty.all(
                          const Color.fromARGB(255, 186, 233, 198)),
                      padding: MaterialStateProperty.all(
                          const EdgeInsets.symmetric(
                              horizontal: 50, vertical: 6)),
                      textStyle: MaterialStateProperty.all(const TextStyle(
                          fontSize: 30, fontWeight: FontWeight.bold)),
                    ),
                    onPressed: _incrementCounter3,
                    child: const Icon(Icons.add, color: Colors.black))
              ],
            ),
            const SizedBox(
              height: 200,
            ),
            const SizedBox(
              height: 100,
            ),
          ],
        ),
      ),
      floatingActionButton: Container(
        height: 60,
        width: 200,
        decoration: const BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: FloatingActionButton(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12))),
          onPressed: () {},
          backgroundColor: const Color.fromARGB(255, 125, 243, 129),
          tooltip: 'Capture Picture',
          elevation: 5,
          splashColor: Colors.grey,
          child: Text(
            "buy".tr(),
            style: const TextStyle(color: Colors.black),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

class Caarousel extends StatelessWidget {
  Caarousel({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      disableGesture: true,
      carouselController: CarouselController(),
      options: CarouselOptions(
          autoPlay: false,
          enableInfiniteScroll: true,
          padEnds: true,
          disableCenter: true,
          animateToClosest: true,
          reverse: true,
          pauseAutoPlayOnManualNavigate: true,
          pauseAutoPlayInFiniteScroll: true,
          pageSnapping: true,
          pauseAutoPlayOnTouch: true,
          aspectRatio: 1.0,
          enlargeCenterPage: true,
          enlargeStrategy: CenterPageEnlargeStrategy.height,
          height: 300),
      items: [1, 2, 3, 4, 5, 6].map((i) {
        return Builder(
          builder: (BuildContext context) {
            return i == 1
                ? Differentclient(
                    Imaheurl: "images/RV09d.webp",
                  )
                : i == 6
                    ? Differentclient(
                        Imaheurl: "images/RV09d.webp",
                      )
                    : i == 2
                        ? Differentclient(
                            Imaheurl: "images/RV09d.webp",
                          )
                        : i == 3
                            ? Differentclient(
                                Imaheurl: "images/RV09d.webp",
                              )
                            : i == 4
                                ? Differentclient(
                                    Imaheurl: "images/RV09d.webp",
                                  )
                                : i == 5
                                    ? Differentclient(
                                        Imaheurl: "images/RV09d.webp",
                                      )
                                    : Container();
          },
        );
      }).toList(),
    );
  }
}

class Differentclient extends StatelessWidget {
  String Imaheurl;
  Differentclient({super.key, required this.Imaheurl});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(horizontal: 1.0),
      // decoration: BoxDecoration(color: Colors.amber),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              Stack(children: [
                // Align(
                //   alignment: AlignmentDirectional.topEnd,
                //   child: Container(
                //     width: 120,
                //     height: 220,
                //   ),
                // ),
                Container(
                  width: 300,
                  height: 200,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white.withOpacity(0.8),
                        offset: const Offset(-6.0, -6.0),
                        blurRadius: 16.0,
                      ),
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        offset: const Offset(6.0, 6.0),
                        blurRadius: 16.0,
                      ),
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(2.0),
                  ),
                  child: Image.asset(Imaheurl),
                ),
              ]),
            ],
          ),
        ],
      ),
    );
  }
}

class Cuserbul extends StatefulWidget {
  List randomimglist;
  Cuserbul({super.key, required this.randomimglist});

  @override
  State<Cuserbul> createState() => _CuserbulState();
}

class _CuserbulState extends State<Cuserbul> {
  int Activeindex = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider.builder(
          // carouselController: controller,
          options: CarouselOptions(
            disableCenter: true,
            enlargeCenterPage: true,
            initialPage: 0,
            pageSnapping: true,
            enlargeStrategy: CenterPageEnlargeStrategy.height,
            // enlargeCenterPage: true,
            height: 260,
            onPageChanged: (index, reason) =>
                setState(() => Activeindex = index),
          ),
          itemCount: widget.randomimglist.length,
          itemBuilder: (context, index, realIndex) {
            final urlimage = widget.randomimglist[index];
            return BuilImages(urlimage, index);
          },
        ),
        const SizedBox(
          height: 12,
        ),
        Buildindicatorctor()
      ],
    );
  }

  Widget BuilImages(String urlimage, int index) => Container(
        margin: const EdgeInsets.all(13),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 255, 255, 255),
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(255, 255, 255, 255).withOpacity(0.4),
              // color: Color.fromARGB(255, 255, 255, 255).withOpacity(0.1),
              offset: const Offset(-6.0, -6.0),
              blurRadius: 16.0,
            ),
            BoxShadow(
              color: const Color.fromARGB(255, 90, 86, 86).withOpacity(0.4),
              // color: Colors.black.withOpacity(0.2),
              offset: const Offset(6.0, 6.0),
              blurRadius: 10.0,
            ),
          ],
        ),
        child: Image.asset(
          urlimage,
          fit: BoxFit.fill,
        ),
      );

  Widget Buildindicatorctor() => AnimatedSmoothIndicator(
      effect: const JumpingDotEffect(dotHeight: 10, dotWidth: 10),
      activeIndex: Activeindex,
      count: widget.randomimglist.length);
}



class Buy_GPS2 extends StatelessWidget {
  String text;
   Buy_GPS2({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(text),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back)),
      ),
      body: const Center(
        child: Text(
          "COMING SOON.....",
          style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold,color: Color.fromARGB(255, 41, 25, 0)),
        ),
      ),
    );
  }
}
