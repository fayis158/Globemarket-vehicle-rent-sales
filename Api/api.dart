import 'dart:convert';
import 'package:gpsglobe/global/global.dart';
import 'package:gpsglobe/res/response.dart';
import 'package:http/http.dart' as http;

String allVehicle = '';
String stoppedvehicle = '';
String runningVehicle = '';

List allhomeepagedata = [];
List allhomeepagedatasecond = [];

List testlist = [];
String teststring = "";
List expiredvehicledata = [];
List popupwarning = [];
List getalertmessages = [];
List historypoly = [];
List lathis = [];
List notificationlist = [];
List transactionsuccesslist = [];
List<dynamic> getvehicle = [];

/// reports

List stoppagereport = [];
List distancedaywisereportlist = [];
List distanceperiodicreportlist = [];
List overspeedreportlist = [];
List vehicleonoffcountlist = [];
List vehicleidlereportlist = [];
List travelreportlist = [];
List vehiclesummaryreportlist = [];
List geofencereportlist = [];
List fulldetailslist = [];

//share  button

Map sharebuttonmap = {};
Map email = {};

// Map getuplopadeddate = {};
Map<String, dynamic> getuplopadeddate = {};

//relay
List relaylist = [];
String relaymes = "";

class Api {
//login page api

  static Future<List> userLogin(String userid, String password) async {
    String ApiUrl =
        "http://globalgps.in:8089/api/v3/Accout/Login/$userid/$password";
    // ignore: non_constant_identifier_names
    List Loginlist = [];
    var reqres = await RequestAssistant.receiverRequest(ApiUrl);

    if (reqres != "Error occured failed") {
      Loginlist = reqres;
    }
    return Loginlist;
  }

//3

// home page marquee response

  static Future<List> advertaisment() async {
    // ignore: non_constant_identifier_names
    String ApiUrl = "http://globalgps.in:8089/api/v1/Details/GetAdvertisements";
    List advertaisment = [];
    var reqres = await RequestAssistant.receiverRequest(ApiUrl);

    if (reqres != "Error occured failed") {
      advertaisment = reqres;
    }
    return advertaisment;
  }

// homepage api

  static Future<List> homepagedata() async {
    String ApiUrl = "http://globalgps.in:8089/api/v6/Live/Details/$finalUid";
    Map<String, dynamic> homepagedata = {};
    Map vehiclecount = {};
    var x = await http.get(Uri.parse(ApiUrl));
    final h = x.headers;

    h.forEach((key, value) {
      if (key.contains("stopped_vehicles")) {
        stoppedvehicle = value;
      }
      if (key.contains("running_vehicles")) {
        runningVehicle = value;
      }
      if (key.contains("all_vehicles")) {
        allVehicle = value;
      }
    });
    var reqres = await RequestAssistant.receiverRequest(ApiUrl);

    if (reqres != "Error occured failed") {
      homepagedata = reqres;
      // ignore: non_constant_identifier_names
      List Homepagedatalist = homepagedata["all_vehicles"];

      for (int i = 0; i < Homepagedatalist.length; i++) {
        var lonlat = await http.get(Uri.parse(
            "https://globalgps.in:8087/api/v2/Getlocation?lat=${Homepagedatalist[i]["latitude"]}&lng=${Homepagedatalist[i]["longitude"]}"));
        if (lonlat.statusCode == 200) {
          var loc = jsonDecode(lonlat.body);
          Homepagedatalist[i].addAll({"finallocation": loc["locationName"]});
          allhomeepagedata = Homepagedatalist;
        }
      }
    }
    {}

    return allhomeepagedata;
  }

  //today km
  static Future<List> Todaykm() async {
    String ApiUrl = "http://globalgps.in:8089/api/v6/Live/Details/$finalUid";
    Map<String, dynamic> homepagedata2 = {};
    var reqres = await RequestAssistant.receiverRequest(ApiUrl);
    if (reqres != "Error occured failed") {
      homepagedata2 = reqres;
      // ignore: non_constant_identifier_names
      List Homepagedatalist2 = homepagedata2["all_vehicles"];
      for (int i = 0; i < Homepagedatalist2.length; i++) {
        var todaykm = await http.get(Uri.parse(
            "http://globalgps.in:8089/api/v6/Live/DistanceDetails/${Homepagedatalist2[i]["latitude"]}/19906"
            // "http://globalgps.in:8089/api/v6/Live/DistanceDetails/$finalUid/${Homepagedatalist2[i]["vid"]}"
            ));

        if (todaykm.statusCode == 200) {
          var tdykm = jsonDecode(todaykm.body);
          Homepagedatalist2[i]
              .addAll({"todaytotkmlatest": tdykm["totalDistance"]});
          allhomeepagedatasecond = Homepagedatalist2;
        }
      }
    }

    return allhomeepagedatasecond;
  }

