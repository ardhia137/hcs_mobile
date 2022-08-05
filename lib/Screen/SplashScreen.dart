import 'package:flutter/material.dart';
import 'package:hcs_mobile/utils/theme.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: Container(
        child: Center(
          child: Image.asset('assets/logo_hcs.png',width: 151,),
        ),
      )
    );
  }
}