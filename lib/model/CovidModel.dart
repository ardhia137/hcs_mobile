import 'dart:ffi';

import 'package:equatable/equatable.dart';

class CovidModel extends Equatable {
  const CovidModel(this.positif,this.dirawat,this.sembuh,this.meninggal);
  final int positif;
  final int dirawat;
  final int sembuh;
  final int meninggal; 

  @override
  List<Object> get props => [positif,dirawat,sembuh,meninggal];

  factory CovidModel.fromJson(Map<String, dynamic> json) {
    return CovidModel(
      json['positif'],
      json['dirawat'],
      json['sembuh'],
      json['meninggal'],
     
      );
  }
}