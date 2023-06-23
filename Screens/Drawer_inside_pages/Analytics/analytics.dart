import 'dart:convert';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gpsglobe/Constant.dart';
import 'package:gpsglobe/Screens/Home_page/Drawer/Drawermain.dart';
import 'package:gpsglobe/global/global.dart';
import 'package:http/http.dart' as http;

List<String> days = ['Today', 'Yesterday', 'Last 7 days', 'Last 30 days'];
String selectedDrop = 'Today';

String dropdownValue = 'Today'; // default value
int selecteddropdays = 0;

Map<String, int> dateValue = {
  'Today': 0,
  'Yesterday': 1,
  'Last 7 days': 7,
  'Last 30 days': 30,
};

class Check extends StatefulWidget {
  const Check({super.key});

  @override
  State<Check> createState() => _CheckState();
}

class _CheckState extends State<Check> {
  int _page = 0;
  int _size = 10;
  bool _isLoading = false;
  List<Map<String, dynamic>> _dataList = [];
  final _scrollController = ScrollController();

  Future<void> _fetchData() async {
    setState(() {
      _isLoading = true;
    });

    final url =
        Uri.parse('http://globalgps.in:8089/api/v1/Reports/GetSummaryDetails');
    final response = await http.post(url, body: {
      'uid': '$finalUid',
      'size': _size.toString(),
      'page': _page.toString(),
      'intervel': '$selecteddropdays',
    });

    if (response.statusCode == 200) {
      final List<dynamic> responseData = json.decode(response.body);
      setState(() {
        _dataList.addAll(responseData.cast<Map<String, dynamic>>());
        _isLoading = false;
      });
    } else {
      setState(() {
        _isLoading = false;
      });
      throw Exception('Failed to load data');
    }
    setState(() {});
  }

  void _loadMoreData() {
    final double threshold = 0.8;
    final int loadMoreIndex = _dataList.length - 1;
    if (_scrollController.position.extentAfter == 0 &&
        loadMoreIndex >= _size - 1) {
      setState(() {
        _size += 10;
        _page += 1;
      });
      _fetchData();
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: const Floatingaction_button(),
      drawer: const Drawer(
        backgroundColor: Colors.black,
        child: Drawermain(),
      ),
      // backgroundColor: Colors.green[500],
      appBar: AppBar(
        title: Text("analytics".tr()),
      ),
      body: Column(children: [
        const marquee(),
        SizedBox(
          // color: Colors.red,
          width: double.infinity,
          height: 60,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 30,
            ),
            child: DropdownButtonFormField<String>(
                // isDense: false,
                enableFeedback: false,
                // dropdownColor: Colors.green,
                value: selectedDrop,
                items: days.map((e) {
                  return DropdownMenuItem(
                      onTap: () {
                        setState(() {
                          selectedDrop = e;
                        });
                      },
                      value: e,
                      child: Text(e));
                }).toList(),
                onChanged: (val) {
                  setState(() {
                    selectedDrop = val!;
                  });
                }),
          ),
        ),
        Expanded(
          child: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ListView.builder(
                    controller: _scrollController,
                    itemCount: _dataList.length + 1,
                    itemBuilder: (context, index) {
                      if (index == _dataList.length) {
                        return _isLoading
                            ? const Center(child: CircularProgressIndicator())
                            : const SizedBox.shrink();
                      }
                      final data = _dataList[index];
                      // render data item in UI
                      return Item(
                        vehicleNumber: data[index]["vehicleNo"],
                        distaneInKms: "",
                        idleTime: "",
                        ignitionOnCount: "",
                        maxSpeed: "",
                        stopageTime: "",
                        travelTime: "",
                      );
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ]),
    );
  }
}

///// item
class Item extends StatelessWidget {
  const Item({
    Key? key,
    required this.vehicleNumber,
    required this.ignitionOnCount,
    required this.maxSpeed,
    required this.travelTime,
    required this.stopageTime,
    required this.idleTime,
    required this.distaneInKms,
  }) : super(key: key);
  final String vehicleNumber;
  final String ignitionOnCount;
  final String maxSpeed;
  final String travelTime;
  final String stopageTime;
  final String idleTime;
  final String distaneInKms;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(255, 255, 255, 255).withOpacity(0.4),
              // color: Color.fromARGB(255, 255, 255, 255).withOpacity(0.1),
              offset: const Offset(-6.0, -6.0),
              blurRadius: 16.0,
            ),
            BoxShadow(
              color: const Color.fromARGB(255, 85, 90, 90).withOpacity(0.4),
              // color: Colors.black.withOpacity(0.2),
              offset: const Offset(6.0, 6.0),
              blurRadius: 10.0,
            ),
          ],
          color: const Color.fromARGB(255, 255, 255, 255),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Column(
            children: [
              FirstPart(text1: 'Vehicle Number', text2: vehicleNumber),
              Common(
                  text1: 'Ignition On Count',
                  text2: ignitionOnCount,
                  text3: 'Max Speed',
                  text4: maxSpeed),
              Common(
                  text1: 'Travel Time',
                  text2: travelTime,
                  text3: 'Stopage Time',
                  text4: stopageTime),
              Common(
                  text1: 'idle Time',
                  text2: idleTime,
                  text3: 'Distance In kms',
                  text4: distaneInKms),
              const Lastpart(text1: 'Status', text2: 'Fuel Reading')
            ],
          ),
        ),
      ),
    );
  }
}

