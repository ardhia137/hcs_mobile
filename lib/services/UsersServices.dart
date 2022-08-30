import 'dart:convert';

import 'package:hcs_mobile/model/KeranjangModel.dart';
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
      throw Exception('Gagal login');
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
      throw Exception('Gagal register');
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
      throw Exception('Gagal register');
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
      throw Exception('Gagal register');
    }
  }

  Future<bool> add_keranjang({
    String? email,
    int? id_produk,
    int? jumlah,
  }) async {
    var url = '${baseurl()}/api/keranjang';
    var headers = {'Content-Type': 'application/json; charset=utf-8'};
    var body = jsonEncode({
      'email': email,
      'id_produk': id_produk,
      'jumlah': jumlah,
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
      throw Exception('Gagal memasukan keranjang');
    }
  }
  Future<List<KeranjangModel>> get_keranjang({
    String? email,
  }) async {
    var url = '${baseurl()}/api/get_keranjang';
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
       List data = jsonDecode(response.body)['data'];
      List<KeranjangModel> keranjang = [];
      for (var item in data) {
        keranjang.add(KeranjangModel.fromJson(item));
      }
      print(keranjang.length);
      return keranjang;
    } else {
      throw Exception('Gagal memuat keranjang');
    }
  }
  Future<bool> update_keranjang({
    int? id_keranjang,
    int? jumlah,
  }) async {
    var url = '${baseurl()}/api/update_keranjang';
    var headers = {'Content-Type': 'application/json; charset=utf-8'};
    var body = jsonEncode({
      'id_keranjang': id_keranjang,
      'jumlah': jumlah,
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
      throw Exception('Gagal update keranjang');
    }
  } 
  
  Future<bool> delete_keranjang({
    int? id_keranjang,
  }) async {
    var url = '${baseurl()}/api/delete_keranjang/${id_keranjang}';
    var headers = {'Content-Type': 'application/json; charset=utf-8'};
    // var body = jsonEncode({
    //   'id_keranjang': id_keranjang,
    //   'jumlah': jumlah,
    // });

    var response = await http.delete(
      Uri.parse(url),
      headers: headers,
      // body: body,
    );
    print(url);
    print(response.statusCode);
    // print(response.body);

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Gagal hapus keranjang');
    }
  }
}
