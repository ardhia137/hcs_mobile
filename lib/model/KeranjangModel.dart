import 'dart:ffi';

import 'package:equatable/equatable.dart';

class KeranjangModel extends Equatable {
  const KeranjangModel(this.id,this.nama,this.id_produk, this.harga,this.stok,this.id_users,this.gambar,this.jumlah);
  final int id;
  final int id_produk;
  final String nama;
  final int harga; 
  final int stok; 
  final String gambar; 
  final int id_users; 
  final int jumlah;  

  @override
  List<Object> get props => [id,nama,id_produk,harga,stok,id_users,gambar,jumlah];

  factory KeranjangModel.fromJson(Map<String, dynamic> json) {
    return KeranjangModel(
      json['id'],
      json['nama'],
      json['id_produk'],
      json['harga'],
      json['stok'],
      json['id_users'],
      json['gambar'],
      json['jumlah'],
     
      );
  }
}