import 'dart:convert';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gpsglobe/Screens/Gps_payment/Transaction.dart';
import 'package:gpsglobe/global/global.dart';
import 'package:gpsglobe/gps_payment_api/api_payment.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:http/http.dart' as http;

Set vehiclesIdList = {};
var _razorpay = Razorpay();

const style1 = TextStyle(
  fontWeight: FontWeight.bold,
  color: Colors.black,
  fontSize: 15,
);
const style2 = TextStyle(
  fontSize: 15,
  fontWeight: FontWeight.w600,
  color: Color.fromARGB(255, 75, 71, 71),
);

var selectAll = false;
var noselectAll = false;
var gpsSelector = false;

class Gps_payments_pending extends StatefulWidget {
  const Gps_payments_pending({super.key});

  @override
  State<Gps_payments_pending> createState() => _Gps_payments_pendingState();
}

class _Gps_payments_pendingState extends State<Gps_payments_pending> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: DefaultTabController(
          length: 2,
          child: Column(children: [
            TabBar(
              indicatorColor: const Color.fromARGB(255, 4, 187, 35),
              labelColor: const Color.fromARGB(255, 4, 187, 35),
              tabs: [
                Tab(text: "gpsdue".tr()),
                Tab(text: "transaction".tr()),
              ],
            ),
            const Expanded(
                child: TabBarView(
              children: [
                GPSPay(),
                Transactions(),
              ],
            ))
          ]),
        ),
      ),
    );
  }
}

class GPSPay extends StatefulWidget {
  const GPSPay({super.key});

  @override
  State<GPSPay> createState() => _GPSPayState();
}

class _GPSPayState extends State<GPSPay> {
  int amount = 0;

  @override
  List myList = [];
  String vehicleId = "";
  String paymentid = "";
  String vehiclevidforapiglobal = "";

  void initState() {
    super.initState();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    pay();
  }

  pay() async {
    myList = (await PaymentApi.getDuePaymentDetails())!;
    for (var i = 0; i < myList.length; i++) {
      myList[i]["isSelected"] = false;
    }

    setState(() {});
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    paymentid = response.paymentId!;
    PaymentApi.postpayment(
        vehiclevidforapiglobal, amount.toString(), paymentid);
  }

  void _handlePaymentError(PaymentFailureResponse response) {}

  void _handleExternalWallet(ExternalWalletResponse response) {}

  

  bool selectAll = false;
  int x = 450;
  int total = 0;
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        myList.isNotEmpty
            ? Row(
                children: [
                  Checkbox(
                      checkColor: const Color.fromARGB(255, 255, 253, 253),
                      value: selectAll,
                      onChanged: (bool? val) {
                        selectAll = val ?? false;
                        if (selectAll) {
                          total = 0;

                          for (var i = 0; i < myList.length; i++) {
                            myList[i]["isSelected"] = true;

                            total = total + int.parse(myList[i]["duePayment"]);
                            total < 0 ? total = 0 : total;
                          }
                        } else {
                          // vehiclesIdList = [;
                          total < 0 ? total = 0 : total;
                          for (var i = 0; i < myList.length; i++) {
                            myList[i]["isSelected"] = false;

                            // vehiclesIdList.remove(myList[i]["vid"]);
                            total = total - int.parse(myList[i]["duePayment"]);
                            total < 0 ? total = 0 : total;
                          }
                        }

                        setState(() {});
                      }),
                  Text(
                    "selectall".tr(),
                    style: TextStyle(
                        color: const Color.fromARGB(255, 66, 65, 65),
                        fontWeight: selectAll == true
                            ? FontWeight.bold
                            : FontWeight.normal),
                  ),
                ],
              )
            : const SizedBox(),

        // 2nd one

