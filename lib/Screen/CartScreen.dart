import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hcs_mobile/Widget/ButtonWidget.dart';
import 'package:hcs_mobile/cubit/counter_cubit_cubit.dart';
import 'package:hcs_mobile/cubit/keranjang_cubit_cubit.dart';
import 'package:hcs_mobile/cubit/produk_cubit_cubit.dart';
import 'package:hcs_mobile/cubit/select_produk_cubit_cubit.dart';
import 'package:hcs_mobile/model/KeranjangModel.dart';

import 'package:hcs_mobile/utils/theme.dart';
import 'package:hcs_mobile/utils/url.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartScreen extends StatefulWidget {
  CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  // bool isChecked = false;
  // bool produkIsChecked = false;
  int? total = 0;
  // String? number = "";
  String? email;

  cek() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      email = (prefs.getString('email'));
    });
    return email = (prefs.getString('email'));
  }

  @override
  void initState() {
    context.read<TotalProductCubit>().checked(0);
    KeranjangCubitCubit keranjang = KeranjangCubitCubit();
    super.initState();
    cek().then((value) =>
        context.read<KeranjangCubitCubit>().get_keranjang(email: email!));
    // keranjang.get_keranjang(email: email!));
  }

  @override
  Widget build(BuildContext context) {
    var numberFormat = new NumberFormat("#,##0", "en_US");
    Widget appbar() {
      return AppBar(
        bottom: PreferredSize(
          child: Container(
              alignment: Alignment.topLeft,
              child: Row(
                children: [
                  Checkbox(
                    checkColor: Colors.white,
                    fillColor:
                        MaterialStateProperty.resolveWith<Color>((states) {
                      return secondaryColor;
                      // return isChecked == true ? primaryColor : secondaryColor;
                    }),
                    value: false,
                    onChanged: (bool? value) {
                      setState(() {
                        // isChecked = value!;
                      });
                    },
                  ),
                  Text('Pilih Semua', style: secondaryTextstyle)
                ],
              )),
          preferredSize: Size.fromHeight(9),
        ),
        backgroundColor: whiteColor,
        automaticallyImplyLeading: false,
        //  leading: Icon(
        //    Icons.arrow_back_ios,
        //    color: secondaryColor,
        //  ),
        actions: [
          Container(
              margin: EdgeInsets.only(right: 15),
              child: Image.asset(
                'assets/icon_whislist.png',
                width: 25,
              ))
        ],
        titleSpacing: 0,
        title: Container(
          margin: EdgeInsets.only(left: 15),
          child: Row(
            children: [
              InkWell(
                onTap: () => Navigator.pop(context),
                child: Icon(
                  Icons.arrow_back_ios,
                  color: secondaryColor,
                ),
              ),
              SizedBox(
                width: 7,
              ),
              Text(
                'Keranjang',
                style: secondaryTextstyle.copyWith(
                    fontWeight: medium, fontSize: 20),
              ),
            ],
          ),
        ),
      );
    }

    Widget pembatas(double size) {
      return Container(
        height: size,
        color: Color(0xffF4F5F5),
        width: double.infinity,
      );
    }

    Widget alamat() {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 13, vertical: 15),
        child: Row(
          children: [
            Icon(
              Icons.location_on,
              color: secondaryColor,
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              "Dikirim ke ",
              style:
                  secondaryTextstyle.copyWith(fontWeight: medium, fontSize: 12),
            ),
            Text(
              "Jakarta Pusat",
              style: secondaryTextstyle.copyWith(
                  fontWeight: semibold, fontSize: 12),
            ),
            SizedBox(
              width: 5,
            ),
            Icon(
              Icons.keyboard_arrow_down,
              color: secondaryColor,
            )
          ],
        ),
      );
    }

    Widget produk(int id, String nama, String gambar, int jumlah, int harga) {
      TextEditingController input =
          TextEditingController(text: jumlah.toString());
      CounterCubitCubit counter =
          CounterCubitCubit(init: int.parse(input.text));
      SelectProductCubit selectProduk = SelectProductCubit();
      // TotalProductCubit totalProduk = TotalProductCubit();
      KeranjangCubitCubit keranjang = KeranjangCubitCubit();
      bool? isSelect;

      return Column(
        children: [
          pembatas(7),
          Container(
            padding: EdgeInsets.symmetric(vertical: 15),
            child: Row(
              children: [
                BlocBuilder<SelectProductCubit, bool>(
                  bloc: selectProduk,
                  builder: (context, state) {
                    print(state);
                    return Checkbox(
                      checkColor: Colors.white,
                      fillColor:
                          MaterialStateProperty.resolveWith<Color>((states) {
                        // return primaryColor;
                        return state == true ? primaryColor : secondaryColor;
                      }),
                      value: state,
                      onChanged: (bool? value) {
                        selectProduk.checked();
                        if (value == true) {
                          total = (harga * int.parse(input.text)) + total!;
                        } else {
                          total = total! - (harga * int.parse(input.text));
                        }
                        isSelect = value;
                        context.read<TotalProductCubit>().checked(total);
                        // print(total);
                        // totalProduk.checked(total);
                        //  totalProduk.emit(total!);
                        // print(total);
                        // setState(() {
                        //   print(value!);
                        //   // isChecked = value!;
                        // });
                      },
                    );
                  },
                ),
                Image.network(
                  '${baseurl()}/img/${gambar}',
                  width: 80,
                ),
                SizedBox(
                  width: 5,
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${nama}',
                        style: secondaryTextstyle,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        'Rp. ${numberFormat.format(harga)}',
                        style: secondaryTextstyle.copyWith(
                          fontWeight: semibold,
                          fontSize: 16,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                            onTap: () {
                              // total = 0;

                              //   context
                              // .read<KeranjangCubitCubit>()
                              // .delete_keranjang(id_keranjang: id);
                              // Future.delayed(const Duration(seconds: 1), () async {
                              keranjang.delete_keranjang(id_keranjang: id);
                              // keranjang.get_keranjang(email: email!);
                              // Navigator.pushReplacementNamed(context, '/cart');
                              // Navigator.popAndPushNamed(context, '/cart');
                              // });
                              context
                                  .read<KeranjangCubitCubit>()
                                  .get_keranjang(email: email!);
                            },
                            child: Icon(
                              Icons.delete_outline,
                              size: 25,
                              color: secondaryColor,
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Container(
                            margin: EdgeInsets.only(right: 15),
                            width: 70,
                            height: 25,
                            decoration: BoxDecoration(
                                border:
                                    Border.all(width: 1, color: secondaryColor),
                                borderRadius: BorderRadius.circular(4)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  onTap: () {
                                    if (int.parse(input.text) > 1) {
                                      if (isSelect == true) {
                                        print('sebelum di kurang ${total}');
                                        total = total! - harga;
                                        print('setelh di kurang ${total}');
                                      }
                                      context
                                          .read<TotalProductCubit>()
                                          .checked(total);
                                      // print('object');
                                    }
                                    counter.decrement(id_keranjang: id);
                                    // print(input.text);
                                    // context.read<KeranjangCubitCubit>().update_keranjang(id_keranjang: id,jumlah: int.parse(input.text));
                                  },
                                  child: Icon(
                                    Icons.remove,
                                    size: 20,
                                    color: secondaryColor,
                                  ),
                                ),
                                BlocBuilder<CounterCubitCubit, int>(
                                  bloc: counter,
                                  buildWhen: (previous, current) {
                                    if (current < 1) {
                                      counter.emit(1);
                                      return false;
                                    } else if (current > 100) {
                                      counter.emit(100);
                                      return false;
                                    }
                                    return true;
                                  },
                                  builder: (context, state) {
                                    // Future.delayed(Duration.zero, () async {});
                                    var newText = state.toString();
                                    input.value = input.value.copyWith(
                                        text: newText,
                                        selection: TextSelection.collapsed(
                                            offset: newText.length));

                                    //hitung total
                                    // if (isSelect == true) {
                                    //   total = total! + (harga * state);
                                    //   print(total);
                                    //   context
                                    //       .read<TotalProductCubit>()
                                    //       .checked(total);
                                    // }
                                    print(state);
                                    return Container(
                                      margin: EdgeInsets.only(top: 3),
                                      width: 25,
                                      height: 18,
                                      child: TextFormField(
                                        onChanged: (text) {
                                          // int number = int.parse(text);
                                          // print(state);
                                          String? newText;
                                          int? ntotal;
                                          if (text != "") {
                                            counter.emit(int.parse(text));
                                            counter.update(id_keranjang: id);
                                            if (isSelect == true) {
                                              total = total! - harga * state;
                                              print(
                                                  'sebelum di kurang ${total}');
                                              ntotal =
                                                  (harga * int.parse(text));
                                              print(
                                                  'setelh di kurang ${ntotal}');
                                                    total = total! + ntotal;
                                              // if (state > int.parse(text)) {
                                              //   // total =
                                              //   //     total! - harga;
                                              // print(total);
                                              // } else {
                                              // print('total anjing ${ntotal}');
                                              //   total =
                                              //       total! + ntotal;
                                              // }
                                              context
                                                  .read<TotalProductCubit>()
                                                  .checked(total);
                                            }
                                            if (int.parse(text) > 100) {
                                              newText = '100';
                                              input.value = input.value
                                                  .copyWith(
                                                      text: newText,
                                                      selection: TextSelection
                                                          .collapsed(
                                                              offset: newText
                                                                  .length));
                                              // print(text);

                                            }
                                            //
                                          } else {
                                            newText = state.toString();
                                            input.value = input.value.copyWith(
                                                text: newText,
                                                selection:
                                                    TextSelection.collapsed(
                                                        offset:
                                                            newText.length));
                                          }
                                          // if (isSelect == true) {
                                          //   total = total! + (harga * int.parse(text));
                                          //   print(total);
                                          //   context
                                          //       .read<TotalProductCubit>()
                                          //       .checked(total);
                                          // }
                                        },
                                        inputFormatters: <TextInputFormatter>[
                                          FilteringTextInputFormatter.digitsOnly
                                        ],
                                        enableInteractiveSelection: false,
                                        keyboardType: TextInputType.number,
                                        style: secondaryTextstyle.copyWith(
                                            fontSize: 13, fontWeight: semibold),
                                        textAlign: TextAlign.center,
                                        textAlignVertical:
                                            TextAlignVertical.center,
                                        controller: input,
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                InkWell(
                                  onTap: () {
                                    if (isSelect == true) {
                                      print('sebelum di kurang ${total}');
                                      total = total! + harga;
                                      print('setelh di kurang ${total}');
                                      context
                                          .read<TotalProductCubit>()
                                          .checked(total);
                                    }
                                    counter.increment(id_keranjang: id);
                                  },
                                  child: Icon(
                                    Icons.add,
                                    size: 20,
                                    color: secondaryColor,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      );
    }

    Widget bottom() {
      TotalProductCubit totalProduk = TotalProductCubit();
      return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(0.0, 1.0), //(x,y)
              blurRadius: 6.0,
            ),
          ],
        ),
        padding: EdgeInsets.symmetric(vertical: 11, horizontal: 15),
        height: 75,
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Total Harga',
                    style: secondaryTextstyle.copyWith(fontSize: 17),
                  ),
                  BlocBuilder<TotalProductCubit, int>(
                    bloc: context.read<TotalProductCubit>(),
                    builder: (context, state) {
                      // TODO: implement listener
                      return Text(
                        "Rp. ${state == 0 ? '-' : numberFormat.format(state)}",
                        style: secondaryTextstyle.copyWith(
                            fontSize: 17, fontWeight: semibold),
                      );
                    },
                    // child: Text(
                    //           'Rp. -',
                    //           style: secondaryTextstyle.copyWith(
                    //               fontSize: 17, fontWeight: semibold),
                    //         ),
                  )
                  // Text(
                  //             'Rp. -',
                  //             style: secondaryTextstyle.copyWith(
                  //                 fontSize: 17, fontWeight: semibold),
                  //           ),
                ],
              ),
            ),
            ButtonWidget(
                color: primaryColor,
                textStyle:
                    whiteTextstyle.copyWith(fontSize: 18, fontWeight: medium),
                padding: EdgeInsets.symmetric(horizontal: 65, vertical: 7),
                text: "Beli",
                onpressed: () {})
          ],
        ),
      );
    }

    if (email == null) {
      return Scaffold(
        backgroundColor: Colors.white38,
        body: AlertDialog(
          title: Text("Gagal"),
          content: Text("Maaf Anda Belum Login"),
          actions: [
            TextButton(
              child: Text(
                'Login',
                style: primaryTextstyle,
              ),
              onPressed: () =>
                  Navigator.pushReplacementNamed(context, '/login'),
            ),
            GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: Container(
                margin: EdgeInsets.only(right: 15),
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: primaryColor),
                child: Text(
                  'Ok',
                  style: whiteTextstyle,
                ),
              ),
            )
            // TextButton(
            //   child: Text('Ok',style: primaryTextstyle,),
            //   onPressed: () => Navigator.of(context).pop(),
            // ),
          ],
        ),
      );
    } else {
      return BlocBuilder<KeranjangCubitCubit, KeranjangCubitState>(
        builder: (context, state) {
          if (state is GetKeranjangCubitSuccess) {
            return Scaffold(
                backgroundColor: whiteColor,
                appBar: PreferredSize(
                  child: appbar(),
                  preferredSize: Size.fromHeight(96),
                ),
                body: ListView(
                  children: [
                    alamat(),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        return produk(
                            state.keranjang[index].id,
                            state.keranjang[index].nama,
                            state.keranjang[index].gambar,
                            state.keranjang[index].jumlah,
                            state.keranjang[index].harga);
                      },
                      itemCount: state.keranjang.length,
                    ),
                    SizedBox(
                      height: 80,
                    )
                  ],
                ),
                bottomSheet: bottom());
          }
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(color: primaryColor),
            ),
          );
        },
      );
    }
  }
}
