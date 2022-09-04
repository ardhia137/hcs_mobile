import 'dart:ffi';

import 'package:equatable/equatable.dart';

class KategoriModel extends Equatable {
  const KategoriModel(this.id,this.nama);
  final int id;
  final String nama;

  @override
  List<Object> get props => [id,nama,];

  factory KategoriModel.fromJson(Map<String, dynamic> json) {
    return KategoriModel(
      json['id'],
      json['nama'],
      );
  }
}