        Expanded(
          child: Column(
            children: [
              myList.isEmpty
                  ? Expanded(
                      child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            "🙂",
                            style: TextStyle(color: Colors.red, fontSize: 29),
                          ),
                          Text(
                            "No Due Payment is Pending.",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ))
                  : Expanded(
                      child: ListView.builder(
                      itemCount: myList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: Container(
                            decoration: BoxDecoration(
                                boxShadow: const [
                                  BoxShadow(
                                      color: Colors.grey,
                                      spreadRadius: 1,
                                      blurRadius: 1)
                                ],
                                color: const Color.fromARGB(255, 255, 255, 255),
                                borderRadius: BorderRadius.circular(10)),
                            width: double.infinity,
                            height: 160,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Checkbox(
                                        value: myList[index]["isSelected"],
                                        onChanged: (value) {
                                          myList[index]["isSelected"] = value!;
                                          vehiclesIdList.add(
                                              myList[index]["vid"].toString());
                                          vehicleId = "dscvgfsdvcgfdvcg";
                                          if (myList[index]["isSelected"] ==
                                              true) {
                                            // vehiclesIdList = [];
                                            total = total +
                                                int.parse(myList[index]
                                                    ["duePayment"]);
                                            total < 0 ? total = 0 : total;
                                          } else {
                                            // vehiclesIdList = [];
                                            total < 0 ? total = 0 : total;
                                            vehiclesIdList.remove(myList[index]
                                                    ["vid"]
                                                .toString());
                                            total = total -
                                                int.parse(myList[index]
                                                    ["duePayment"]);
                                            total < 0 ? total = 0 : total;
                                          }

                                          setState(() {});
                                        },
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        myList[index]["vehicleNo"],
                                        style: style1,
                                      ),
                                      const Spacer(),
                                      Text(
                                        'Expired',
                                        style: style1.copyWith(
                                            color: Colors.red,
                                            fontWeight: FontWeight.normal),
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Row(
                                    children: [
                                      const Text('Expiry Date'),
                                      const Spacer(),
                                      Text(
                                        myList[index]["expiryDate"],
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Expanded(
                                  child: Container(
                                    // width: double.infinity,
                                    decoration: const BoxDecoration(
                                      color: Color.fromARGB(226, 217, 255, 216),
                                      borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(10),
                                        bottomRight: Radius.circular(10),
                                      ),
                                    ),

                                    child: Column(children: [
                                      Row(
                                        children: [
                                          const Padding(
                                            padding: EdgeInsets.all(10.0),
                                            child: Text('Limited time offer '),
                                          ),
                                          const Spacer(),
                                          Padding(
                                            padding: const EdgeInsets.all(0.0),
                                            child: Column(
                                              children: [
                                                Text(
                                                  'Rs : ${myList[index]["duePayment"]} ',
                                                  style: style1.copyWith(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w900),
                                                ),
                                                Text(
                                                  '${myList[index]["renewalDays"]} days',
                                                  textAlign: TextAlign.right,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ]),
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ))
            ],
          ),
        ),
        Row(
          children: [
            Expanded(
                flex: 1,
                child: Container(
                  height: 50,
                  color: Colors.red,
                  child: Center(
                    child: Text(
                      total.toString(),
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                )),
            Expanded(
                flex: 1,
                child: GestureDetector(
                  onTap: () {
                    amount = total;
                    String vehiclevidforapi = vehiclesIdList
                        .toString()
                        .replaceAll("{", "")
                        .replaceAll("}", "");
                    vehiclevidforapiglobal = vehiclevidforapi;

                    getFinalorderId(vehiclevidforapi, total);
                    amount = total;

                    // var orderDetails =
                    //     await getOrderId(vehiclevidforapi, total);
                    // if (orderDetails != null) {
                    // var options = {
                    //   'key': 'rzp_test_SZGJ3Va0g5GrKG',
                    //   'amount': total * 100,
                    //   'name': 'SHANKAR',
                    //   'description': 'Fine T-Shirt',
                    //   'order_id': "order_LSYXYsgqOWNkl7",
                    //   'prefill': {
                    //     'contact': '8888888888',
                    //     'email': 'test@razorpay.com'
                    //   }
                    // };
                    // _razorpay.open(options);
                    // }
                  },
                  child: Container(
                    height: 50,
                    color: Colors.green,
                    child: const Center(
                      child: Text(
                        "Pay Now",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ))
          ],
        )
      ],
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _razorpay.clear();
  }
}

class Gps extends StatelessWidget {
  const Gps({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color.fromARGB(255, 157, 219, 255),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              children: const [
                Text(
                  'GPS Plan:',
                  style: style1,
                ),
                Text(
                  ' Validity: 12 month',
                  style: style2,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text(
                  '₹ 4000',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      decoration: TextDecoration.lineThrough),
                ),
                const Text(
                  '  ₹ 3499',
                  style: style2,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 20,
                    width: 80,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: const Color.fromARGB(255, 10, 168, 15)),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4.0),
                      child: Center(
                        child: Text(
                          '13% OFF',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FittedBox(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    height: 30,
                    width: 20,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color.fromARGB(255, 214, 78, 141)),
                    child: const Center(
                        child: Icon(
                      Icons.back_hand_sharp,
                      color: Color.fromARGB(255, 255, 255, 255),
                      size: 10,
                      shadows: [Shadow(color: Colors.black, blurRadius: 10)],
                    )),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Row(
                    children: const [
                      Text(
                        '₹300 extra will be applicable for ',
                        style: style2,
                      ),
                      Text(
                        'Relay ',
                        style: style1,
                      ),
                      Text(
                        'Service.',
                        style: style2,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ]),
      ),
    );
  }
}

getOrderId(vehs, amount) async {
  // Map<String, dynamic> x = {};
  dynamic jsonresponse = {};

  final res = await http.post(
      Uri.parse("http://globalgps.in:8089/api/v1/Vehicles/OrderCreation"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({"vehs": vehs.toString(), "totalAmount": 2000}));

  try {
    jsonresponse = json.decode(res.body);
  } catch (e) {}
  return jsonresponse["orderId"];
}

getFinalorderId(vehs, amount) async {
  var id = await getOrderId(vehs, amount);

  await startPayment(id, amount);
}

startPayment(String orderid, int amount) {
  var options = {
    'key': 'rzp_live_Gk0qd8fzRN89QS',
    'amount': (amount * 100),
    'name': finalUserName,
    'description': 'Fine T-Shirt',
    'notes': {
      'order_id': orderid,
    },
    // 'order_id': "order_LSiYVBSPRXARX5",
    'prefill': {'contact': '8888888888', 'email': ''}
  };

  try {
    _razorpay.open(options);
  } catch (e) {}
}
