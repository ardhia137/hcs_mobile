import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hcs_mobile/Screen/CompleteRegisterScreen.dart';
import 'package:hcs_mobile/Widget/CardMethodWidget.dart';
import 'package:hcs_mobile/cubit/register_cubit_cubit.dart';
import 'package:hcs_mobile/cubit/timer_cubit.dart';
import 'package:hcs_mobile/utils/theme.dart';

class VerificationScreen extends StatelessWidget {
  const VerificationScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    String _email = '';
    TimerCubit mytimer = TimerCubit();
    print("object");
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
              "Verufikasi untuk kemanan akun",
              style: blackTextstyle.copyWith(fontWeight: medium, fontSize: 16),
            ),
          ),
        ],
      );
    }

    Widget text() {
      return Container(
        margin: const EdgeInsets.only(top: 25, bottom: 15),
        child: Column(
          children: [
            Image.asset(
              'assets/icon_email.png',
              width: 43,
            ),
            const SizedBox(
              height: 10,
            ),
            Text("Masukan Kode Verifikasi",
                style: blackTextstyle.copyWith(
                    fontWeight: semibold, fontSize: 18)),
            const SizedBox(
              height: 10,
            ),
            Text(
                "Kode verifikasi telah dikirim melalui e-mail ke email@hcs.com",
                textAlign: TextAlign.center,
                style:
                    blackTextstyle.copyWith(fontWeight: regular, fontSize: 15)),
          ],
        ),
      );
    }

    Widget textfield() {
      return Column(
        children: [
          BlocBuilder<RequestOtpCubitCubit, RequestOtpCubitState>(
            builder: (context, state) {
              if (state is RequestOtpCubitSuccess) {
                print(state.user.otp);
                _email = state.user.email;
                return Center(
                  child: SizedBox(
                    width: 200,
                    child: TextFormField(
                      maxLength: 6,
                      onChanged: (text) {
                        if (text.length == 6) {
                          // print(text)
                          if (text == state.user.otp.toString()) {
                             Navigator.push(context, MaterialPageRoute(builder: ((context) => CompleteRegisterScreen(email: _email))));
                            // Navigator.pushNamed(context, '/completeregister');
                          } else {
                            final snackBar = SnackBar(
                              backgroundColor: redColor,
                              behavior: SnackBarBehavior.floating,
                              content: Text(
                                'Kode yang kamu masukan salah',
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
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      style: blackTextstyle.copyWith(
                          letterSpacing: 15,
                          fontSize: 22,
                          fontWeight: semibold),
                      decoration: InputDecoration(
                        counterText: "",
                        border: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: primaryColor, width: 2)),
                        enabledBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: primaryColor, width: 2)),
                        focusedBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: primaryColor, width: 2)),
                      ),
                    ),
                  ),
                );
              } else if (state is RequestOtpCubitGagal) {
                final snackBar = SnackBar(
                  backgroundColor: redColor,
                  behavior: SnackBarBehavior.floating,
                  content: Text(
                    'Registrasi tidak dapat di lanjutkan',
                    style: whiteTextstyle.copyWith(
                        fontWeight: medium, fontSize: 13),
                  ),
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                );
                Future.delayed(Duration.zero, () async {
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  // myFunction();
                });
              }
              return Center(
                child: SizedBox(
                  width: 200,
                  child: TextFormField(
                    maxLength: 6,
                    onChanged: (text) {
                      if (text.length == 6) {
                        // print(text)
                        if (text == '123456') {
                          print('First text field: $text');
                          Navigator.pushNamed(context, '/completeregister');
                        } else {
                          final snackBar = SnackBar(
                            backgroundColor: redColor,
                            behavior: SnackBarBehavior.floating,
                            content: Text(
                              'Kode yang kamu masukan salah',
                              style: whiteTextstyle.copyWith(
                                  fontWeight: medium, fontSize: 13),
                            ),
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                          );

                          // Find the ScaffoldMessenger in the widget tree
                          // and use it to show a SnackBar.
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                      }
                    },
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    style: blackTextstyle.copyWith(
                        letterSpacing: 15, fontSize: 22, fontWeight: semibold),
                    decoration: InputDecoration(
                      counterText: "",
                      border: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: primaryColor, width: 2)),
                      enabledBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: primaryColor, width: 2)),
                      focusedBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: primaryColor, width: 2)),
                    ),
                  ),
                ),
              );
            },
          )
        ],
      );
    }

    Widget footer() {
      return Container(
        margin: EdgeInsets.only(top: 15),
        child: Column(
          children: [
            StreamBuilder(
              stream: mytimer.stream,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.data == 0 ||
                    snapshot.connectionState == ConnectionState.waiting) {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Tidak menerima kode? ",
                        style: secondaryTextstyle.copyWith(
                          fontSize: 14,
                        ),
                      ),
                      InkWell(
                          onTap: () async {
                            mytimer.timerStart();
                            await Future.delayed(const Duration(seconds: 30),
                                () {
                              context.read<RequestOtpCubitCubit>().request_otp(
                                    email: _email,
                                  );
                            });
                          },
                          child: Text(
                            "Kirim ulang ",
                            style: primaryTextstyle.copyWith(
                                fontSize: 14, fontWeight: bold),
                          ))
                    ],
                  );
                } else {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Mohon tunggu dalam ',
                        style: secondaryTextstyle.copyWith(fontSize: 14),
                      ),
                      Text(
                        '${snapshot.data} detik ',
                        style: secondaryTextstyle.copyWith(
                            fontSize: 14, fontWeight: semibold),
                      ),
                      Text(
                        'untuk kirim ulang',
                        style: secondaryTextstyle.copyWith(fontSize: 14),
                      )
                    ],
                  );
                }
              },
            ),
          ],
        ),
      );
    }

    return Scaffold(
        backgroundColor: whiteColor,
        body: Container(
          margin: const EdgeInsets.symmetric(vertical: 25, horizontal: 15),
          child: ListView(
            children: [header(), text(), textfield(), footer()],
          ),
        ));
  }
}
