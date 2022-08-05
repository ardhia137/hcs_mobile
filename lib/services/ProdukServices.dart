import 'dart:convert';

import 'package:hcs_mobile/model/PordukModel.dart';
import 'package:hcs_mobile/utils/url.dart';
import 'package:http/http.dart' as http;

class ProdukServices {
  // String baseUrl = 'http://169.254.74.27:3000';
  Future<List<ProdukModel>> get_produk(int limit) async {
    var url = '${baseurl()}/api/produk/${limit}';
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
      List data = jsonDecode(response.body)['data'];
      List<ProdukModel> products = [];
      for (var item in data) {
        products.add(ProdukModel.fromJson(item));
      }
      print(products.length);
      return products;
      // var data = jsonDecode(response.body);
      // print(data['data']);
      
      // ProdukModel produk = ProdukModel.fromJson(data['data']);
      // return produk;
    } else {
      throw Exception('Gagal memuat produk');
    }
  }

  
}
