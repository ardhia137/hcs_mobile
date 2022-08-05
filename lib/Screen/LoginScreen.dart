import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hcs_mobile/Widget/ButtonWidget.dart';
import 'package:hcs_mobile/Widget/TextFieldWidget.dart';
import 'package:hcs_mobile/cubit/auth_cubit_cubit.dart';
import 'package:hcs_mobile/utils/theme.dart';
import 'package:hcs_mobile/utils/validation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String email = '';

  String password = '';

  final formKey = GlobalKey<FormState>();

  TextEditingController emailcontroller = TextEditingController(text: '');

  TextEditingController passwordcontroller = TextEditingController(text: '');

  Getpassword getpassword = Getpassword();

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<void> save(email) async {
    final SharedPreferences prefs = await _prefs;
    await prefs.setString('email', email);
  }

  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState
    super.setState(fn);
    context.read<AuthCubitCubit>().clear();
  }

  @override
  Widget build(BuildContext context) {
    
    Widget header() {
      return Row(
        children: [
          // InkWell(
          //   onTap: () => Navigator.pop(context),
          //   child: const Icon(
          //     Icons.arrow_back_ios,
          //   ),
          // ),
          // const SizedBox(
          //   width: 15,
          // ),
          Expanded(
            child: Text(
              "Masuk",
              style: blackTextstyle.copyWith(fontWeight: medium, fontSize: 16),
            ),
          ),
          InkWell(
            onTap: () => Navigator.pushNamed(context, '/register'),
            child: Text(
              'Daftar',
              style: primaryTextstyle.copyWith(fontSize: 16),
            ),
          )
        ],
      );
    }

    Widget textFieldAndButton() {
      return Container(
        margin: const EdgeInsets.only(top: 45),
        child: BlocConsumer<AuthCubitCubit, AuthCubitState>(
          listener: (context, state) {
            // print(email);
            if(email != ''){
               if (state is AuthCubitSuccess) {
              getpassword.getpassword(true);
            } else if (state is AuthCubitGagal) {
              if (state.error != 'reset') {
                final snackBar = SnackBar(
                  backgroundColor: redColor,
                  behavior: SnackBarBehavior.floating,
                  content: Text(
                    'Email yang kamu masukan salah',
                    style: whiteTextstyle.copyWith(
                        fontWeight: medium, fontSize: 13),
                  ),
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                 email = '';
              }
            }
            }else{
              print('t');
            }
           
          },
          builder: (context, state) {
            print(state);
            return StreamBuilder(
              stream: getpassword.stream,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.data == true && state is AuthCubitSuccess) {
                  return Column(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Email',
                            style: secondaryTextstyle.copyWith(
                                fontWeight: medium, fontSize: 16),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "${state.user.email}",
                                style: blackTextstyle.copyWith(
                                    fontWeight: medium, fontSize: 16),
                              ),
                              InkWell(
                                onTap: () {
                                  context.read<AuthCubitCubit>().reset(
                                        email: '',
                                      );
                                  getpassword.getpassword(false);
                                },
                                child: Text(
                                  'Ubah',
                                  style: primaryTextstyle.copyWith(
                                      fontWeight: semibold, fontSize: 16),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFieldWidget(
                        text: 'Kata Sandi',
                        passwordVisible: true,
                        validator: validateNull,
                        controller: passwordcontroller,
                        onsaved: (String? value) {
                          password = value!;
                        },
                      ),
                      Container(
                        alignment: Alignment.centerRight,
                        margin: EdgeInsets.symmetric(vertical: 15),
                        child: Text(
                          'Butuh Bantuan?',
                          style: primaryTextstyle.copyWith(fontSize: 14),
                        ),
                      ),
                      ButtonWidget(
                        color: primaryColor,
                        textStyle: whiteTextstyle.copyWith(
                            fontWeight: semibold, fontSize: 20),
                        text: "Masuk",
                        onpressed: () async{
                          final prefs =  SharedPreferences.getInstance();
                          if (formKey.currentState!.validate()) {
                            formKey.currentState!.save();
                            print(password);
                            if (state.user.password == password) {
                              save(state.user.email);
                              // print(state.user.email);
                              Navigator.pushNamed(context, '/');
                            } else {
                              final snackBar = SnackBar(
                                backgroundColor: redColor,
                                behavior: SnackBarBehavior.floating,
                                content: Text(
                                  'Password yang kamu masukan salah',
                                  style: whiteTextstyle.copyWith(
                                      fontWeight: medium, fontSize: 13),
                                ),
                                shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            }
                          }
                        },
                      ),
                    ],
                  );
                }
                return Column(
                  children: [
                    TextFieldWidget(
                      text: 'Email',
                      textinput: TextInputType.emailAddress,
                      controller: emailcontroller,
                      validator: validateEmail,
                      onsaved: (String? value) {
                        email = value!;
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      margin: EdgeInsets.symmetric(vertical: 15),
                      child: Text(
                        'Butuh Bantuan?',
                        style: primaryTextstyle.copyWith(fontSize: 14),
                      ),
                    ),
                    ButtonWidget(
                      color: primaryColor,
                      textStyle: whiteTextstyle.copyWith(
                          fontWeight: semibold, fontSize: 20),
                      text: "Masuk",
                      onpressed: () {
                        if (formKey.currentState!.validate()) {
                          formKey.currentState!.save();
                          context.read<AuthCubitCubit>().login(
                                email: email,
                              );
                        }
                      },
                    ),
                  ],
                );
              },
            );
          },
        ),
      );
    }

    Widget button() {
      return Column(
        children: [
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

    Widget daftar() {
      return Container(
        margin: EdgeInsets.symmetric(vertical: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Belum punya akun? ',
              style: secondaryTextstyle.copyWith(fontSize: 14),
            ),
            InkWell(
              onTap: () => Navigator.pushNamed(context, '/register'),
              child: Text(
                'Daftar',
                style: primaryTextstyle.copyWith(fontSize: 14),
              ),
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
            children: [header(), textFieldAndButton(), button(), daftar()],
          ),
        ),
      ),
    );
  }
}
