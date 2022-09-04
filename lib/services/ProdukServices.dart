import 'dart:convert';

import 'package:hcs_mobile/model/PordukModel.dart';
import 'package:hcs_mobile/utils/url.dart';
import 'package:http/http.dart' as http;

class ProdukServices {
  Future<List<ProdukModel>> get_produk(int limit) async {
    var url = '${baseurl()}/api/produk/${limit}';
    var headers = {'Content-Type': 'application/json; charset=utf-8'};
    var response = await http.get(
      Uri.parse(url),
      headers: headers,
    );
    print(url);
    print(response.statusCode);
    if (response.statusCode == 200) {
      List data = jsonDecode(response.body)['data'];
      List<ProdukModel> products = [];
      for (var item in data) {
        products.add(ProdukModel.fromJson(item));
      }
      print(products.length);
      return products;
    } else {
      throw Exception('Gagal memuat produk');
    }
  } 
  Future<List<ProdukModel>> get_produk_by_kategori(int id_kategori, int id_produk, int limit) async {
    var url = '${baseurl()}/api/produk/${id_kategori}/${id_produk}/${limit}';
    var headers = {'Content-Type': 'application/json; charset=utf-8'};
    var response = await http.get(
      Uri.parse(url),
      headers: headers,
    );
    print(url);
    print(response.statusCode);
    if (response.statusCode == 200) {
      List data = jsonDecode(response.body)['data'];
      List<ProdukModel> products = [];
      for (var item in data) {
        products.add(ProdukModel.fromJson(item));
      }
      print(products.length);
      return products;
    } else {
      throw Exception('Gagal memuat produk');
    }
  } 
 Future<List<ProdukModel>> get_produk_search(String search) async {
    var url = '${baseurl()}/api/produk/search/${search}';
    var headers = {'Content-Type': 'application/json; charset=utf-8'};
    var response = await http.get(
      Uri.parse(url),
      headers: headers,
    );
    print(url);
    print(response.statusCode);
    if (response.statusCode == 200) {
      List data = jsonDecode(response.body)['data'];
      List<ProdukModel> products = [];
      for (var item in data) {
        products.add(ProdukModel.fromJson(item));
      }
      print(products.length);
      return products;
    } else {
      throw Exception('Gagal memuat produk');
    }
  }

  
}
