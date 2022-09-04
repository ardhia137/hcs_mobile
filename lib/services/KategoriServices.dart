import 'package:hcs_mobile/model/KategoriModel.dart';
import 'package:hcs_mobile/utils/url.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class KategoriServices{
  Future<List<KategoriModel>> get_kategori() async {
   var url = '${baseurl()}/api/kategori';
    var headers = {'Content-Type': 'application/json; charset=utf-8'};
    var response = await http.get(
      Uri.parse(url),
      headers: headers,
    );
    print(url);
    print(response.statusCode);
    if (response.statusCode == 200) {
      List data = jsonDecode(response.body)['data'];
      List<KategoriModel> products = [];
      for (var item in data) {
        products.add(KategoriModel.fromJson(item));
      }
      print(products.length);
      return products;
    } else {
      throw Exception('Gagal memuat kategori');
    }
  } 
 
}