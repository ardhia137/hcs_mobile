import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hcs_mobile/Widget/ButtonWidget.dart';
import 'package:hcs_mobile/cubit/counter_cubit_cubit.dart';

import 'package:hcs_mobile/utils/theme.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  bool isChecked = false;
  TextEditingController input = TextEditingController(text: '1');
  String? number = "";
  @override
  Widget build(BuildContext context) {

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
                      return isChecked == true ? primaryColor : secondaryColor;
                    }),
                    value: isChecked,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked = value!;
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

    Widget produk() {
      CounterCubitCubit counter =
          CounterCubitCubit(init: int.parse(input.text));
      return Column(
        children: [
          pembatas(7),
          Container(
            padding: EdgeInsets.symmetric(vertical: 15),
            child: Row(
              children: [
                Checkbox(
                  checkColor: Colors.white,
                  fillColor: MaterialStateProperty.resolveWith<Color>((states) {
                    return isChecked == true ? primaryColor: secondaryColor;
                  }),
                  value: isChecked,
                  onChanged: (bool? value) {
                    setState(() {
                      isChecked = value!;
                    });
                  },
                ),
                Image.asset(
                  'assets/porduk.jpeg',
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
                        'VITACIMIN TABLET (per Strip)',
                        style: secondaryTextstyle,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        'Rp. 2.012',
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
                          Icon(Icons.delete_outline,size: 25,color: secondaryColor,),
                          SizedBox(width: 5,),
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
                                    counter.decrement();
                                  },
                                  child: Icon(
                                    Icons.remove,
                                    size: 20,
                                    color: secondaryColor,
                                  ),
                                ),
                                BlocBuilder<CounterCubitCubit, int>(
                                  bloc: counter,
                                  buildWhen: (previous,current){
                                    if(current < 1){
                                      counter.emit(1);
                                      return false;
                                    }else if(current >100){
                                      counter.emit(100);
                                      return false;
                                    }
                                    return true;
                                  },
                                  builder: (context, state) {
                                    Future.delayed(Duration.zero, () async {
                                      var newText = state.toString();
                                      input.value = input.value.copyWith(
                                          text: newText,
                                          selection: TextSelection.collapsed(
                                              offset: newText.length));
                                    });
                                    print(state);
                                    return Container(
                                      margin: EdgeInsets.only(top: 3),
                                      width: 25,
                                      height: 18,
                                      child: TextFormField(
                                        onChanged: (text) {
                                          number = text;
                                          print(number);
                                          if (text != "") {
                                            counter.emit(int.parse(text));
                                            if (int.parse(text) > 100) {
                                              print('g');
                                              const newText = '100';
                                              input.value = input.value
                                                  .copyWith(
                                                      text: newText,
                                                      selection: TextSelection
                                                          .collapsed(
                                                              offset: newText
                                                                  .length));
                                              print(text);
                                            }
                                          }
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
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                InkWell(
                                  onTap: () {
                                    counter.increment();
                                  },
                                  child: Icon(
                                    Icons.add,
                                    size: 20,
                                    color: primaryColor,
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
      return Container(
        decoration: const BoxDecoration(
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
                  Text(
                    'Rp. 4.024',
                    style: secondaryTextstyle.copyWith(
                        fontSize: 17, fontWeight: semibold),
                  )
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

    return Scaffold(
        backgroundColor: whiteColor,
        appBar: PreferredSize(
          child: appbar(),
          preferredSize: Size.fromHeight(96),
        ),
        body: ListView(
          children: [
            alamat(),
            produk(),
            produk(),
            produk(),
            produk(),
            produk(),
            SizedBox(
              height: 80,
            )
          ],
        ),
        bottomSheet: bottom());
  }
}