///part 1

class FirstPart extends StatelessWidget {
  const FirstPart({
    Key? key,
    required this.text1,
    required this.text2,
  }) : super(key: key);
  final String text1;
  final String text2;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: SizedBox(
        width: double.infinity,
        height: 50,
        child: Row(children: [
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 236, 235, 235),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10))),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      text1,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      text2,
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 2,
          ),
        ]),
      ),
    );
  }
}
// common part

class Common extends StatelessWidget {
  const Common({
    Key? key,
    required this.text1,
    required this.text2,
    required this.text3,
    required this.text4,
  }) : super(key: key);
  final String text1;
  final String text2;
  final String text3;
  final String text4;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: SizedBox(
        width: double.infinity,
        height: 50,
        child: Row(children: [
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 236, 235, 235),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10))),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      text1,
                      style: const TextStyle(
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      text2,
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 2,
          ),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 236, 235, 235),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10))),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      text3,
                      style: const TextStyle(
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      text4,
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}

// last part
class Lastpart extends StatelessWidget {
  const Lastpart({
    Key? key,
    required this.text1,
    required this.text2,
  }) : super(key: key);
  final String text1;
  final String text2;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: SizedBox(
        width: double.infinity,
        height: 50,
        child: Row(children: [
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 236, 235, 235),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10))),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      text1,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 2,
          ),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 236, 235, 235),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10))),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      text2,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}

class analyticsmain extends StatefulWidget {
  String vehiclenumber;
  int ignitiononcount;
  String maxspeed;
  String running;
  String idle;
  String stop;
  String distenceInKM;

  analyticsmain(
      {super.key,
      required this.vehiclenumber,
      required this.ignitiononcount,
      required this.maxspeed,
      required this.idle,
      required this.running,
      required this.stop,
      required this.distenceInKM});

  @override
  State<analyticsmain> createState() => _analyticsmainState();
}