  // contact us

  static Future<Map> ContactUs(String userid, String msg) async {
    // ignore: non_constant_identifier_names
    String ApiUrl =
        "http://globalgps.in:8089/api/v1/Details/SendMessage/$userid/$msg";
    Map conatact = {};
    var reqres = await RequestAssistant.receiverRequest(ApiUrl);

    if (reqres != "Error occured failed") {
      conatact = reqres;
    }
    return conatact;
  }

// change vehicle number apis
// to get vehicle list

  static Future<List> getvehiclelist() async {
    // ignore: non_constant_identifier_names
    String ApiUrl = "http://globalgps.in:8089/api/v1/NewDevice/GetVehicleTypes";

    var reqres = await RequestAssistant.receiverRequest(ApiUrl);

    if (reqres != "Error occured failed") {
      getvehicle = reqres["result"] as List;
    }
    return getvehicle;
  }

  static Future<dynamic> changevehiclenumber(
      String vid, String vehiclenumber, String vehicleid) async {
    // ignore: non_constant_identifier_names
    String ApiUrl =
        "http://globalgps.in:8089/api/v1/NewDevice/ChangeVehicleNo/$vid/$vehiclenumber/$vehicleid";
    var getvehicle;

    var vehiclenumberchange = await RequestAssistant.receiverRequest(ApiUrl);

    if (vehiclenumberchange != "Error occured failed") {
      getvehicle = vehiclenumberchange;
    }
    return getvehicle;
  }
//post
//
//
//post
//
//change password

  static Future<String> postchangepass(int id, String oldpasswod,
      String newpassord, String comparedpassword) async {
    String res = '';
    var changepassword = await http.post(
      Uri.parse("http://globalgps.in:8089/api/v1/AccoutModify/$oldpasswod"),
      headers: <String, String>{
        'Content-type': 'application/json; charset=UTF-8'
      },
      body: jsonEncode(<dynamic, dynamic>{
        "id": id,
        "oldPassword": oldpasswod,
        "newPassword": newpassord,
        "comparePassWord": comparedpassword
      }),
    );
    if (changepassword.statusCode == 200) {
      var passwordchange = jsonDecode(changepassword.body);

      res = passwordchange;
      return res;
    } else {
      return "somthing went wrong";
    }
    return res;
  }

// post analytics

  // static Future<List> analytics(var size, var page) async {
  //   var res;
  //   var changepassword = await http.post(
  //     Uri.parse("http://globalgps.in:8089/api/v1/Reports/GetSummaryDetails"),
  //     headers: <String, String>{
  //       'Content-type': 'application/json; charset=UTF-8'
  //     },
  //     body: jsonEncode(<dynamic, dynamic>{
  //       "uid": 7460,
  //       "size": size,
  //       "page": page,
  //       "intervel": 7
  //     }),
  //   );
  //   if (changepassword.statusCode == 200) {
  //     var analytics = jsonDecode(changepassword.body);

  //     res = analytics;
  //     return res;
  //   } else {
  //     return [];
  //   }
  //   // return res;
  // }

  // upload documents

  static Future<Map> uploaddocuments(
    var vid,
    var Type,
    var date,
  ) async {
    Map res = {};
    var uploaddocument = await http.post(
      Uri.parse("http://globalgps.in:8089/api/v1/NewDevice/UploadDocument"),
      headers: <String, String>{
        'Content-type': 'application/json; charset=UTF-8'
      },
      body: jsonEncode(
          <dynamic, dynamic>{"vid": "$vid", "type": "$Type", "date": "$date"}),
    );
    if (uploaddocument.statusCode == 200) {
      var passwordchange = jsonDecode(uploaddocument.body);

      res = passwordchange;
      return res;
    } else {
      return {};
    }
    // return res;
  }

  ///document

