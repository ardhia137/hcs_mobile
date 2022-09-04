import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hcs_mobile/Widget/ProdukWidget.dart';
import 'package:hcs_mobile/cubit/produk_cubit_cubit.dart';
import 'package:hcs_mobile/model/PordukModel.dart';
import 'package:hcs_mobile/utils/theme.dart';

class SearchProdukScreen extends StatefulWidget {
  final String search;
  const SearchProdukScreen({required this.search, Key? key}) : super(key: key);

  @override
  State<SearchProdukScreen> createState() => _SearchProdukScreenState();
}

class _SearchProdukScreenState extends State<SearchProdukScreen> {
  @override
  void initState() {
    context.read<ProdukCubitCubit>().get_produk_search(widget.search);
  }

  @override
  Widget build(BuildContext context) {
    // print(widget.search);
    Widget alamat() {
      return Container(
        margin: EdgeInsets.only(top: 20, bottom: 15),
        child: Row(
          children: [
            Icon(
              Icons.location_on_outlined,
              color: secondaryColor,
              size: 20,
            ),
            Text(
              'Dikirim ke ',
              style:
                  secondaryTextstyle.copyWith(fontWeight: medium, fontSize: 14),
            ),
            Text(
              'Jakarta Pusat ',
              style: secondaryTextstyle.copyWith(
                  fontWeight: semibold, fontSize: 14),
            ),
            Icon(
              Icons.keyboard_arrow_down_outlined,
              color: secondaryColor,
              size: 20,
            ),
          ],
        ),
      );
    }

    Widget pencarian(int jumlah) {
      return Container(
        child: Expanded(
          child: Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    Text(
                      'Pencarian : ',
                      style: secondaryTextstyle.copyWith(
                          fontWeight: medium, fontSize: 15),
                    ),
                    Expanded(
                      child: Text(
                        '${widget.search}',
                        style: primaryTextstyle.copyWith(
                            fontWeight: semibold, fontSize: 14),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    )
                  ],
                ),
              ),
              Text(
                'Jumlah : ${jumlah} Produk',
                style: secondaryTextstyle.copyWith(
                    fontWeight: medium, fontSize: 15),
              ),
            ],
          ),
        ),
      );
    }

    {
      Widget produk(List<ProdukModel> produk) {
        return produk.length > 0 ? Container(
          margin: const EdgeInsets.symmetric(vertical: 15),
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                // maxCrossAxisExtent: 200,
                childAspectRatio: 2 / 3.25,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15),
            itemCount: produk.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.all(5.0),
                child: ProdukWidget(
                    img: produk[index].gambar,
                    nama:
                        '${produk[index].nama}',
                    harga: produk[index].harga),
              );
            },
          ),
        ) : Container(
          margin: EdgeInsets.only(top: 30),
          child: Center(
            child: Text('Oopss Pencarianmu Tidak Ditemukan'),
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
                onTap: () => Navigator.pushReplacementNamed(context, '/'),
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
        body: WillPopScope(
            onWillPop: () {
              Navigator.pushReplacementNamed(context, '/');
              return Future.value(false);
            },
          child: BlocBuilder<ProdukCubitCubit, ProdukCubitState>(
            builder: (context, state) {
             if (state is ProdukCubitSuccess) {
               return Container(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: ListView(
                  children: [alamat(), pencarian(state.produk.length), produk(state.produk)],
                ),
              );
             }
             return Center(
              child: CircularProgressIndicator(color: primaryColor,),
             );
            },
          ),
        ),
      );
    }
  }
}
