import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:easy_pdf_viewer/easy_pdf_viewer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../Api/api2.dart';
import '../../../../Screens/Drawer_inside_pages/Buy_gps/buy_gps.dart';
import '../../../../Screens/Home_page/Home_page.dart';
import '../../../../Screens/more_in_tabbar.dart/More.dart';
import '../../../../global/global.dart';
import 'package:http/http.dart' as http;

import '../../Api_Truck_service/ApiT.dart';
import '../../Api_Truck_service/controller.dart';
//

import 'package:path_provider/path_provider.dart';

import '../../Supply/Supply.dart';

///
var _razorpay = Razorpay();

class SubscribeT extends StatefulWidget {
  const SubscribeT({super.key});

  @override
  State<SubscribeT> createState() => _SubscribeTState();
}

class _SubscribeTState extends State<SubscribeT> {
  final ApiT myController = Get.put(ApiT());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    myController.pricelist();
  }


showmessage() {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Center(
        child: SizedBox(
          width: 260.0,
          height: 180.0,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        "Globe GPS",
                        style: TextStyle(
                            color: Colors.green,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const Text(
                    "Notice : - ",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const Text("Buy GPS To Access our GPS services"),
                  GestureDetector(
                    onTap: () {
                      launch("tel://87922897640");
                    },
                    child: const Text(
                      "87922897640",
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      launch("tel://9148998994");
                    },
                    child: const Text(
                      "9148998994",
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Text("--> Click --> "),
                      const SizedBox(
                        width: 9,
                      ),
                      TextButton(
                        child: const Text('Buy GPS'),
                        onPressed: () {
                          Get.back();
                          Get.to(() => const Buy_GPS());
                        },
                      ),
                      TextButton(
                        child: const Text('OK'),
                        onPressed: () {
                          Get.back();
                          // Navigator.of(context).pop();
                        },
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 39, 38, 36),
          title: const Text("Renewal"),
          actions: [
            IconButton(
                onPressed: () {
                  finalUid == 0
                      ? showmessage()

                      //  showAlert(
                      //     context, 'Notice', 'Buy GPS To Access our GPS services')
                      : Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TabBarDemo(),
                          ));
                },
                icon: const Icon(Icons.gps_fixed)),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const More(),
                  ),
                );
              },
              icon: Image.asset(
                'rentimages/cart.png',
              ),
            )
          ],
        ),
        body: DefaultTabController(
          length: 2,
          child: Column(children: [
            const TabBar(
              indicatorColor: Color.fromARGB(255, 4, 187, 35),
              labelColor: Color.fromARGB(255, 4, 187, 35),
              tabs: [
                Tab(text: "Renewal"),
                Tab(text: "Transaction"),
              ],
            ),
            Expanded(
                child: TabBarView(
              children: [
                Subscription(
                    days30: myController.days30.toInt(),
                    days90: myController.days90.toInt(),
                    days180: myController.days180.toInt(),
                    days365: myController.days365.toInt()),
                const Transaction(),
              ],
            ))
          ]),
        ),
      ),
    );
  }
}

class Subscription extends StatefulWidget {
  Subscription(
      {super.key,
      required this.days30,
      required this.days90,
      required this.days180,
      required this.days365});

  int days30;
  int days90;
  int days180;
  int days365;

  @override
  State<Subscription> createState() => _SubscriptionState();
}

class _SubscriptionState extends State<Subscription> {
  final ApiController anotherPageController = Get.put(ApiController());

