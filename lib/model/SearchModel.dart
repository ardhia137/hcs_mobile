import 'dart:ffi';

import 'package:equatable/equatable.dart';

class SearchModel extends Equatable {
  const SearchModel(this.id,this.search,this.tanggal);
  final int id;
  final String search;
  final String tanggal; 

  @override
  List<Object> get props => [id,search,tanggal];

  factory SearchModel.fromJson(Map<String, dynamic> json) {
    return SearchModel(
      json['id'],
      json['search'],
      json['tanggal'],
     
      );
  }
}