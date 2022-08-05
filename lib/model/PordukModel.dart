import 'dart:ffi';

import 'package:equatable/equatable.dart';

class ProdukModel extends Equatable {
  const ProdukModel(this.id,this.nama,this.id_kategori,this.harga,this.stok,this.deskripsi,this.gambar,this.kategori);
  final int id;
  final String nama;
  final int id_kategori;
  final int harga; 
  final int stok; 
  final String deskripsi; 
  final String gambar; 
  final String kategori; 

  @override
  List<Object> get props => [id,nama,id_kategori,harga,stok,deskripsi,gambar,kategori];

  factory ProdukModel.fromJson(Map<String, dynamic> json) {
    return ProdukModel(
      json['id'],
      json['nama'],
      json['id_kategori'],
      json['harga'],
      json['stok'],
      json['deskripsi'],
      json['gambar'],
      json['kategori'],
     
      );
  }
}