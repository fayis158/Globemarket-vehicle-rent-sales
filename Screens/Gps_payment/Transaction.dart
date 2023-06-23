import 'dart:io';

import 'package:dio/dio.dart';
import 'package:easy_pdf_viewer/easy_pdf_viewer.dart';
import 'package:flutter/material.dart';

import 'package:gpsglobe/Api/api.dart';
import 'package:gpsglobe/Api/api2.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class Transactions extends StatefulWidget {
  const Transactions({super.key});

  @override
  State<Transactions> createState() => _TransactionsState();
}

class _TransactionsState extends State<Transactions> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: transactionsuccesslist.length,
      itemBuilder: (context, index) {
        return Transaction_container(
          vehicleno: transactionsuccesslist[index]["vehicleNo"],
          date: transactionsuccesslist[index]["transactionDate"],
          amount: transactionsuccesslist[index]["amount"],
          paymentmode: transactionsuccesslist[index]["paymentMode"],
          paymentid: transactionsuccesslist[index]["paymentId"].toString(),
        );
      },
    );
  }
}

class Transaction_container extends StatelessWidget {
  String vehicleno;
  String date;
  String paymentmode;
  int amount;
  String paymentid;
  Transaction_container(
      {super.key,
      required this.vehicleno,
      required this.date,
      required this.paymentmode,
      required this.amount,
      required this.paymentid});

  pdfpaymentconvert() async {
    await Api2.converttopdfpayment(paymentid);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Column(
        children: [
          Container(
            // height: MediaQuery.of(context).size.height * 0.23,
            width: double.infinity,
            decoration: const BoxDecoration(
                color: Color.fromARGB(255, 255, 255, 255),
                borderRadius: BorderRadius.all(Radius.circular(12))),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 1,
                  ),
                  Text(
                    vehicleno,
                    style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  const Text(
                    "Transaction date and time",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  Text(
                    date,
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  SizedBox(
                      height: MediaQuery.of(context).size.height * 0.04,
                      child: Center(
                          child: Text(
                        "RS : ${amount.toString()}     Success",
                        style: const TextStyle(
                            color: Color.fromARGB(255, 22, 150, 10),
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ))),
                  const SizedBox(
                    height: 3,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Pyment mode : $paymentmode"),
                      Row(
                        children: [
                          // ignore: prefer_const_constructor
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => PdfviewBill(
                                  paymentid: paymentid,
                                ),
                              ));
                            },
                            child: const Text(
                              "Download  Bill",
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),

                          IconButton(
                              onPressed: () {
                                pdfpaymentconvert();
                                _sharePdf(
                                    "http://globalgps.in:8089/PaymentBill/$paymentid.pdf");
                              },
                              icon: const Icon(
                                Icons.share,
                                color: Colors.black,
                              )),
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  //pdf section
  Future<void> _sharePdf(var url) async {
    var dio = Dio();
    try {
      var response = await dio.get(url,
          options: Options(responseType: ResponseType.bytes));
      var directory = await getExternalStorageDirectory();
      var file = File('${directory!.path}/$paymentid.pdf');
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

  @override
  void initState() {
    super.initState();
    loadDocument();
  }

  convertion() async {
    await Api2.converttopdfpayment(widget.paymentid);
  }

//  void clearPdfCache() async {
//     await DefaultCacheManager().emptyCache();
//   }

  PDFDocument? document;
  Future<void> loadDocument() async {
    await convertion();
    await DefaultCacheManager().emptyCache();
    document = await PDFDocument.fromURL(
        "http://globalgps.in:8089/PaymentBill/${widget.paymentid}.pdf");
    setState(() => _isLoading = false);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text('Bill Document'),
        actions: [
          IconButton(
              onPressed: () {
                _sharePdf(
                    "http://globalgps.in:8089/PaymentBill/${widget.paymentid}.pdf");
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
