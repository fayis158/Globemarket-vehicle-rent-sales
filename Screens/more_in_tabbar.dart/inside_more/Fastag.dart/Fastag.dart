import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gpsglobe/Constant.dart';


class Fastag extends StatefulWidget {
  const Fastag({super.key});

  @override
  State<Fastag> createState() => _FastagState();
}

class _FastagState extends State<Fastag> {
  int _counter = 0;
  int _counter1 = 0;
  int _counter2 = 0;
  int _counter3 = 0;
  int _counter4 = 0;

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
      if (_counter >= 0) {
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
      if (_counter2 >= 0) {
        _counter2++;
      } else {
        return;
      }
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
      if (_counter3 >= 0) {
        _counter3++;
      } else {
        return;
      }
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

  void _incrementCounter4() {
    setState(() {
      if (_counter4 >= 0) {
        _counter4++;
      } else {
        return;
      }
    });
  }

  void _decrement4() {
    setState(() {
      if (_counter4 <= 0) {
        return;
      } else {
        _counter4--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text("fastag".tr()),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 22,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text('Fastag No : 4'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text('Details         '),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text('Price : 1000'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          height: height(context) * 0.25,
                          width: width(context) * 0.6,
                          child: Image.asset(
                            "images/fastag.jpg",
                            fit: BoxFit.fill,
                          ),
                        ),
                        Positioned(
                            left: 20,
                            top: height(context) * 0.15,
                            child: const Text(
                              "4",
                              style: TextStyle(
                                fontSize: 55,
                                fontWeight: FontWeight.bold,
                                 color: Colors.blue,
                              ),
                            ))
                      ],
                    ),
                    Container(
                      width: width(context) * 0.6,
                      height: 22,
                      color: Colors.blue,
                      child: const Center(
                        child: Text(
                          "4",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 17,
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
                          horizontal: width(context) * 0.13,
                          vertical: height(context) * 0.01)),
                      textStyle: MaterialStateProperty.all(const TextStyle(
                          fontSize: 30, fontWeight: FontWeight.bold)),
                    ),
                    onPressed: _decrement,
                    child: const Icon(
                      Icons.remove,
                      color: Colors.black,
                    )),
                SizedBox(
                  width: width(context) * 0.03,
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
                  width: width(context) * 0.03,
                ),
                ElevatedButton(
                    style: ButtonStyle(
                      overlayColor: MaterialStateProperty.all(
                          const Color.fromARGB(255, 10, 156, 83)),
                      backgroundColor: MaterialStateProperty.all(
                          const Color.fromARGB(255, 186, 233, 198)),
                      padding: MaterialStateProperty.all(EdgeInsets.symmetric(
                          horizontal: width(context) * 0.13,
                          vertical: height(context) * 0.01)),
                      textStyle: MaterialStateProperty.all(const TextStyle(
                          fontSize: 30, fontWeight: FontWeight.bold)),
                    ),
                    onPressed: _incrementCounter,
                    child: const Icon(Icons.add, color: Colors.black))
              ],
            ),
            const SizedBox(
              height: 22,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text('Details'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          height: height(context) * 0.25,
                          width: width(context) * 0.6,
                          child: Image.asset(
                            "images/fastag.jpg",
                            fit: BoxFit.fill,
                          ),
                        ),
                        Positioned(
                            left: 20,
                            top: height(context) * 0.15,
                            child: const Text(
                              "5",
                              style: TextStyle(
                                fontSize: 55,
                                fontWeight: FontWeight.bold,
                                 color: Color.fromARGB(255, 194, 134, 4),
                              ),
                            )),
                      ],
                    ),
                    Container(
                      width: width(context) * 0.6,
                      height: 22,
                      color: const Color.fromARGB(255, 194, 134, 4),
                      child: const Center(
                        child: Text(
                          "5",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 17,
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
                          horizontal: width(context) * 0.13,
                          vertical: height(context) * 0.01)),
                      textStyle: MaterialStateProperty.all(const TextStyle(
                          fontSize: 30, fontWeight: FontWeight.bold)),
                    ),
                    onPressed: _decrement1,
                    child: const Icon(
                      Icons.remove,
                      color: Colors.black,
                    )),
                SizedBox(
                  width: width(context) * 0.03,
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
                SizedBox(
                  width: width(context) * 0.03,
                ),
                ElevatedButton(
                    style: ButtonStyle(
                      overlayColor: MaterialStateProperty.all(
                          const Color.fromARGB(255, 10, 156, 83)),
                      backgroundColor: MaterialStateProperty.all(
                          const Color.fromARGB(255, 186, 233, 198)),
                      padding: MaterialStateProperty.all(EdgeInsets.symmetric(
                          horizontal: width(context) * 0.13,
                          vertical: height(context) * 0.01)),
                      textStyle: MaterialStateProperty.all(const TextStyle(
                          fontSize: 30, fontWeight: FontWeight.bold)),
                    ),
                    onPressed: _incrementCounter1,
                    child: const Icon(Icons.add, color: Colors.black))
              ],
            ),
            const SizedBox(
              height: 22,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text('Details'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          height: height(context) * 0.25,
                          width: width(context) * 0.6,
                          child: Image.asset(
                            "images/fastag.jpg",
                            fit: BoxFit.fill,
                          ),
                        ),
                        Positioned(
                            left: 20,
                            top: height(context) * 0.15,
                            child: const Text(
                              "6",
                              style: TextStyle(
                                fontSize: 55,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 231, 212, 39),
                              ),
                            ))
                      ],
                    ),
                    Container(
                      width: width(context) * 0.6,
                      height: 22,
                      color: const Color.fromARGB(255, 231, 212, 39),
                      child: const Center(
                        child: Text(
                          "6",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 17,
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
                          horizontal: width(context) * 0.13,
                          vertical: height(context) * 0.01)),
                      textStyle: MaterialStateProperty.all(const TextStyle(
                          fontSize: 30, fontWeight: FontWeight.bold)),
                    ),
                    onPressed: _decrement2,
                    child: const Icon(
                      Icons.remove,
                      color: Colors.black,
                    )),
                SizedBox(
                  width: width(context) * 0.03,
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
                  width: width(context) * 0.03,
                ),
                ElevatedButton(
                    style: ButtonStyle(
                      overlayColor: MaterialStateProperty.all(
                          const Color.fromARGB(255, 10, 156, 83)),
                      backgroundColor: MaterialStateProperty.all(
                          const Color.fromARGB(255, 186, 233, 198)),
                      padding: MaterialStateProperty.all(EdgeInsets.symmetric(
                          horizontal: width(context) * 0.13,
                          vertical: height(context) * 0.01)),
                      textStyle: MaterialStateProperty.all(const TextStyle(
                          fontSize: 30, fontWeight: FontWeight.bold)),
                    ),
                    onPressed: _incrementCounter2,
                    child: const Icon(Icons.add, color: Colors.black))
              ],
            ),
            const SizedBox(
              height: 22,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text('Details'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          height: height(context) * 0.25,
                          width: width(context) * 0.6,
                          child: Image.asset(
                            "images/fastag.jpg",
                            fit: BoxFit.fill,
                          ),
                        ),
                         Positioned(
                          left: 20,
                          top:height(context) * 0.15 ,
                          child: const Text("7",style: TextStyle(fontSize: 55,fontWeight: FontWeight.bold, color: Color.fromARGB(255, 11, 150, 11),),))
                      ],
                    ),
                    Container(
                      width: width(context) * 0.6,
                      height: 22,
                      color: const Color.fromARGB(255, 11, 150, 11),
                      child: const Center(
                        child: Text(
                          "7",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 17,
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
                          horizontal: width(context) * 0.13,
                          vertical: height(context) * 0.01)),
                      textStyle: MaterialStateProperty.all(const TextStyle(
                          fontSize: 30, fontWeight: FontWeight.bold)),
                    ),
                    onPressed: _decrement3,
                    child: const Icon(
                      Icons.remove,
                      color: Colors.black,
                    )),
                SizedBox(
                  width: width(context) * 0.03,
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
                SizedBox(
                  width: width(context) * 0.03,
                ),
                ElevatedButton(
                    style: ButtonStyle(
                      overlayColor: MaterialStateProperty.all(
                          const Color.fromARGB(255, 10, 156, 83)),
                      backgroundColor: MaterialStateProperty.all(
                          const Color.fromARGB(255, 186, 233, 198)),
                      padding: MaterialStateProperty.all(EdgeInsets.symmetric(
                          horizontal: width(context) * 0.13,
                          vertical: height(context) * 0.01)),
                      textStyle: MaterialStateProperty.all(const TextStyle(
                          fontSize: 30, fontWeight: FontWeight.bold)),
                    ),
                    onPressed: _incrementCounter3,
                    child: const Icon(Icons.add, color: Colors.black))
              ],
            ),
            const SizedBox(
              height: 22,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text('Details'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          height: height(context) * 0.25,
                          width: width(context) * 0.6,
                          child: Image.asset(
                            "images/fastag.jpg",
                            fit: BoxFit.fill,
                          ),
                        ),
                         Positioned(
                          left: 15,
                          top:height(context) * 0.15 ,
                          child: const Text("12",style: TextStyle(fontSize: 55,fontWeight: FontWeight.bold, color: Color.fromARGB(255, 124, 7, 109), ),))
                      ],
                    ),
                    Container(
                      width: width(context) * 0.6,
                      height: 22,
                      color: const Color.fromARGB(255, 124, 7, 109),
                      child: const Center(
                        child: Text(
                          "12",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 17,
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
                          horizontal: width(context) * 0.13,
                          vertical: height(context) * 0.01)),
                      textStyle: MaterialStateProperty.all(const TextStyle(
                          fontSize: 30, fontWeight: FontWeight.bold)),
                    ),
                    onPressed: _decrement4,
                    child: const Icon(
                      Icons.remove,
                      color: Colors.black,
                    )),
                SizedBox(
                  width: width(context) * 0.03,
                ),
                Container(
                  color: const Color.fromARGB(255, 215, 238, 184),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 11),
                  child: Text(
                    "$_counter4",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  width: width(context) * 0.03,
                ),
                ElevatedButton(
                    style: ButtonStyle(
                      overlayColor: MaterialStateProperty.all(
                          const Color.fromARGB(255, 10, 156, 83)),
                      backgroundColor: MaterialStateProperty.all(
                          const Color.fromARGB(255, 186, 233, 198)),
                      padding: MaterialStateProperty.all(EdgeInsets.symmetric(
                          horizontal: width(context) * 0.13,
                          vertical: height(context) * 0.01)),
                      textStyle: MaterialStateProperty.all(const TextStyle(
                          fontSize: 30, fontWeight: FontWeight.bold)),
                    ),
                    onPressed: _incrementCounter4,
                    child: const Icon(Icons.add, color: Colors.black))
              ],
            ),
            const SizedBox(
              height: 90,
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
          child:  Text(
            "buy".tr(),
            style: TextStyle(color: Colors.black),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
