import 'dart:io';
// import 'dart:convert';
// import 'dart:_http';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hcs_mobile/Screen/CartScreen.dart';
import 'package:hcs_mobile/Screen/CompleteRegisterScreen.dart';
import 'package:hcs_mobile/Screen/DetailProdukScreen.dart';
import 'package:hcs_mobile/Screen/SearchScreen.dart';
import 'package:hcs_mobile/Screen/home/HomeScreen.dart';
import 'package:hcs_mobile/Screen/LoginScreen.dart';
import 'package:hcs_mobile/Screen/RegisterScreen.dart';
import 'package:hcs_mobile/Screen/SelectMethodScreen.dart';
import 'package:hcs_mobile/Screen/SplashScreen.dart';
import 'package:hcs_mobile/Screen/VerificationScreen.dart';
import 'package:hcs_mobile/Screen/home/MainScreen.dart';
import 'package:hcs_mobile/cubit/auth_cubit_cubit.dart';
import 'package:hcs_mobile/cubit/change_page_cubit_cubit.dart';
import 'package:hcs_mobile/cubit/covid_cubit_cubit.dart';
import 'package:hcs_mobile/cubit/kategori_cubit_cubit.dart';
import 'package:hcs_mobile/cubit/keranjang_cubit_cubit.dart';
import 'package:hcs_mobile/cubit/produk_cubit_cubit.dart';
import 'package:hcs_mobile/cubit/register_cubit_cubit.dart';
import 'package:hcs_mobile/cubit/search_cubit_cubit.dart';
import 'package:hcs_mobile/cubit/select_produk_cubit_cubit.dart';

 class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}
void main() {

  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
   const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthCubitCubit(),
          
        ),
        BlocProvider(
          create: (context) => RegisterCubitCubit(),
          
        ),
         BlocProvider(
          create: (context) => RequestOtpCubitCubit(),
          
        ), BlocProvider(
          create: (context) => CompleteAuthCubitCubit(),
          
        ), BlocProvider(
          create: (context) => CovidCubitCubit(),
          
        ),BlocProvider(
          create: (context) => ProdukCubitCubit(),
          
        ),BlocProvider(
          create: (context) => ChangePageCubit(),
          
        ),BlocProvider(
          create: (context) => KeranjangCubitCubit(),
          
        ),BlocProvider(
          create: (context) => TotalProductCubit(),
          
        ),BlocProvider(
          create: (context) => SearchCubitCubit(),
          
        ),BlocProvider(
          create: (context) => KategoriCubitCubit(),
          
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        builder: (context, child) {
          return MediaQuery(
            child: child!,
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
          );
        },
        routes: {
          // '/': (context) => LoginScreen(),
          '/': (context) => MainScreen(),
          '/verification': (context) => VerificationScreen(),
          '/cart': (context) => CartScreen(),
          '/register': (context) => RegisterScreen(),
          '/login': (context) => LoginScreen(),
          '/search': (context) => SearchScreen()
          },
      ),
    );
  }
}
