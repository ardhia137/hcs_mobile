import 'package:flutter/material.dart';
import 'package:hcs_mobile/utils/theme.dart';
import 'package:hcs_mobile/utils/url.dart';
import 'package:intl/intl.dart';

class ProdukWidget extends StatelessWidget {
  final String img;
  final String nama;
  final int harga;
  const ProdukWidget({Key? key,required this.img,required this.nama,required this.harga}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final numberFormat = new NumberFormat("#,##0", "en_US");
     final double shortestside = MediaQuery.of(context).size.shortestSide;
    final bool phonelayout = shortestside < 600;
    return Container(
      width: phonelayout == true ? 200 : 250,
      decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 0,
              blurRadius: 7,
              offset: Offset(0, 1),
            ),
          ]),
      child: Column(
        children: [
          ClipRRect(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10)),
              child: Image.network('${baseurl()}/img/${img}',scale: 1.0,fit: BoxFit.cover,)),
          Container(
            margin: EdgeInsets.only(top: 5,left: 5, right: 5),
            child: Text('${nama}',overflow: TextOverflow.ellipsis,
            maxLines: 2,
            style: secondaryTextstyle.copyWith(
              fontSize: phonelayout == true ? 13 : 17,
              fontWeight: medium
            ),
            textAlign: TextAlign.center,
            ),
          ), Container(
            margin: EdgeInsets.only(top:3,left: 5, right: 5),
            child: Text('Rp. ${numberFormat.format(harga)}',style: secondaryTextstyle.copyWith(
              fontSize: phonelayout == true ? 16 : 20,
              fontWeight: semibold
            ),
            textAlign: TextAlign.center,
            ),
          ), Container(
            margin: EdgeInsets.only(top: 5,left: 5, right: 5),
            child: Text('Terjual 4',style: secondaryTextstyle.copyWith(
              fontSize: phonelayout == true ? 12 : 16,
            ),
            textAlign: TextAlign.center,
            ),
          ),
          
        ],
      ),
    );
  }
}
