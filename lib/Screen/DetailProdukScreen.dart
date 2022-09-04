

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hcs_mobile/Widget/ButtonWidget.dart';
import 'package:hcs_mobile/Widget/ProdukWidget.dart';
import 'package:hcs_mobile/cubit/keranjang_cubit_cubit.dart';
import 'package:hcs_mobile/cubit/produk_cubit_cubit.dart';
import 'package:hcs_mobile/model/PordukModel.dart';
import 'package:hcs_mobile/utils/theme.dart';
import 'package:hcs_mobile/utils/url.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetailProdukScreen extends StatefulWidget {
  final int id;
  final int id_kategori;
  final String judul;
  final String img;
  final String kategori;
  final String deskripsi;
  final int harga;
  DetailProdukScreen({
    Key? key,
    required this.id,
    required this.id_kategori,
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
  cek() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // return email = (prefs.getString('email'))!;
    setState(() {
      email = (prefs.getString('email'));
    });
  }

  @override
  void initState() {
    super.initState();
    cek();
  }

  @override
  Widget build(BuildContext context) {
    final numberFormat = new NumberFormat("#,##0", "en_US");
    final double shortestside = MediaQuery.of(context).size.shortestSide;
    final bool phonelayout = shortestside < 600;
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

    Widget modal_detail() {
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
                    return modal_detail();
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

    Widget modal_keranjang() {
      return Container(
        height: 170,
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () => Navigator.pop(context),
              child: Icon(
                Icons.close,
                size: phonelayout == true ? 30 : 35,
                color: secondaryColor,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 15),
              padding: EdgeInsets.all(5),
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
              child: Row(
                children: [
                  Image.network(
                    '${baseurl()}/img/${widget.img}',
                    width: phonelayout == true ? 80 : 100,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Barang berhasil ditambahkan",
                        style: secondaryTextstyle.copyWith(
                            fontWeight: semibold, fontSize: 16),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.pushNamed(context, '/cart');
                        },
                        child: Container(
                          margin: EdgeInsets.only(top: 10),
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: whiteColor,
                              border: Border.all(color: primaryColor, width: 2)),
                          child: Center(
                            child: Text('Lihat Keranjang',
                                style: primaryTextstyle.copyWith(
                                    fontWeight: semibold, fontSize: 13)),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      );
    }

    Widget bottom() {
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
          child: email != null
              ? Row(
                  children: [
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(
                            right: 7, left: 15, top: 10, bottom: 10),
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
                    BlocConsumer<KeranjangCubitCubit, KeranjangCubitState>(
                      listener: (context, state) {
                        print(state);
                        // TODO: implement listener
                        if (state is KeranjangCubitSuccess) {
                          showModalBottomSheet<void>(
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(5),
                                  topRight: Radius.circular(5)),
                            ),
                            context: context,
                            builder: (BuildContext context) {
                              return modal_keranjang();
                            },
                          );
                        } else if(state is KeranjangCubitGagal){
                          final snackBar = SnackBar(
                            backgroundColor: redColor,
                            behavior: SnackBarBehavior.floating,
                            content: Text(
                              'gagal menambahkan produk',
                              style: whiteTextstyle.copyWith(
                                  fontWeight: medium, fontSize: 13),
                            ),
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                      },
                      builder: (context, state) {
                        return Expanded(
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
                              onpressed: () {
                                print(widget.id);
                                context.read<KeranjangCubitCubit>().add_keranjang(
                                    email: email!,
                                    id_produk: widget.id,
                                    jumlah: 1);
                              
                              },
                            ),
                          ),
                        );
                      },
                    )
                  ],
                )
              : Expanded(
                  child: Container(
                    margin: EdgeInsets.only(
                        right: 7, left: 15, top: 10, bottom: 10),
                    child: ButtonWidget(
                      color: primaryColor,
                      textStyle: whiteTextstyle.copyWith(
                        fontWeight: medium,
                        fontSize: phonelayout == true ? 18 : 22,
                      ),
                      text: "Beli",
                      onpressed: () {},
                      // border: Border.all(color: primaryColor, width: 2),
                    ),
                  ),
                ));
    }

    Widget produk_serupa(List<ProdukModel> produk) {
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
              height: phonelayout == true ? 330 : 430,
              child: BlocBuilder<ProdukCubitCubit, ProdukCubitState>(
                // bloc:
                builder: (context, state) {
                  return ListView.builder(
                    itemCount: produk.length,
                    scrollDirection: Axis.horizontal,
                    // physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                          margin:
                              EdgeInsets.only(right: 10, top: 10, bottom: 10),
                          child: ProdukWidget(
                              img: produk[index].gambar,
                              nama: produk[index].nama,
                              harga: produk[index].harga));
                    },
                  );
                },
              ),
            ),
          ],
        ),
      );
    }




    return BlocBuilder<ProdukCubitCubit, ProdukCubitState>(    
      bloc: BlocProvider.of<ProdukCubitCubit>(context)
        ..get_produk_by_kategori(widget.id_kategori, widget.id, 5),
      builder: (context, state) {
        if (state is ProdukCubitSuccess) {
          // print(state);
          return WillPopScope(
            onWillPop: () {
              Navigator.pushReplacementNamed(context, '/');
              return Future.value(false);
            },
            child: Scaffold(
              backgroundColor: whiteColor,
              appBar: AppBar(
                backgroundColor: whiteColor,
                automaticallyImplyLeading: false,
                title: Row(
                  children: [
                    InkWell(
                      onTap:()=> Navigator.pushReplacementNamed(context, '/'),
                      // onTap: () => Navigator.pop(context, {
                      //   // context.read<ProdukCubitCubit>().get_produk(11),
                      // }),
                      child: Icon(
                        Icons.arrow_back_ios,
                        color: secondaryColor,
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: ()=>Navigator.pushNamed(context, '/search'),
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
                      Navigator.pushNamed(context, '/cart');
                    },
                  ),
                ],
                // title:
              ),
              body: SingleChildScrollView(
                physics: ScrollPhysics(),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      produk(),
                      pembatas(7),
                      detail(),
                      pembatas(7),
                      state.produk.isNotEmpty
                          ? produk_serupa(state.produk)
                          : const SizedBox()
                    ]),
              ),
              bottomNavigationBar: bottom(),
            ),
          );
        }
        return Scaffold(
          body: Center(
            child: CircularProgressIndicator(
              color: primaryColor,
            ),
          ),
        );
      },
    );
  }
}
