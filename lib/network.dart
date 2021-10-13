import 'dart:convert';
import 'package:http/http.dart' as http;

Map<String, dynamic> params = {
  "program": "fire",
  "userId": "Prasad19f87",
  "startdate": "2021-05-11",
  "enddate": "2021-08-15",
  "cameraname": "",
  "deptCameras": ""
};

class GetData {
  Future<dynamic> login() async {
    // var params = {
    //   "program": "fire",
    //   "userId": "Prasad19f87",
    //   "startdate": "2021-05-11",
    //   "enddate": "2021-08-15",
    //   "cameraname": "",
    //   "deptCameras": "",
    // };

    String base_url = "http://192.168.1.8:5020/getAnalyticsAlertsBySummary";
    var response =
        await http.post(Uri.parse(base_url), body: jsonEncode(params));
    if (response.statusCode != null) {
      print(" inside conditon ${response} ${response.body}");
    } else {
      print("else conditon ${response} ${response.body}");
    }

    // if (response.statusCode == HttpStatus.ok){
    print("Success");
    // }
    print('getting response: ${response.body}');
    return response.body;
  }
}
