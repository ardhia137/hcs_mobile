import 'dart:convert';

import 'package:hcs_mobile/model/CovidModel.dart';
import 'package:hcs_mobile/utils/url.dart';
import 'package:http/http.dart' as http;

class CovidServices {
  // String baseUrl = '';
  Future<CovidModel> get_covid() async {
    var url = '${covidurl()}';
    var headers = {'Content-Type': 'application/json; charset=utf-8'};
    // var body = jsonEncode({
    //   'email': email,
    // });

    var response = await http.get(
      Uri.parse(url),
      headers: headers,
      // body: body,
    );
    print(url);
    print(response.statusCode);

    // print(response.body);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      print(data);
      CovidModel covid = CovidModel.fromJson(data);
      return covid;
    } else {
      throw Exception('Gagal memuat covid');
    }
  }

  
}