  String paymentidrent = '';
  int amount = 0;
  int days = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    paymentidrent = response.paymentId!;
    //postapi call here
    anotherPageController.paymentapirent(amount, paymentidrent, days);
  }

  void _handlePaymentError(PaymentFailureResponse response) {}

  void _handleExternalWallet(ExternalWalletResponse response) {}

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 12,
          ),
          Container(
            // height: 280,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(12)),
              color: Color.fromARGB(255, 236, 224, 224),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  const Text(
                    "Renewal Plan",
                    style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                        fontSize: 22),
                  ),
                  ListTile(
                    leading: const Text(
                      "Validity 30 days",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                    trailing: Text(
                      "RS: ${widget.days30}",
                      style: const TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                  ),
                  MaterialButton(
                    onPressed: () {
                      amount = 150;
                      days = 30;
                      getFinalorderId(amount);
                    },
                    height: 40,
                    minWidth: 300,
                    color: Colors.green,
                    child: const Text(
                      'Renewal 30 Days Plan',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                  const ListTile(
                    leading: Text(
                      "Validity 90 days",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                    trailing: Text(
                      "RS: 300",
                      style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                  ),
                  MaterialButton(
                    onPressed: () {
                      amount = 300;
                      days = 90;
                      getFinalorderId(amount);
                    },
                    height: 40,
                    minWidth: 300,
                    color: Colors.green,
                    child: const Text(
                      'Renewal 90 Days Plan',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                  const ListTile(
                    leading: Text(
                      "Validity 180 days",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                    trailing: Text(
                      "RS: 550",
                      style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                  ),
                  MaterialButton(
                    onPressed: () {
                      amount = 550;
                      days = 180;
                      getFinalorderId(amount);
                    },
                    height: 40,
                    minWidth: 300,
                    color: Colors.green,
                    child: const Text(
                      'Renewal 180 Days Plan',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                  const ListTile(
                    leading: Text(
                      "Validity 365 days",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                    trailing: Text(
                      "RS: 999",
                      style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                  ),
                  MaterialButton(
                    onPressed: () {
                      amount = 999;
                      days = 365;
                      getFinalorderId(amount);
                    },
                    height: 40,
                    minWidth: 300,
                    color: Colors.green,
                    child: const Text(
                      'Renewal 365 Days Plan',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // GestureDetector(
          //     onTap: () {
          //       Get.snackbar(
          //         '',
          //         '',
          //         messageText: Text(
          //           "message",
          //           textAlign: TextAlign.center,
          //           style: TextStyle(
          //             color: Colors.white,
          //             fontSize: 16,
          //           ),
          //         ),
          //         backgroundColor: Colors.black54,
          //         duration: Duration(seconds: 2),

          //         margin: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          //         padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          //         borderRadius: 10,
          //         isDismissible: true,
          //         // dismissDirection: SnackDismissDirection.HORIZONTAL,
          //       );
          //     },
          //     child: Text("snak")),
        ],
      ),
    );
  }
}

// transaction

class Transaction extends StatefulWidget {
  const Transaction({super.key});

  @override
  State<Transaction> createState() => _TransactionState();
}

class _TransactionState extends State<Transaction> {
  final ApiT myController = Get.put(ApiT());

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: myController.getpaymenthistory(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          return Obx(() {
            final paymenthistorylist = myController.paymenthistory;
            if (paymenthistorylist.isNotEmpty) {
              return ListView.builder(
                itemCount: paymenthistorylist.length,
                itemBuilder: (context, index) {
                  return Tranaction(
                    username: paymenthistorylist[index]["userName"].toString(),
                    transactiondate:
                        paymenthistorylist[index]["transactionDate"].toString(),
                    rate: paymenthistorylist[index]["amount"].toString(),
                    paymentid:
                        paymenthistorylist[index]["paymentId"].toString(),
                    expdate: paymenthistorylist[index]["expiryDate"].toString(),
                  );
                },
              );
            } else {
              return ListView.builder(
                itemCount: 0,
                itemBuilder: (context, index) {
                  return const SizedBox();
                },
              );
            }
          });
        }
      },
    );
  }
}

class Tranaction extends StatelessWidget {
  Tranaction(
      {super.key,
      required this.username,
      required this.transactiondate,
      required this.rate,
      required this.paymentid,
      required this.expdate});

  String username;
  String transactiondate;
  String rate;
  String paymentid;
  String expdate;

  @override
  Widget build(BuildContext context) {
    Color whitecolor = Colors.black;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            padding: const EdgeInsets.all(12),
            // height: 200,
            width: double.infinity,
            color: const Color.fromARGB(255, 226, 226, 223),
            child: Column(
              children: [
                const Text(
                  "Payment Successful",
                  style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                      fontSize: 25),
                ),
                SizedBox(
                  height: 30,
                  child: ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Text(
                      "User : ",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: whitecolor),
                    ),
                    trailing: Text(
                      username,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: whitecolor),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                  child: ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: const Text(
                      "Transaction Date :",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                          color: Colors.green),
                    ),
                    trailing: Text(
                      transactiondate,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                          color: Colors.green),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                  child: ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Text(
                      "RS : ",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                          color: whitecolor),
                    ),
                    trailing: Text(
                      rate,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                          color: whitecolor),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                  child: ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: const Text(
                      "expired Date :",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                          color: Colors.red),
                    ),
                    trailing: Text(
                      expdate,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                          color: Colors.red),
                    ),
                  ),
                ),
                ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Text(
                      "Download Bill",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: whitecolor),
                    ),
                    trailing: MaterialButton(
                      color: const Color.fromARGB(150, 76, 25, 25),
                      onPressed: () {
                        Get.to(() => PdfviewBill(
                              paymentid: paymentid,
                            ));
                      },
                      child: const Text(
                        "Download",
                        style: TextStyle(color: Colors.white),
                      ),
                    )),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

//payment order creation subscription

getOrdercreationforsubscription(var amount) async {
  // Map<String, dynamic> x = {};
  dynamic jsonresponse = {};

  final res = await http.post(
      Uri.parse("http://globalgps.in:8089/api/v1/GlobeMarket/OrderCreation"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({"uId": rentuid, "totalAmount": amount}));

  try {
    jsonresponse = json.decode(res.body);
  } catch (e) {}
  return jsonresponse["orderId"];
}

getFinalorderId(amount) async {
  var id = await getOrdercreationforsubscription(amount);

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

//

class PdfviewBill extends StatefulWidget {
  PdfviewBill({
    this.progressExample = false,
    required this.paymentid,
  });
  String paymentid;
  final bool progressExample;

  @override
  State<PdfviewBill> createState() => _PdfviewBillState();
}

class _PdfviewBillState extends State<PdfviewBill> {
  bool _isLoading = true;
  final ApiT myController = Get.put(ApiT());

  @override
  void initState() {
    super.initState();
    loadDocument();
  }

  convertion() async {
    await myController.convertrentpaymentbill(widget.paymentid);
  }

  PDFDocument? document;
  Future<void> loadDocument() async {
    await convertion();

    await DefaultCacheManager().emptyCache();

    document = await PDFDocument.fromURL(
        "http://globalgps.in:8089/MarketPamentBill/${widget.paymentid}.pdf");

    setState(() => _isLoading = false);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 39, 38, 36),
        title: const Text('Bill Document'),
        actions: [
          IconButton(
              onPressed: () {
                _sharePdf(
                    "http://globalgps.in:8089/MarketPamentBill/${widget.paymentid}.pdf");
                setState(() {});
              },
              icon: const Icon(Icons.share)),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: PDFViewer(
                document: document!,
                lazyLoad: false,
                zoomSteps: 1,
                // numberPickerConfirmWidget: const Text(
                //   "Confirm",
                // ),
              ),
            ),
    );
  }

  Future<void> _sharePdf(var url) async {
    var dio = Dio();
    try {
      var response = await dio.get(url,
          options: Options(responseType: ResponseType.bytes));
      var directory = await getExternalStorageDirectory();
      var file = File('${directory!.path}/${widget.paymentid}.pdf');
      await file.writeAsBytes(response.data);
      await Share.shareFiles([file.path],
          mimeTypes: ['application/pdf'],
          subject: 'Check out this PDF file',
          sharePositionOrigin: const Rect.fromLTWH(0, 0, 1, 1));
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