class _analyticsmainState extends State<analyticsmain> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        // height: 140,
        width: width(context),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          color: const Color.fromARGB(255, 37, 101, 39),
          // color: const Color.fromARGB(255, 85, 10, 10),
          boxShadow: [
            BoxShadow(
              color: Colors.white.withOpacity(0.1),
              offset: const Offset(-6.0, -6.0),
              blurRadius: 15.0,
            ),
            BoxShadow(
              color: const Color.fromARGB(255, 153, 151, 151).withOpacity(0.4),
              offset: const Offset(6.0, 6.0),
              blurRadius: 15.0,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    (widget.vehiclenumber),
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                  Row(
                    children: [
                      const Text(
                        "Distance in Kms :",
                        style: TextStyle(fontSize: 15, color: Colors.white),
                      ),
                      Text(
                        widget.distenceInKM,
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                    ],
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 55,
                    width: width(context) * 0.2,
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 207, 240, 213),
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Running",
                          style: TextStyle(
                              color: Colors.green, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          widget.running,
                          style: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 55,
                    width: width(context) * 0.2,
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 251, 251, 181),
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Idle",
                          style: TextStyle(
                              color: Color.fromARGB(255, 97, 88, 5),
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          widget.idle,
                          style: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 55,
                    width: width(context) * 0.2,
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 255, 177, 177),
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Stop",
                          style: TextStyle(
                              color: Colors.red, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          widget.stop,
                          style: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  Container(
                      height: 55,
                      width: width(context) * 0.2,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "🔑",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "On : ${widget.ignitiononcount}",
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          )
                        ],
                      )),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        "Max.Speed: ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: width(context) * 0.04),
                      ),
                      Text(
                        widget.maxspeed,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: width(context) * 0.04),
                      )
                    ],
                  ),
                  const Icon(
                    Icons.play_arrow,
                    color: Colors.white,
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class analytics extends StatefulWidget {
  const analytics({super.key});

  @override
  State<analytics> createState() => _analyticsState();
}

class _analyticsState extends State<analytics> {
  int _page = 0;
  int _size = 5;
  bool _isLoading = false;
  List<Map<String, dynamic>> _dataList = [];
  final _scrollController = ScrollController();

  Future _fetchData() async {
    setState(() {
      _isLoading = true;
    });

    final url =
        Uri.parse('http://globalgps.in:8089/api/v1/Reports/GetSummaryDetails');
    final response = await http.post(url, body: {
      'uid': finalUid.toString(),
      'size': "10",
      'page': _page.toString(),
      'intervel': selecteddropdays.toString(),
    });
    print("Runn $_page  $selecteddropdays");
    if (response.statusCode == 200) {
      final List<dynamic> responseData = json.decode(response.body);
      setState(() {
        _dataList.addAll(responseData.cast<Map<String, dynamic>>());
        _isLoading = false;
        print("Runn $_dataList");
      });
    } else {
      setState(() {
        _isLoading = false;
      });
      throw Exception('Failed to load data');
    }
  }

  void _loadMoreData() {
    final double threshold = 0.8;
    final int loadMoreIndex = _dataList.length - 1;
    if (_scrollController.position.extentAfter == 0 &&
        loadMoreIndex >= _size - 1) {
      setState(() {
        // _size += 5;
        _page += 1;
      });
      _fetchData();
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchData();
    _scrollController.addListener(scrollListener);
  }

  @override
  void dispose() {
    _scrollController.removeListener(scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  void scrollListener() {
    if (!_isLoading) {
      _loadMoreData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //  backgroundColor:  Color.fromARGB(255, 53, 42, 42),
        title: Text("analytics".tr()),
      ),
      body: Column(
        children: [
          const marquee(),
          SizedBox(
            // color: Colors.red,
            width: double.infinity,
            height: 60,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 30,
              ),
              child: DropdownButtonFormField<String>(
                  // isDense: false,
                  enableFeedback: false,
                  // dropdownColor: Colors.green,
                  value: dropdownValue,
                  items:
                      dateValue.keys.map<DropdownMenuItem<String>>((String e) {
                    return DropdownMenuItem(
                        onTap: () {
                          setState(() {
                            dropdownValue = e;

                            selecteddropdays = dateValue[dropdownValue]!;
                            _dataList.clear();
                            _page = 0;
                            _fetchData();
                          });
                        },
                        value: e,
                        child: Text(e));
                  }).toList(),
                  onChanged: (val) {
                    dropdownValue = val!;
                    _page = 0;
                  }),
            ),
          ),
          Expanded(
            child: ListView.builder(
                controller: _scrollController,
                itemCount: _dataList.length + 1,
                itemBuilder: (context, index) {
                  if (index == _dataList.length) {
                    return _isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : const SizedBox.shrink();
                  }
                  final data = _dataList[index];

                  // render data item in UI
                  return analyticsmain(
                    vehiclenumber: data["vehicleNo"].toString(),
                    ignitiononcount: data["details"][0]["ignitionOnCnt"],
                    maxspeed: data["details"][0]["maxSpeed"].toString(),
                    idle: data["details"][0]["idelTime"].toString(),
                    running: data["details"][0]["travelTime"].toString(),
                    stop: data["details"][0]["stopageTime"].toString(),
                    distenceInKM: data["details"][0]["distenceInKM"].toString(),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
