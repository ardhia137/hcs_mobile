import 'package:hcs_mobile/Screen/DetailProdukScreen.dart';
import 'package:hcs_mobile/cubit/produk_cubit_cubit.dart';
import 'package:hcs_mobile/model/CovidModel.dart';
import 'package:hcs_mobile/model/PordukModel.dart';
import 'package:hcs_mobile/utils/url.dart';
import 'package:intl/intl.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hcs_mobile/Widget/ClipPathWidget.dart';
import 'package:hcs_mobile/Widget/ProdukWidget.dart';
import 'package:hcs_mobile/cubit/auth_cubit_cubit.dart';
import 'package:hcs_mobile/cubit/covid_cubit_cubit.dart';

import 'package:hcs_mobile/utils/theme.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late AnimationController _ColorAnimationController;
  late AnimationController _TextAnimationController;
  late Animation _colorTween, _iconColorTween, _elevation;
  late Animation<Offset> _transTween;
  final List<String> images = [
    'assets/iklan1.png',
    'assets/iklan2.png',
  ];

  @override
  void initState() {
    _ColorAnimationController =
        AnimationController(vsync: this, duration: Duration(seconds: 0));
    _colorTween = ColorTween(begin: Colors.transparent, end: whiteColor)
        .animate(_ColorAnimationController);
    _iconColorTween = ColorTween(begin: whiteColor, end: secondaryColor)
        .animate(_ColorAnimationController);
    _elevation = IntTween(begin: 0, end: 1).animate(_ColorAnimationController);

    _TextAnimationController =
        AnimationController(vsync: this, duration: Duration(seconds: 0));

    _transTween = Tween(begin: Offset(-10, 40), end: Offset(-10, 0))
        .animate(_TextAnimationController);

     
    super.initState();
 context.read<CovidCubitCubit>().get_covid();
    context.read<ProdukCubitCubit>().get_produk(11);
    // print('objectdassds');
  }




  bool _scrollListener(ScrollNotification scrollInfo) {
    if (scrollInfo.metrics.axis == Axis.vertical) {
      _ColorAnimationController.animateTo(scrollInfo.metrics.pixels / 50);

      _TextAnimationController.animateTo((scrollInfo.metrics.pixels - 50) / 20);
      return true;
    }
    return false;
  }
 GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final double shortestside = MediaQuery.of(context).size.shortestSide;
    final bool phonelayout = shortestside < 600;
   
    final numberFormat = new NumberFormat("#,##0", "en_US");
    Widget headeriklan() {
      return Stack(
        children: [
          Container(height: 170, child: ClipPathWidget(color: primaryColor)),
          Container(
            margin: EdgeInsets.only(top: 85, left: 15),
            child: Row(
              children: [
                Icon(
                  Icons.location_on_outlined,
                  color: whiteColor,
                  size: phonelayout == true ? 20 : 20,
                ),
                Text(
                  'Dikirim ke ',
                  style:
                      whiteTextstyle.copyWith(fontWeight: medium, fontSize: phonelayout == true ? 14 : 20),
                ),
                Text(
                  'Jakarta Pusat ',
                  style: whiteTextstyle.copyWith(
                      fontWeight: semibold, fontSize: phonelayout == true ? 14 : 20),
                ),
                Icon(
                  Icons.keyboard_arrow_down_outlined,
                  color: whiteColor,
                  size: 20,
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              top: phonelayout == true ? 88 : 68,
            ),
            child: CarouselSlider(
              options: CarouselOptions(
                aspectRatio: 2.0,
                enlargeCenterPage: true,
                enableInfiniteScroll: false,
                viewportFraction: 0.95,
                initialPage: 0,
                autoPlay: true,
              ),
              items: images
                  .map((item) => Center(
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.asset(
                              item,
                              fit: BoxFit.fill,
                              // height: 0,
                            )),
                      ))
                  .toList(),
            ),
            // width: 250,
          ),
        ],
      );
    }

    Widget appbar() {
      return Container(
        height: 80,
        child: AnimatedBuilder(
          animation: _ColorAnimationController,
          builder: (context, child) => AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: _colorTween.value,
            elevation: _elevation.value.toDouble(),
            titleSpacing: 0.0,
            title: Container(
              margin: EdgeInsets.only(left: 15),
              height: 35,
              decoration: BoxDecoration(
                  color: whiteColor,
                  border: Border.all(color: secondaryColor2),
                  borderRadius: BorderRadius.circular(7)),
              child: InkWell(
                onTap: () => Navigator.pushNamed(context, '/search'),
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
            iconTheme: IconThemeData(
              color: _iconColorTween.value,
            ),
            actions: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.mail_outline,
                ),
                onPressed: () {
//                          Navigator.of(context).push(TutorialOverlay());
                },
              ),
              IconButton(
                icon: Icon(
                  Icons.notifications_none,
                ),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(
                  Icons.local_grocery_store_outlined,
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/cart');
//                          Navigator.of(context).push(TutorialOverlay());
                },
              ),
            ],
          ),
        ),
      );
    }

    Widget datacvd(positif, dirawat, sembuh, meninggal) {
      return Container(
        width: double.infinity,
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Data Covid',
              style:
                  secondaryTextstyle.copyWith(fontWeight: medium, fontSize: phonelayout == true ? 18 : 23),
            ),
            Container(
              height: phonelayout == true ? 125 : 180,
              margin: EdgeInsets.only(top: 15),
              padding: EdgeInsets.symmetric(horizontal: 10),
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
              child: Stack(
                children: [
                  Center(
                    child: Container(
                      margin: EdgeInsets.symmetric(
                        vertical: 10,
                      ),
                      height: phonelayout == true ? 125 : 180,
                      child: VerticalDivider(
                        color: secondaryColor,
                        thickness: 1,
                      ),
                    ),
                  ),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          // color: Colors.red,
                          margin: EdgeInsets.only(bottom: 10),

                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                children: [
                                  Text(
                                    'Terkonfirmasi',
                                    style: secondaryTextstyle.copyWith(
                                        fontSize: phonelayout == true ? 15 : 21, fontWeight: medium),
                                  ),
                                  Text(
                                    '${positif}',
                                    style: TextStyle(
                                        color: Color(0xffF2C94C),
                                        fontWeight: semibold,
                                        fontSize: phonelayout == true ? 18 : 23),
                                  )
                                ],
                              ),
                              // SizedBox(
                              //   height: 60,
                              //   child: VerticalDivider(
                              //     color: secondaryColor,
                              //     thickness: 1,
                              //   ),
                              // ),
                              Column(
                                children: [
                                  Text(
                                    'Sembuh',
                                    style: secondaryTextstyle.copyWith(
                                        fontSize: phonelayout == true ? 15 : 21, fontWeight: medium),
                                  ),
                                  Text(
                                    '${sembuh}',
                                    style: TextStyle(
                                        color: Color(0xff219653),
                                        fontWeight: semibold,
                                        fontSize: phonelayout == true ? 18 : 23,),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                        Container(
                          height: 0,
                          child: SizedBox(
                            width: double.infinity,
                            child: Divider(
                              color: secondaryColor,
                              thickness: 1,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                children: [
                                  Text(
                                    'Perawatan',
                                    style: secondaryTextstyle.copyWith(
                                        fontSize: phonelayout == true ? 15 : 21, fontWeight: medium),
                                  ),
                                  Text(
                                    '${dirawat}',
                                    style: TextStyle(
                                        color: Color(0xffF5A623),
                                        fontWeight: semibold,
                                        fontSize: phonelayout == true ? 18 : 23,),
                                  )
                                ],
                              ),
                              // SizedBox(
                              //   height: 50,
                              //   child: VerticalDivider(
                              //   color: secondaryColor,
                              //   thickness: 1,
                              // ),
                              // ),
                              Column(
                                children: [
                                  Text(
                                    'Meninggal',
                                    style: secondaryTextstyle.copyWith(
                                        fontSize: phonelayout == true ? 15 : 21, fontWeight: medium),
                                  ),
                                  Text(
                                    '${meninggal}',
                                    style: TextStyle(
                                        color: Color(0xffD8232A),
                                        fontWeight: semibold,
                                        fontSize: phonelayout == true ? 18 : 23),
                                  )
                                ],
                              )
                            ],
                          ),
                        )
                      ]),
                ],
              ),
            )
          ],
        ),
      );
    }

    Widget pembatas() {
      return Container(
        height: 15,
        color: Color(0xffF4F5F5),
        width: double.infinity,
      );
    }

    Widget produk(List<ProdukModel> produk) {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 15),
        child: GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              // maxCrossAxisExtent: 200,
              childAspectRatio: phonelayout == true ? 2/3.25 : 2/2.40,
              crossAxisSpacing: 15,
              mainAxisSpacing: 15),
          itemBuilder: (_, index){
            print(produk[index].nama);
            return InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: ((context) => DetailProdukScreen(
                  id: produk[index].id,
                  id_kategori: produk[index].id_kategori,
                  img: produk[index].gambar,
                  judul: produk[index].nama,
                  harga: produk[index].harga,
                  deskripsi: produk[index].deskripsi,
                  kategori: produk[index].kategori,
                  ))));
              },
              child:Padding(
                padding: EdgeInsets.all(2),
                child: ProdukWidget(img: produk[index].gambar,nama: produk[index].nama,harga: produk[index].harga,),
              )
            );
          }  ,
          itemCount: produk.length,
        ),
      );
    }

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: whiteColor,
      body: NotificationListener<ScrollNotification>(
          onNotification: _scrollListener,
          child: BlocBuilder<CovidCubitCubit, CovidCubitState>(         
            builder: (context, covidstate) {
              return BlocBuilder<ProdukCubitCubit, ProdukCubitState>(
                // bloc: BlocProvider.of<ProdukCubitCubit>(context)..get_produk(11),
                builder: (context, produkstate) {
                  if (covidstate is CovidCubitSuccess &&
                      produkstate is ProdukCubitSuccess) {
                    var data_covid = covidstate.covid;
                    var data_produk = produkstate.produk;
                    return Container(
                      height: double.infinity,
                      child: Stack(
                        children: <Widget>[
                          SingleChildScrollView(
                            child: Column(
                              children: <Widget>[
                                headeriklan(),
                                pembatas(),
                                datacvd(
                                    numberFormat.format(data_covid.positif),
                                    numberFormat.format(data_covid.dirawat),
                                    numberFormat.format(data_covid.sembuh),
                                    numberFormat.format(data_covid.meninggal)),
                                pembatas(),
                                produk(data_produk)
                              ],
                            ),
                          ),
                          appbar()
                        ],
                      ),
                    );
                  }
                  return  Center(
                    child: CircularProgressIndicator(color: primaryColor),
                  );
                },
              );
             
            },
          )),
    );
  }
}
