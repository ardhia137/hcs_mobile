import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hcs_mobile/Widget/ButtonWidget.dart';
import 'package:hcs_mobile/Widget/TextFieldWidget.dart';
import 'package:hcs_mobile/cubit/auth_cubit_cubit.dart';
import 'package:hcs_mobile/cubit/register_cubit_cubit.dart';
import 'package:hcs_mobile/utils/theme.dart';
import 'package:hcs_mobile/utils/validation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CompleteRegisterScreen extends StatelessWidget {
  final String email;
  CompleteRegisterScreen({Key? key, required this.email}) : super(key: key);
  final formKey = GlobalKey<FormState>();
  late TextEditingController emailController =
      TextEditingController(text: email);
  TextEditingController namaController = TextEditingController(text: '');
  TextEditingController passwordController = TextEditingController(text: '');
  late String _email = email;
  late String nama = '';
  late String password = '';
    final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  Future<void> save(email) async {
    final SharedPreferences prefs = await _prefs;
    await prefs.setString('email', email);
  }
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
              "Daftar dengan Email",
              style: blackTextstyle.copyWith(fontWeight: medium, fontSize: 16),
            ),
          ),
        ],
      );
    }

    Widget textField() {
      return Container(
        margin: const EdgeInsets.only(top: 45),
        child: Column(
          children: [
            TextFieldWidget(
              controller: emailController,
              text: 'Email',
              textinput: TextInputType.emailAddress,
              isEnabled: false,
              validator: validateEmail,
              onsaved: (String? value) {
                _email = value!;
              },
            ),
            SizedBox(
              height: 10,
            ),
            TextFieldWidget(
              controller: namaController,
              text: 'Nama Lengkap',
              textinput: TextInputType.text,
              validator: validateName,
              onsaved: (String? value) {
                nama = value!;
              },
            ),
            SizedBox(
              height: 10,
            ),
            TextFieldWidget(
              controller: passwordController,
              text: 'Kata Sandi',
              passwordVisible: true,
              validator: validatePassword,
              onsaved: (String? value) {
                password = value!;
              },
            )
          ],
        ),
      );
    }

    Widget button() {
      return Column(
        children: [
          BlocConsumer<CompleteAuthCubitCubit, CompleteAuthCubitState>(
            listener: (context, state) {
              if (state is CompleteAuthCubitSuccess) {
                context.read<AuthCubitCubit>().login(
                      email: email,
                    );
                save(email);
                Navigator.of(context)
                    .pushNamedAndRemoveUntil('/', (route) => false);
              }
            },
            builder: (context, state) {
              return ButtonWidget(
                color: primaryColor,
                textStyle:
                    whiteTextstyle.copyWith(fontWeight: semibold, fontSize: 20),
                text: "Selesai",
                onpressed: () {
                  if (formKey.currentState!.validate()) {
                    formKey.currentState!.save();
                    context.read<CompleteAuthCubitCubit>().completeauth(
                        email: email, nama: nama, password: password);
                  }
                },
              );
            },
          )
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
