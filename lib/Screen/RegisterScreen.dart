import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hcs_mobile/Screen/SelectMethodScreen.dart';
import 'package:hcs_mobile/Widget/ButtonWidget.dart';
import 'package:hcs_mobile/Widget/TextFieldWidget.dart';
import 'package:hcs_mobile/cubit/register_cubit_cubit.dart';
import 'package:hcs_mobile/utils/theme.dart';
import 'package:hcs_mobile/utils/validation.dart';

class RegisterScreen extends StatelessWidget {
  
  RegisterScreen({Key? key}) : super(key: key);
  String email = '';
  GlobalKey<FormState>formKey = GlobalKey<FormState>();
  TextEditingController emailcontroller =
      TextEditingController(text: '');
  @override
  Widget build(BuildContext context) {
    Widget header() {
      return Row(
        children: [
          InkWell(
            onTap: () => Navigator.pop(context),
            child: const Icon(
              Icons.arrow_back_ios,
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          Expanded(
            child: Text(
              "Daftar",
              style: blackTextstyle.copyWith(fontWeight: medium, fontSize: 16),
            ),
          ),
          InkWell(
            onTap: () => Navigator.pushNamed(context, '/login'),
            child: Text(
              'Masuk',
              style: primaryTextstyle.copyWith(fontSize: 16),
            ),
          )
        ],
      );
    }

    Widget textField() {
      return Container(
        margin: EdgeInsets.only(top: 45),
        child: Column(
          children: [
            TextFieldWidget(
              text: 'Email',
              textinput: TextInputType.emailAddress,
              validator: validateEmail,
              controller: emailcontroller,
              onsaved: (String? value) {
                email = value!;
              },
            ),
          ],
        ),
      );
    }

    Widget button() {
      return Column(
        children: [
          BlocConsumer<RegisterCubitCubit, RegisterCubitState>(
            listener: (context, state) {
              print(state);
              if (state is RegisterCubitSuccess) {
                Navigator.push(context, MaterialPageRoute(builder: ((context) => SelectMethodScreen(email: email,))));
              } else if (state is RegisterCubitGagal) {
                String error = state.error.split(': ')[1];
                if (error == 'email sudah ada') {
                  final snackBar = SnackBar(
                    backgroundColor: redColor,
                    behavior: SnackBarBehavior.floating,
                    content: Text(
                      'Email sudah ada, silakan login',
                      style: whiteTextstyle.copyWith(
                          fontWeight: medium, fontSize: 13),
                    ),
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                } else {
                  final snackBar = SnackBar(
                    backgroundColor: redColor,
                    behavior: SnackBarBehavior.floating,
                    content: Text(
                      'gagal register',
                      style: whiteTextstyle.copyWith(
                          fontWeight: medium, fontSize: 13),
                    ),
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
              }
            },
            builder: (context, state) {
              return ButtonWidget(
                  color: primaryColor,
                  textStyle: whiteTextstyle.copyWith(
                      fontWeight: semibold, fontSize: 20),
                  text: "Daftar",
                  onpressed: () {
                    if (formKey.currentState!.validate()) {
                      formKey.currentState!.save();
                      context.read<RegisterCubitCubit>().register(
                            email: email,
                          );
                    }
                  });
            },
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 20),
            child: Row(
              children: [
                Expanded(
                    child: Divider(
                  thickness: 1,
                  color: secondaryColor3,
                )),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  child: Text(
                    'atau masuk dengan',
                    style: secondaryTextstyle2.copyWith(fontSize: 13),
                  ),
                ),
                Expanded(
                    child: Divider(
                  thickness: 1,
                  color: secondaryColor3,
                ))
              ],
            ),
          ),
          ButtonWidget(
            color: whiteColor,
            border: Border.all(color: secondaryColor2),
            textStyle:
                secondaryTextstyle.copyWith(fontWeight: semibold, fontSize: 20),
            text: "Metode Lain",
            onpressed: () {
              //modal bottom sheet
              showModalBottomSheet<void>(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10)),
                ),
                context: context,
                builder: (BuildContext context) {
                  return Container(
                    padding: const EdgeInsets.only(
                        left: 15, right: 15, top: 15, bottom: 25),
                    height: 130,
                    decoration: BoxDecoration(
                        color: whiteColor,
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            InkWell(
                              onTap: () => Navigator.pop(context),
                              child: Icon(
                                Icons.close,
                                size: 30,
                                color: secondaryColor,
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(left: 10),
                              child: Text(
                                'Pilih akun untuk masuk',
                                style: secondaryTextstyle.copyWith(
                                    fontWeight: semibold, fontSize: 18),
                              ),
                            )
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: secondaryColor2),
                          ),
                          child: Row(
                            children: [
                              Image.asset(
                                'assets/icon_google.png',
                                width: 24,
                              ),
                              Container(
                                margin: const EdgeInsets.only(left: 20),
                                child: Text(
                                  "Google",
                                  style: secondaryTextstyle.copyWith(
                                      fontSize: 17, fontWeight: regular),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ],
      );
    }

    Widget footer() {
      return Container(
        margin: EdgeInsets.symmetric(
          vertical: 15,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Dengan mendaftar, saya menyetujui ',
              style: secondaryTextstyle.copyWith(fontSize: 14),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {},
                  child: Text(
                    'Syarat dan Ketentuan ',
                    style: primaryTextstyle.copyWith(
                        fontSize: 14, fontWeight: semibold),
                  ),
                ),
                Text(
                  'dan ',
                  style: secondaryTextstyle.copyWith(fontSize: 14),
                ),
                InkWell(
                  onTap: () {},
                  child: Text(
                    ' Kebijakan Privasi',
                    style: primaryTextstyle.copyWith(
                        fontSize: 14, fontWeight: semibold),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: whiteColor,
      body: Container(
        margin: EdgeInsets.symmetric(vertical: 25, horizontal: 15),
        child: Form(
          key: formKey,
          child: ListView(
            children: [
              header(),
              textField(),
              //bantuan widget
              Container(
                alignment: Alignment.centerRight,
                margin: EdgeInsets.symmetric(vertical: 15),
                child: Text(
                  'Butuh Bantuan?',
                  style: primaryTextstyle.copyWith(fontSize: 14),
                ),
              ),
              button(),
              footer()
            ],
          ),
        ),
      ),
    );
  }
}