  static Future<List> Documents() async {
    // ignore: non_constant_identifier_names
    String ApiUrl =
        "http://globalgps.in:8089/api/v1/NewDevice/GetDocumnetDetails/$finalUid";
    List<dynamic> getdocumentdetails = [];

    var reqres = await RequestAssistant.receiverRequest(ApiUrl);

    if (reqres != "Error occured failed") {
      getdocumentdetails = reqres["result"] as List;
      teststring =
          reqres["result"][0]["docList"][0]["insuranceDate"].toString();
    }
    return getdocumentdetails;
  }

// EXPIRED VEHICLE CALL
//Gps due

  static Future<List> Expiredveh() async {
    DateTime now = DateTime.now();
    String formattedDate = now.toString().substring(0, 10);

    String ApiUrl =
        "http://globalgps.in:8089/api/v1/Vehicle/ExpiredVehicles/$finalUid/$formattedDate";
    // ignore: non_constant_identifier_names
    List expiredvehicle = [];
    var reqres = await RequestAssistant.receiverRequest(ApiUrl);

    if (reqres != "Error occured failed") {
      expiredvehicledata = reqres;
    }
    return expiredvehicledata;
  }

  //popup warning message

  static Future<List> popuppaymentwarning() async {
    // ignore: non_constant_identifier_names
    String ApiUrl = "http://globalgps.in:8089/api/v1/Details/GetPaymentWarning";

    var reqres = await RequestAssistant.receiverRequest(ApiUrl);

    if (reqres != "Error occured failed") {
      popupwarning = reqres;
    }
    return popupwarning;
  }

  //alert message

  static Future<List> Alertmessagepage() async {
    // ignore: non_constant_identifier_names
    String ApiUrl = "http://globalgps.in:8089/api/v1/AlertsForUser/$userid";

    var reqres = await RequestAssistant.receiverRequest(ApiUrl);

    if (reqres != "Error occured failed") {
      getalertmessages = reqres;
    }
    return [];
  }

  //Notification api

  static Future<List<dynamic>> notification() async {
    // ignore: non_constant_identifier_names
    String ApiUrl = "http://globalgps.in:8089/api/v1/Notifications/$finalUid";

    var reqres = await RequestAssistant.receiverRequest(ApiUrl);

    if (reqres != "Error occured failed") {
      notificationlist = reqres;
    }
    return notificationlist;
  }

  ///transaction success

  static Future transactionsuccess(var date) async {
    // ignore: non_constant_identifier_names
    String ApiUrl =
        "http://globalgps.in:8089/api/v1/Vehicle/PaymentTransactionHistory1/$finalUid/$date";

    var reqres = await RequestAssistant.receiverRequest(ApiUrl);

    if (reqres != "Error occured failed") {
      transactionsuccesslist = reqres;
    }
    return transactionsuccesslist;
  }

  ///REPORT APIS

// stoppage report api

  static Future Stoppagerepport(
      var vid, var startingdate, var enddate, var intervel) async {
    // ignore: non_constant_identifier_names
    String ApiUrl =
        "http://www.globalgps.in:8089/api/v1/Reports/stopagge/$vid/$startingdate/$enddate/$intervel?ReportTypeId={ReportTypeId}&Type={Type}";

    var reqres = await RequestAssistant.receiverRequest(ApiUrl);

    if (reqres != "Error occured failed") {
      stoppagereport = reqres;
    }
    return stoppagereport;
  }

  //Distancedaywise report

  static Future distancedaywisereport(
    var vid,
    var startingdate,
    var enddate,
  ) async {
    // ignore: non_constant_identifier_names
    String ApiUrl =
        "http://globalgps.in:8089/api/v1/Reports/DistenceDayWise/$vid/$startingdate/$enddate?ReportTypeId=6&intervel=00&Type=excel";
    // "http://globalgps.in:8089/api/v1/Reports/DistenceDayWise/$vid/$startingdate/$enddate?ReportTypeId=6&intervel=00&Type=excel";

    var reqres = await RequestAssistant.receiverRequest(ApiUrl);

    if (reqres != "Error occured failed") {
      distancedaywisereportlist = reqres;
    }
    return distancedaywisereportlist;
  }

  //distance periodic report

  static Future distanceperiodicreport(
    var vid,
    var startingdate,
    var enddate,
  ) async {
    String ApiUrl =
        "http://globalgps.in:8089/api/v1/Reports/ProidicDetailsByVid/$vid/$startingdate/$enddate?ReportTypeId={ReportTypeId}&intervel={intervel}&Type={Type}";

    var reqres = await RequestAssistant.receiverRequest(ApiUrl);

    if (reqres != "Error occured failed") {
      distanceperiodicreportlist = reqres;
    }
    return distanceperiodicreportlist;
  }

