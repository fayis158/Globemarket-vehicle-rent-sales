import 'dart:convert';
import 'package:http/http.dart' as http;

class RequestAssistant {

  static Future<dynamic> receiverRequest(String url) async {
    
    http.Response httpResponse = await http.get(Uri.parse(url));
    
    try {

      if (httpResponse.statusCode == 200) {

        
        
        String responseData = httpResponse.body;
        
        var decodeResponseData = jsonDecode(responseData);

        return decodeResponseData;
        
      } else {

        return "Error Occurd , Failed";

      }

    } catch (exp) {
      
      return "${exp}Error occured failed";

    }
  }
}
