import 'dart:convert';

import 'package:hcs_mobile/model/UsersModel.dart';
import 'package:hcs_mobile/utils/url.dart';
import 'package:http/http.dart' as http;

class UsersServices {
  // String baseUrl = 'http://192.168.1.11:3000/api';
  Future<UserModel> login({
    String? email,
  }) async {
    var url = '${baseurl()}/api/auth';
    var headers = {'Content-Type': 'application/json; charset=utf-8'};
    var body = jsonEncode({
      'email': email,
    });

    var response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: body,
    );
    print(url);
    print(response.statusCode);
    // print(response.body);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      print(data['data']);
      UserModel user = UserModel.fromJson(data['data']);
      return user;
    } else {
      throw Exception('Gagal Login');
    }
  }

  Future<bool> register({
    String? email,
  }) async {
    var url = '${baseurl()}/api/register';
    var headers = {'Content-Type': 'application/json; charset=utf-8'};
    var body = jsonEncode({
      'email': email,
    });

    var response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: body,
    );
    print(url);
    print(response.statusCode);
    // print(response.body);
    var data = jsonDecode(response.body);

    if (data['status'] == 200) {
      return true;
    } else {
      // return false;
      throw Exception(data['message']);
    }
  }

  Future<UserModel> request_otp({
    String? email,
  }) async {
    var url = '${baseurl()}/api/request_otp';
    var headers = {'Content-Type': 'application/json; charset=utf-8'};
    var body = jsonEncode({
      'email': email,
    });

    var response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: body,
    );
    print(url);
    print(response.statusCode);
    // print(response.body);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      print(data['data']);
      UserModel user = UserModel.fromJson(data['data']);
      return user;
    } else {
      throw Exception('Gagal Login');
    }
  } 
Future<bool> complete_auth({
    String? email,
    String? nama,
    String? password,
  }) async {
    var url = '${baseurl()}/api/complete_auth';
    var headers = {'Content-Type': 'application/json; charset=utf-8'};
    var body = jsonEncode({
      'email': email,
      'nama': nama,
      'password': password,
    });

    var response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: body,
    );
    print(url);
    print(response.statusCode);
    // print(response.body);

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Gagal Login');
    }
  }
}
