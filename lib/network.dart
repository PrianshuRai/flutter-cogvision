import 'dart:convert';
import 'package:http/http.dart' as http;
// import 'login_page.dart';

Map<String, dynamic> params = {
  // "program": "fire",
  // "userId": "Prasad19f87",
  // "startdate": "2021-05-11",
  // "enddate": "2021-08-15",
  // "cameraname": "",
  // "deptCameras": ""
  "email": "prasad.biradar@cogvision.ai", // prasad.biradar
  "password": "cogvision123"
};

class GetData {
  Future<dynamic> login() async {
    String base_url =
        "http://192.168.1.8:5020/users/login"; //getAnalyticsAlertsBySummary
    var response =
        await http.post(Uri.parse(base_url), body: jsonEncode(params));
    if (response.statusCode == 200) {
      Map<String, dynamic> file = jsonDecode(response.body);
      print(
          "================status code: ${response.statusCode} ${response.body}");
    } else {
      print("else conditon:: ${response}body:: ${response.body}");
    }

    // if (response.statusCode == HttpStatus.ok){
    // print("Success");
    // // }
    // print('getting response: ${response.body}');
    // return response.body;
  }
}

// [{datetime: 2021/05/12, message: 47},
// {datetime: 2021/05/11, message: 59}]
