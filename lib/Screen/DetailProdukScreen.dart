import 'package:flutter/material.dart';
import 'package:hcs_mobile/Widget/ButtonWidget.dart';
import 'package:hcs_mobile/Widget/ProdukWidget.dart';
import 'package:hcs_mobile/utils/theme.dart';
import 'package:hcs_mobile/utils/url.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetailProdukScreen extends StatefulWidget {
  final String judul;
  final String img;
  final String kategori;
  final String deskripsi;
  final int harga;
  DetailProdukScreen({
    Key? key,
    required this.judul,
    required this.img,
    required this.kategori,
    required this.deskripsi,
    required this.harga,
  }) : super(key: key);

  @override
  State<DetailProdukScreen> createState() => _DetailProdukScreenState();
}

class _DetailProdukScreenState extends State<DetailProdukScreen> {
  String? email;
  // final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  // Future<String?> cek() async {
  //   final SharedPreferences prefs = await _prefs;
  //   email = await prefs.getString('email');
  //   return email;
  // }
  cek() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      email = (prefs.getString('email'));
    });
  }

  void initState() {
    super.initState();
    cek();
  }

  @override
  Widget build(BuildContext context) {
    final numberFormat = new NumberFormat("#,##0", "en_US");
    final double shortestside = MediaQuery.of(context).size.shortestSide;
    final bool phonelayout = shortestside < 600;
    // cek().then((value) => email = value!);
    // cek();
    print(email);
    Widget produk() {
      return Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 10),
            child: Image.network(
              '${baseurl()}/img/${widget.img}',
              fit: BoxFit.contain,
              scale: 1,
              width: double.infinity,
              height: phonelayout == true ? 300 : 400,
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 15, right: 15, top: 30, bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Rp. ${numberFormat.format(widget.harga)}',
                      style: secondaryTextstyle.copyWith(
                        fontWeight: semibold,
                        fontSize: phonelayout == true ? 24 : 26,
                      ),
                    ),
                    Image.asset(
                      'assets/icon_whislist.png',
                      width: phonelayout == true ? 25 : 30,
                    )
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(top: 7, bottom: 5),
                  child: Text(
                    widget.judul,
                    style: secondaryTextstyle.copyWith(
                      fontWeight: medium,
                      fontSize: phonelayout == true ? 15 : 19,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 10),
                  child: Text(
                    'Terjual 4',
                    style: secondaryTextstyle.copyWith(
                      fontSize: phonelayout == true ? 15 : 19,
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      );
    }

    Widget pembatas(double size) {
      return Container(
        height: size,
        color: Color(0xffF4F5F5),
        width: double.infinity,
      );
    }

    Widget selengkapnya() {
      return Container(
        padding:
            const EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 30),
        // height: 300,
        decoration: BoxDecoration(
            color: whiteColor, borderRadius: BorderRadius.circular(10)),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                children: [
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    child: Icon(
                      Icons.close,
                      size: phonelayout == true ? 25 : 30,
                      color: secondaryColor,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 10),
                    child: Text(
                      'Detail Produk',
                      style: secondaryTextstyle.copyWith(
                        fontWeight: semibold,
                        fontSize: phonelayout == true ? 15 : 19,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: ListView(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 15),
                    child: Row(
                      children: [
                        Image.network(
                          '${baseurl()}/img/${widget.img}',
                          width: phonelayout == true ? 70 : 90,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Text(
                            widget.judul,
                            style: secondaryTextstyle.copyWith(
                              fontSize: phonelayout == true ? 16 : 18,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "Min. Pemesanan",
                        style: secondaryTextstyle.copyWith(
                          fontWeight: semibold,
                          fontSize: phonelayout == true ? 15 : 19,
                        ),
                      ),
                      SizedBox(
                        width: 23,
                      ),
                      Text(
                        "1 Buah",
                        style: secondaryTextstyle.copyWith(
                          fontWeight: semibold,
                          fontSize: phonelayout == true ? 15 : 19,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  pembatas(2),
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "Kategori",
                        style: secondaryTextstyle.copyWith(
                          fontWeight: semibold,
                          fontSize: phonelayout == true ? 15 : 19,
                        ),
                      ),
                      SizedBox(
                        width: phonelayout == true ? 83 : 94,
                      ),
                      Text(
                        widget.kategori,
                        style: primaryTextstyle.copyWith(
                          fontWeight: semibold,
                          fontSize: phonelayout == true ? 15 : 19,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  pembatas(2),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    widget.deskripsi,
                    style: secondaryTextstyle.copyWith(
                      fontSize: phonelayout == true ? 15 : 19,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    Widget detail() {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              child: Text(
                "Detail Produk",
                style: secondaryTextstyle.copyWith(
                  fontWeight: semibold,
                  fontSize: phonelayout == true ? 20 : 23,
                ),
              ),
            ),
            Row(
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "Min. Pemesanan",
                  style: secondaryTextstyle.copyWith(
                    fontWeight: semibold,
                    fontSize: phonelayout == true ? 15 : 19,
                  ),
                ),
                SizedBox(
                  width: 23,
                ),
                Text(
                  "1 Buah",
                  style: secondaryTextstyle.copyWith(
                    fontWeight: semibold,
                    fontSize: phonelayout == true ? 15 : 19,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            pembatas(2),
            Row(
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "Kategori",
                  style: secondaryTextstyle.copyWith(
                    fontWeight: semibold,
                    fontSize: phonelayout == true ? 15 : 19,
                  ),
                ),
                SizedBox(
                  width: phonelayout == true ? 83 : 94,
                ),
                Text(
                  widget.kategori,
                  style: primaryTextstyle.copyWith(
                    fontWeight: semibold,
                    fontSize: phonelayout == true ? 15 : 19,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            pembatas(2),
            SizedBox(
              height: 10,
            ),
            Text(
              widget.deskripsi,
              style: secondaryTextstyle.copyWith(
                fontSize: phonelayout == true ? 15 : 19,
              ),
              maxLines: 5,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(
              height: 5,
            ),
            InkWell(
              onTap: () {
                showModalBottomSheet<void>(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(5),
                        topRight: Radius.circular(5)),
                  ),
                  context: context,
                  builder: (BuildContext context) {
                    return selengkapnya();
                  },
                );
              },
              child: Text(
                "Baca Selengkapnya",
                style: primaryTextstyle.copyWith(
                  fontWeight: semibold,
                  fontSize: phonelayout == true ? 15 : 19,
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
          ],
        ),
      );
    }

    Widget bottom() {
      print("as ${email}");
      return Container(
        decoration: BoxDecoration(
          color: whiteColor,
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              blurRadius: 5,
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: Container(
                margin:
                    EdgeInsets.only(right: 7, left: 15, top: 10, bottom: 10),
                child: ButtonWidget(
                  color: whiteColor,
                  textStyle: primaryTextstyle.copyWith(
                    fontWeight: medium,
                    fontSize: phonelayout == true ? 18 : 22,
                  ),
                  text: "Beli",
                  onpressed: () {},
                  border: Border.all(color: primaryColor, width: 2),
                ),
              ),
            ),
            email != '' || email == null
                ? Expanded(
                    child: Container(
                      margin: EdgeInsets.only(
                          right: 7, left: 15, top: 10, bottom: 10),
                      child: ButtonWidget(
                        color: primaryColor,
                        textStyle: whiteTextstyle.copyWith(
                          fontWeight: medium,
                          fontSize: phonelayout == true ? 18 : 22,
                        ),
                        text: "+ Keranjang",
                        onpressed: () {},
                        // border: Border.all(color: primaryColor, width: 2),
                      ),
                    ),
                  )
                : SizedBox(),
          ],
        ),
        // child: BottomAppBar(
        //   child: BottomNavigationBar(
        //     backgroundColor: whiteColor,
        //     elevation: 10,
        //     onTap: (value) {
        //       print(value);
        //     },
        //     type: BottomNavigationBarType.fixed,
        //     selectedLabelStyle: TextStyle(fontSize: 0),
        //     unselectedLabelStyle: TextStyle(fontSize: 0),
        //     items: [
        //       BottomNavigationBarItem(
        //         icon: Container(
        //           margin:
        //               EdgeInsets.only(right: 7, left: 15, top: 10, bottom: 10),
        //           child: ButtonWidget(
        //             color: whiteColor,
        //             textStyle: primaryTextstyle.copyWith(
        //                 fontWeight: medium, fontSize: phonelayout == true ? 18 : 22,),
        //             text: "Beli",
        //             onpressed: () {},
        //             border: Border.all(color: primaryColor, width: 2),
        //           ),
        //         ),
        //         label: '',
        //       ),
        //       BottomNavigationBarItem(
        //         icon: Container(
        //           margin:
        //               EdgeInsets.only(right: 15, left: 7, top: 10, bottom: 10),
        //           child: ButtonWidget(
        //             color: primaryColor,
        //             textStyle: whiteTextstyle.copyWith(
        //                 fontWeight: medium, fontSize: phonelayout == true ? 18 : 22,),
        //             text: "+ Keranjang",
        //             onpressed: () {},
        //           ),
        //         ),
        //         label: '',
        //       ),
        //     ],
        //   ),
        // ),
      );
    }

    Widget produk_serupa() {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Produk Serupa",
                    style: secondaryTextstyle.copyWith(
                      fontWeight: semibold,
                      fontSize: phonelayout == true ? 18 : 20,
                    ),
                  ),
                  Text(
                    "Lihat Semua",
                    style: primaryTextstyle.copyWith(
                      fontWeight: medium,
                      fontSize: phonelayout == true ? 18 : 20,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: phonelayout == true ? 300 : 400,
              child: ListView.builder(
                itemCount: 5,
                scrollDirection: Axis.horizontal,
                // physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                      margin: EdgeInsets.only(right: 10, top: 10, bottom: 10),
                      child: ProdukWidget(
                          img: "1659070367047.jpeg",
                          nama: "VITACIMIN TABLET (per Strip)",
                          harga: 2012));
                },
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        backgroundColor: whiteColor,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            InkWell(
              onTap: () => Navigator.pop(context),
              child: Icon(
                Icons.arrow_back_ios,
                color: secondaryColor,
              ),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(left: 5),
                height: 35,
                decoration: BoxDecoration(
                    color: whiteColor,
                    border: Border.all(color: secondaryColor2),
                    borderRadius: BorderRadius.circular(7)),
                child: Container(
                  margin: EdgeInsets.only(left: 10),
                  child: Row(
                    children: [
                      Icon(
                        Icons.search,
                        color: secondaryColor2,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Cari',
                        style: secondaryTextstyle,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.mail_outline,
              color: secondaryColor,
            ),
            onPressed: () {
//                          Navigator.of(context).push(TutorialOverlay());
            },
          ),
          IconButton(
            icon: Icon(
              Icons.notifications_none,
              color: secondaryColor,
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(
              Icons.local_grocery_store_outlined,
              color: secondaryColor,
            ),
            onPressed: () {
//                          Navigator.of(context).push(TutorialOverlay());
            },
          ),
        ],
        // title:
      ),
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          produk(),
          pembatas(7),
          detail(),
          pembatas(7),
          produk_serupa()
        ]),
      ),
      bottomNavigationBar: bottom(),
    );
  }
}
