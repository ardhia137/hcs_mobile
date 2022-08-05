import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hcs_mobile/Widget/CardMethodWidget.dart';
import 'package:hcs_mobile/cubit/register_cubit_cubit.dart';
import 'package:hcs_mobile/utils/theme.dart';

class SelectMethodScreen extends StatelessWidget {
  final String email;
  const SelectMethodScreen({Key? key, required this.email}) : super(key: key);

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
              "Verufikasi untuk kemanan akun",
              style: blackTextstyle.copyWith(fontWeight: medium, fontSize: 16),
            ),
          ),
        ],
      );
    }

    Widget text() {
      return Container(
        margin: const EdgeInsets.only(top: 25, bottom: 37),
        child: Column(
          children: [
            Text("Pilih Methode Verfikasi",
                style: blackTextstyle.copyWith(
                    fontWeight: semibold, fontSize: 18)),
            const SizedBox(
              height: 10,
            ),
            Text(
                "Pilih salah satu methode dibawah ini untuk mendapatkan kode verifikasi",
                textAlign: TextAlign.center,
                style:
                    blackTextstyle.copyWith(fontWeight: regular, fontSize: 15)),
          ],
        ),
      );
    }

    Widget cardMethod(){
      return Container(
        child: Column(
          children: [
            BlocConsumer<RequestOtpCubitCubit, RequestOtpCubitState>(
              listener: (context, state) {
                print(state);
                if(state is RequestOtpCubitSuccess){
                  Navigator.pushNamed(context, '/verification');
                }
              },
              builder: (context, state) {
                return CardMetdhodWidget( 
                  onpressed: (){
                    context.read<RequestOtpCubitCubit>().request_otp(
                            email: email,
                          );
                  },
                  email: email,);
              },
            )
            
          ],
        ),
      );
    }

    return Scaffold(
        backgroundColor: whiteColor,
        body: Container(
          margin: const EdgeInsets.symmetric(vertical: 25, horizontal: 15),
          child: ListView(
            children: [
              header(),
              text(),
              cardMethod()
            ],
          ),
        ));
  }
}