  // Overspeed Report

  static Future overspeedreport(
    var vid,
    var startingdate,
    var enddate,
    var intervel,
  ) async {
    String ApiUrl =
        "http://globalgps.in:8089/api/v1/Reports/OverSpeed/$vid/$startingdate/$enddate/$intervel?ReportTypeId={ReportTypeId}&Type={Type}";

    var reqres = await RequestAssistant.receiverRequest(ApiUrl);

    if (reqres != "Error occured failed") {
      overspeedreportlist = reqres;
    }
    return overspeedreportlist;
  }

  //vehicle onoff count report

  static Future vehicleonoffcount(
    var vid,
    var startingdate,
    var enddate,
  ) async {
    String ApiUrl =
        "http://globalgps.in:8089/api/v1/Reports/VehicleOnOffCount/$vid/$startingdate/$enddate?ReportTypeId={ReportTypeId}&intervel={intervel}&Type={Type}";

    var reqres = await RequestAssistant.receiverRequest(ApiUrl);

    if (reqres != "Error occured failed") {
      vehicleonoffcountlist = reqres;
    }
    return vehicleonoffcountlist;
  }

  //vehicle idle report

  static Future vehicleidlereport(
    var vid,
    var startingdate,
    var enddate,
    var intervel,
  ) async {
    String ApiUrl =
        "http://globalgps.in:8089/api/v1/Reports/idel/$vid/$startingdate/$enddate/$intervel?ReportTypeId={ReportTypeId}&Type={Type}";

    var reqres = await RequestAssistant.receiverRequest(ApiUrl);

    if (reqres != "Error occured failed") {
      vehicleidlereportlist = reqres;
    }
    return vehicleidlereportlist;
  }

//Travel Report

  static Future travelreport(
    var vid,
    var startingdate,
    var enddate,
    var intervel,
  ) async {
    String ApiUrl =
        "http://globalgps.in:8089/api/v1/Reports/travel/$vid/$startingdate/$enddate/$intervel?ReportTypeId={ReportTypeId}&Type={Type}";

    var reqres = await RequestAssistant.receiverRequest(ApiUrl);

    if (reqres != "Error occured failed") {
      travelreportlist = reqres;
    }
    return travelreportlist;
  }

//vehicle summary report

  static Future vehiclesummaryreport(
    var vid,
    var startingdate,
    var enddate,
  ) async {
    String ApiUrl =
        "http://globalgps.in:8089/api/v1/Reports/VehicleSummary/$vid/$startingdate/$enddate?ReportTypeId={ReportTypeId}&intervel={intervel}&Type={Type}";

    var reqres = await RequestAssistant.receiverRequest(ApiUrl);

    if (reqres != "Error occured failed") {
      vehiclesummaryreportlist = reqres;
    }
    return vehiclesummaryreportlist;
  }

//geofence alert report

  static Future geofencereport(
    var vid,
    var startingdate,
    var enddate,
  ) async {
    String ApiUrl =
        "http://globalgps.in:8089/api/v1/Reports/GeofenceAlerts/$vid/$startingdate/$enddate?intervel=0&Type={Type}";

    var reqres = await RequestAssistant.receiverRequest(ApiUrl);

    if (reqres != "Error occured failed") {
      geofencereportlist = reqres;
    }
    return geofencereportlist;
  }

//full details report

  static Future fulldetails(
    var vid,
    var startingdate,
    var enddate,
    var intervel,
  ) async {
    String apiUrl =
        "http://globalgps.in:8089/api/v1/Reports/DetailSummaryByVid/$vid/$startingdate/$enddate/$intervel?ReportTypeId={ReportTypeId}&Type={Type}";

    var reqres = await RequestAssistant.receiverRequest(apiUrl);

    if (reqres != "Error occured failed") {
      fulldetailslist = reqres;
    }
    return fulldetailslist;
  }

  //share button in dashbord

  static Future sharebutton(
    var vid,
    var startingdate,
    var enddate,
  ) async {
    String apiUrl =
        "http://globalgps.in:8089/api/v1/Live/CreateVehicleShareLink/$vid/$startingdate/$enddate";

    var reqres = await RequestAssistant.receiverRequest(apiUrl);

    if (reqres != "Error occured failed") {
      sharebuttonmap = reqres;
    }
    return sharebuttonmap;
  }

//relay api

