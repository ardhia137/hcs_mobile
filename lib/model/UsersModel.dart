import 'dart:ffi';

import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  const UserModel(this.id,this.email,this.no_tlp,this.nama,this.password,this.otp);
  final int id;
  final String email;
  final String no_tlp;
  final String nama;
  final String password;
  final int otp;

  @override
  List<Object> get props => [id,email,no_tlp,nama,password,otp];

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      json['id'],
      json['email'],
      json['no_tlp'],
      json['nama'],
      json['password'],
      json['otp'],
      );
  }
}