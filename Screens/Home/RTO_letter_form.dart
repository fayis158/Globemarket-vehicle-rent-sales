import 'package:flutter/material.dart';
import 'package:gpsglobe/Api/api.dart';

import 'package:gpsglobe/Constant.dart';
import 'package:gpsglobe/Screens/Home_page/Home_page.dart';
import 'package:gpsglobe/extensions/extensions.dart';
import 'package:gpsglobe/global/global.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:dio/dio.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';
import '../../Api/api2.dart';
import '../../test.dart';
import 'package:easy_pdf_viewer/easy_pdf_viewer.dart';

class Rto_letter_form extends StatefulWidget {
  String vehiclenum;
  String installeddate;
  String expdate;
  String vid;
  int type;
  Rto_letter_form(
      {super.key,
      required this.vehiclenum,
      required this.installeddate,
      required this.expdate,
      required this.type,
      required this.vid});

  @override
  State<Rto_letter_form> createState() => _Rto_letter_formState();
}

class _Rto_letter_formState extends State<Rto_letter_form> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController operatornamec = TextEditingController();
  TextEditingController registeredoptnumc = TextEditingController();
  TextEditingController vehicleumberc = TextEditingController();
  TextEditingController vehicletype = TextEditingController();
  TextEditingController enginenumberc = TextEditingController();
  TextEditingController chasisnumberc = TextEditingController();
  TextEditingController operatoraddressc = TextEditingController();
  TextEditingController rtonamec = TextEditingController();
  TextEditingController rtoaddress = TextEditingController();
  TextEditingController installationdate = TextEditingController();
  TextEditingController expiringdate = TextEditingController();
  TextEditingController permitcontroller = TextEditingController();
  TextEditingController vehiclemake = TextEditingController();
  TextEditingController vehiclemodel = TextEditingController();
  TextEditingController manufactured = TextEditingController();
  TextEditingController registered = TextEditingController();
  TextEditingController fitness = TextEditingController();

  @override
  void initState() {
    super.initState();
    getrtodetails(widget.vid);
    operatornamec = TextEditingController(text: finalUserName);
    registeredoptnumc = TextEditingController(text: mobilenumber);
    vehicleumberc = TextEditingController(text: widget.vehiclenum);
    installationdate = TextEditingController(text: widget.installeddate);
    expiringdate = TextEditingController(text: widget.expdate);
    operatoraddressc = TextEditingController(text: owneraddress);
    vehicletype = TextEditingController(
        text: widget.type == 1
            ? "Car"
            : widget.type == 2
                ? "Truck"
                : widget.type == 3
                    ? "Bus"
                    : widget.type == 4
                        ? "Bike"
                        : widget.type == 5
                            ? "Ambulance"
                            : widget.type == 6
                                ? "Jeep"
                                : widget.type == 7
                                    ? "Van"
                                    : widget.type == 8
                                        ? "Bulldozer"
                                        : widget.type == 9
                                            ? "Man"
                                            : widget.type == 10
                                                ? "Tractor"
                                                : widget.type == 11
                                                    ? "Roller"
                                                    : widget.type == 12
                                                        ? "Tipper"
                                                        : widget.type == 13
                                                            ? "Hitachi"
                                                            : widget.type == 14
                                                                ? "Tanker"
                                                                : widget.type ==
                                                                        15
                                                                    ? "Grader"
                                                                    : widget.type ==
                                                                            16
                                                                        ? "JCB"
                                                                        : widget.type ==
                                                                                17
                                                                            ? "Crane"
                                                                            : "");
    getrtodetails(widget.vid);
  }

  bool enabled = true;
  List myrtodata = [];

  getrtodetails(var vid) async {
    myrtodata = await Api2.getrtogetails(vid);
    enginenumberc = TextEditingController(
        text: myrtodata[0]["details"][0]["engineNo"].toString());
    chasisnumberc = TextEditingController(
        text: myrtodata[0]["details"][0]["chasisNo"].toString());
    rtonamec = TextEditingController(
        text: myrtodata[0]["details"][0]["rtoName"].toString());
    rtoaddress = TextEditingController(
        text: myrtodata[0]["details"][0]["rtoAddress"].toString());
    permitcontroller = TextEditingController(
        text: myrtodata[0]["details"][0]["permit"].toString());
    vehiclemake = TextEditingController(
        text: myrtodata[0]["details"][0]["make"].toString());
    vehiclemodel = TextEditingController(
        text: myrtodata[0]["details"][0]["model"].toString());
    manufactured = TextEditingController(
        text: myrtodata[0]["details"][0]["manufactureDate"].toString());
    registered = TextEditingController(
        text: myrtodata[0]["details"][0]["registrationDate"].toString());
    fitness = TextEditingController(
        text: myrtodata[0]["details"][0]["lastFitnessDate"].toString());
    setState(() {});
  }

  bool _isDownloading = false;
  String _downloadUrl =
      'http://globalgps.in:8089/RtoCertificate/BULLET.pdf'; // replace with your PDF API endpoint URL
  String _fileName = 'BULLET.pdf'; // replace with your desired PDF file name

  Future<void> _downloadFile() async {
    setState(() {
      _isDownloading = true;
    });
    try {
      final dir = await getExternalStorageDirectory();
      final file = File('${dir!.path}/$_fileName');
      final response = await http.get(Uri.parse(_downloadUrl));
      await file.writeAsBytes(response.bodyBytes);
      setState(() {
        _isDownloading = false;
      });
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('PDF downloaded successfully'),
        backgroundColor: Colors.green,
      ));
    } catch (e) {
      setState(() {
        _isDownloading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('PDF download failed'),
        backgroundColor: Colors.red,
      ));
    }
  }

  String response = "";

  convertion() async {
    await Api2.converttopdf(widget.vid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text("RTO LETTER FORM"),
        actions: [
          chasisnumberc.text.isNotEmpty &&
                  enginenumberc.text.isNotEmpty &&
                  rtoaddress.text.isNotEmpty &&
                  rtonamec.text.isNotEmpty &&
                  permitcontroller.text.isNotEmpty &&
                  vehiclemake.text.isNotEmpty &&
                  vehiclemodel.text.isNotEmpty &&
                  manufactured.text.isNotEmpty &&
                  registered.text.isNotEmpty &&
                  fitness.text.isNotEmpty
              ? IconButton(
                  onPressed: () {
                    _sharePdf(
                        "http://globalgps.in:8089/RtoCertificate/${widget.vehiclenum}.pdf");
                    setState(() {});
                  },
                  icon: const Icon(Icons.share,color: Colors.white,))
              : const SizedBox(),
          IconButton(
              onPressed: () => TabBarDemo().navigateTo(context),
              icon: const Icon(Icons.home))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Textfieldref(
                  textcontroller: operatornamec,
                  labelText: "Owner Name",
                  enabled: false,
                  linenumber: 2,
                ),
                Textfieldref(
                  textcontroller: registeredoptnumc,
                  labelText: "Phone Number",
                  enabled: false,
                  linenumber: 2,
                ),
                Textfieldref(
                  textcontroller: vehicleumberc,
                  labelText: "Vehicle Number",
                  enabled: false,
                  linenumber: 2,
                ),
                Textfieldref(
                  textcontroller: vehicletype,
                  labelText: "Vehicle Type",
                  enabled: false,
                  linenumber: 2,
                ),
                Textfieldref(
                  textcontroller: installationdate,
                  labelText: "Installation Date",
                  enabled: false,
                  linenumber: 2,
                ),
                Textfieldref(
                  textcontroller: expiringdate,
                  labelText: "Expiring Date",
                  enabled: false,
                  linenumber: 2,
                ),
                Textfieldref(
                  textcontroller: operatoraddressc,
                  labelText: "Operator Address",
                  enabled: false,
                  linenumber: 3,
                ),
                Textfieldref(
                  textcontroller: vehiclemake,
                  labelText: "Vehicle Make*",
                  enabled: enabled,
                  linenumber: 2,
                ),
                Textfieldref(
                  textcontroller: vehiclemodel,
                  labelText: "Vehicle Model*",
                  enabled: enabled,
                  linenumber: 2,
                ),
                Textfieldref(
                  textcontroller: manufactured,
                  labelText: "manufactured Date*",
                  enabled: enabled,
                  linenumber: 2,
                ),
                Textfieldref(
                  textcontroller: registered,
                  labelText: "Registered Date*",
                  enabled: enabled,
                  linenumber: 2,
                ),
                Textfieldref(
                  textcontroller: fitness,
                  labelText: "Last Fitness Date*",
                  enabled: enabled,
                  linenumber: 2,
                ),
                Textfieldref(
                  textcontroller: permitcontroller,
                  labelText: "Permit*",
                  enabled: enabled,
                  linenumber: 2,
                ),
                Textfieldref(
                  textcontroller: enginenumberc,
                  labelText: "Engine Number*",
                  enabled: enabled,
                  linenumber: 2,
                ),
                Textfieldref(
                  textcontroller: chasisnumberc,
                  labelText: "chassis Number*",
                  enabled: enabled,
                  linenumber: 2,
                ),
                Textfieldref(
                  textcontroller: rtonamec,
                  labelText: "RTO Name*",
                  enabled: enabled,
                  linenumber: 2,
                ),
                Textfieldref(
                  textcontroller: rtoaddress,
                  labelText: "RTO Address*",
                  enabled: enabled,
                  linenumber: 4,
                ),
                const SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      Api2.rtoletter(
                          widget.vid,
                          enginenumberc.text,
                          chasisnumberc.text,
                          permitcontroller.text,
                          rtonamec.text,
                          rtoaddress.text,
                          vehiclemake.text,
                          vehiclemodel.text,
                          manufactured.text,
                          registered.text,
                          fitness.text);
                      Api2.converttopdf(widget.vid);
                      convertion();
                      enabled = false;

                      showPopupMessage(context);
                      // ScaffoldMessenger.of(context).showSnackBar(
                      //   const SnackBar(content: Text('Successful')),
                      // );

                      Future.delayed(
                          const Duration(
                            seconds: 4,
                          ), () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Pdfview(
                                vehiclenum: widget.vehiclenum,
                                vid: widget.vid,
                                url:
                                    "http://globalgps.in:8089/RtoCertificate/${widget.vehiclenum}.pdf"),
                          ),
                        );
                      });
                      setState(() {});
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Please Enter all required field')),
                      );
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: MediaQuery.of(context).size.height / 14,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: const Color.fromARGB(141, 1, 131, 8)),
                      child: const Center(
                          child: Text(
                        "Save",
                        style: TextStyle(color: Colors.white),
                      )),
                    ),
                  ),
                ),
                // chasisnumberc.text.isNotEmpty &&
                //         enginenumberc.text.isNotEmpty &&
                //         rtoaddress.text.isNotEmpty &&
                //         rtonamec.text.isNotEmpty &&
                //         permitcontroller.text.isNotEmpty &&
                //         vehiclemake.text.isNotEmpty &&
                //         vehiclemodel.text.isNotEmpty &&
                //         manufactured.text.isNotEmpty &&
                //         registered.text.isNotEmpty &&
                //         fitness.text.isNotEmpty
                //     ? Padding(
                //         padding: const EdgeInsets.symmetric(horizontal: 12),
                //         child: Row(
                //           mainAxisAlignment: MainAxisAlignment.end,
                //           children: [
                //             // const Text("Download Pdf"),
                //             IconButton(
                //                 onPressed: () {
                //                   _sharePdf(
                //                       "http://globalgps.in:8089/RtoCertificate/${widget.vehiclenum}.pdf");
                //                   setState(() {});
                //                 },
                //                 icon: const Icon(Icons.share)),
                //             // IconButton(
                //             //     onPressed: () {
                //             //       setState(() {

                //             //         _downloadFile();
                //             //         // downloadPdf(
                //             //         //     "http://globalgps.in:8089/RtoCertificate/BULLET.pdf");
                //             //         // _downloadFile();
                //             //       });
                //             //     },
                //             //     icon: const Icon(Icons.download))
                //           ],
                //         ),
                //       )
                //     : const SizedBox()
              ],
            ),
          ),
        ),
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
      var file = File('${directory!.path}/${widget.vehiclenum}.pdf');
      await file.writeAsBytes(response.data);
      await Share.shareFiles([file.path],
          mimeTypes: ['application/pdf'],
          subject: 'Check out this PDF file',
          sharePositionOrigin: const Rect.fromLTWH(0, 0, 1, 1));
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void showPopupMessage(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async => false, // disable closing by tapping outside
          child: AlertDialog(
            // title: Text("Reminder"),
            contentPadding: EdgeInsets.zero, // remove default padding
            content: SizedBox(
              height: 200,
              width: 12,
              child: Center(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Lottie.asset("assets/done.json", width: 180),
                    const Text(
                      "Successful",
                      style: TextStyle(
                          color: Color.fromARGB(255, 24, 76, 8), fontSize: 20),
                    ),
                    const Text(
                      "Now you can download and share the pdf",
                      style: TextStyle(fontSize: 14),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );

    Future.delayed(
        const Duration(
          seconds: 3,
        ), () {
      Navigator.of(context).pop(); // Close the dialog after 3 seconds

      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => Pdfview(
      //         vehiclenum: widget.vehiclenum,
      //         vid: widget.vid,
      //         url:
      //             "http://globalgps.in:8089/RtoCertificate/${widget.vehiclenum}.pdf"),
      //   ),
      // );
    });
  }
}

//  Lottie.asset("assets/done.json"),
class Textfieldref extends StatelessWidget {
  Textfieldref(
      {super.key,
      required this.textcontroller,
      required this.labelText,
      required this.enabled,
      required this.linenumber});

  TextEditingController textcontroller;
  String labelText;
  bool enabled;
  int linenumber;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        TextFormField(
          maxLines: linenumber,
          minLines: 1,
          enabled: enabled,
          controller: textcontroller,
          decoration: InputDecoration(
            labelText: labelText,
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
      ],
    );
  }
}

class Pdfview extends StatefulWidget {
  Pdfview(
      {this.progressExample = false,
      required this.url,
      required this.vehiclenum,
      required this.vid});
  String url;
  String vehiclenum;
  String vid;

  final bool progressExample;

  @override
  State<Pdfview> createState() => _PdfviewState();
}

class _PdfviewState extends State<Pdfview> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    loadDocument();
  }

  convertion() async {
    await Api2.converttopdf(widget.vid);
  }

//  void clearPdfCache() async {
//     await DefaultCacheManager().emptyCache();
//   }

  PDFDocument? document;
  Future<void> loadDocument() async {
    await convertion();
    await DefaultCacheManager().emptyCache();

    // document =await PDFDocument.fromURL(
    //     "");
    document = await PDFDocument.fromURL(
        "http://globalgps.in:8089/RtoCertificate/${widget.vehiclenum}.pdf");
    setState(() => _isLoading = false);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text('RTO Document'),
        actions: [
          IconButton(
              onPressed: () {
                _sharePdf(
                    "http://globalgps.in:8089/RtoCertificate/${widget.vehiclenum}.pdf");
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
      var file = File('${directory!.path}/${widget.vehiclenum}.pdf');
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