  static Future Relay(
    var vid,
  ) async {
    String apiUrl =
        "http://www.globalgps.in:8089/api/v1/Vehicle/Controlling/GetCommands/$vid";

    var reqres = await RequestAssistant.receiverRequest(apiUrl);

    if (reqres != "Error occured failed") {
      relaylist = reqres;
    }
    return relaylist;
  }

  static Future relaymessage(var vid, int onoff) async {
    String apiUrl =
        "http://www.globalgps.in:8089/api/v1/Vehicle/Controlling/AddCommand/$vid/$onoff";

    var reqres = await RequestAssistant.receiverRequest(apiUrl);

    if (reqres != "Error occured failed") {
      relaymes = reqres;
    }
    return relaymes;
  }

  //emailsend
  //http://globalgps.in:8089/api/v1/Reports/ExportReports/Excel/5/2007/2023-03-10 00:00:00/2023-03-10 18:08:28/0?Type={Type}

  static Future emailsenddocument(
    var vid,
    var reportid,
    var startingdate,
    var enddate,
    var intervel,
  ) async {
    String ApiUrl =
        "http://globalgps.in:8089/api/v1/Reports/ExportReports/Excel/$reportid/$vid/$startingdate/$enddate/$intervel?Type={Type}";

    var reqres = await RequestAssistant.receiverRequest(ApiUrl);

    if (reqres != "Error occured failed") {
      email = reqres;
    }
    return email;
  }

// dashboard stopagetime

  static Future stopagetime(String vid) async {
    String ApiUrl =
        "http://globalgps.in:8089/api/v6/Live/StoppageDetails/$finalUid/$vid";

    var reqres = await RequestAssistant.receiverRequest(ApiUrl);

    String sttym = "";
    if (reqres != "Error occured failed") {
      sttym = reqres["statusSince"];
    }
    return sttym;
  }

  static Future todaykm(String vid) async {
    String ApiUrl =
        "http://globalgps.in:8089/api/v6/Live/DistanceDetails/$finalUid/$vid";

    var reqres = await RequestAssistant.receiverRequest(ApiUrl);

    String tdykm = "";
    if (reqres != "Error occured failed") {
      tdykm = reqres["totalDistance"];
    }
    return tdykm;
  }

  //get  today km inside playroute

  static Future stoppagekmplay(
      String vid, String startdate, String enddate, String intervel) async {
    String ApiUrl =
        "http://globalgps.in:8089/api/v1/History/GetRunningStopTimeByVid/$vid/$startdate/$enddate/$intervel";

    var reqres = await RequestAssistant.receiverRequest(ApiUrl);

    var stoptime;
    if (reqres != "Error occured failed") {
      stoptime = reqres[0]["details"][0]["stopTime"];
    } else {}
    return stoptime;
  }

//get  stoppage point km inside playroute

  static Future Todaykmplay(
      String vid, String startdate, String enddate, String intervel) async {
    String ApiUrl =
        "http://globalgps.in:8089/api/v1/History/GetRunningStopTimeByVid/$vid/$startdate/$enddate/$intervel";

    var reqres = await RequestAssistant.receiverRequest(ApiUrl);

    var runtime;
    if (reqres != "Error occured failed") {
      runtime = reqres[0]["details"][0]["runTime"];
    } else {}
    return runtime;
  }

  static Future idlehr(
      String vid, String startdate, String enddate, String intervel) async {
    String ApiUrl =
        "http://globalgps.in:8089/api/v1/History/GetRunningStopTimeByVid/$vid/$startdate/$enddate/$intervel";

    var reqres = await RequestAssistant.receiverRequest(ApiUrl);

    var idlechr;
    if (reqres != "Error occured failed") {
      idlechr = reqres[0]["details"][0]["idelTime"];
    } else {}
    return idlechr;
  }

  static Future idlecount(
      String vid, String startdate, String enddate, String intervel) async {
    String ApiUrl =
        "http://globalgps.in:8089/api/v1/History/GetRunningStopTimeByVid/$vid/$startdate/$enddate/$intervel";

    var reqres = await RequestAssistant.receiverRequest(ApiUrl);

    var idlecount;
    if (reqres != "Error occured failed") {
      idlecount = reqres[0]["details"][0]["ignitionOnCnt"].toString();
    } else {}
    return idlecount;
  }
}
