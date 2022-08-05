import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'package:hcs_mobile/cubit/auth_cubit_cubit.dart';
import 'package:hcs_mobile/utils/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
    final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  @override
  Widget build(BuildContext context) {
     Future<String?> save() async {
  final SharedPreferences prefs = await _prefs;
  // String email = await prefs.getString('email')!;
  if(prefs.getString('email') == null || prefs.getString('email') == "" ){
    Navigator.pushNamed(context, '/login');
  }
   return  await prefs.getString('email');
   // context.read<AuthCubitCubit>().login(email: '');
   
  }
    save().then((value) => context.read<AuthCubitCubit>().login(email: value!));
    
    // context.read<AuthCubitCubit>().login(email: save());
    Widget header(email,nama) {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        child: Row(
          children: [
            ProfilePicture(
              name: nama,
              radius: 41,
              fontsize: 31,
              // random: true,
            ),
            SizedBox(
              width: 15,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  nama,
                  style: blackTextstyle.copyWith(
                      fontSize: 20, fontWeight: semibold),
                ),
                Text(
                  email,
                  style: secondaryTextstyle.copyWith(
                      fontSize: 15, fontWeight: medium),
                )
              ],
            )
          ],
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

    Widget pengaturan() {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Akun & Keamanan',
              style:
                  blackTextstyle.copyWith(fontWeight: semibold, fontSize: 16),
            ),
            SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Edit Profile',
                  style:
                      blackTextstyle.copyWith(fontWeight: medium, fontSize: 15),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 18,
                )
              ],
            ),
            SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Ubah Password',
                  style:
                      blackTextstyle.copyWith(fontWeight: medium, fontSize: 15),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 18,
                )
              ],
            )
          ],
        ),
      );
    }

    Widget umum() {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Umum',
              style:
                  blackTextstyle.copyWith(fontWeight: semibold, fontSize: 16),
            ),
            SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Hubungi',
                  style:
                      blackTextstyle.copyWith(fontWeight: medium, fontSize: 15),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 18,
                )
              ],
            ),
            SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Bantuan',
                  style:
                      blackTextstyle.copyWith(fontWeight: medium, fontSize: 15),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 18,
                )
              ],
            )
          ],
        ),
      );
    }

    Widget keluar() {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        child: Row(
          children: [
            Icon(
              Icons.logout,
              size: 25,
              color: primaryColor,
            ),
            SizedBox(
              width: 10,
            ),
            InkWell(
              onTap: () async {
                final prefs = await SharedPreferences.getInstance();
                final success = await prefs.remove('email');
                await prefs.setString('email', '');
                //   context.read<AuthCubitCubit>().reset(
                //                         email: '',
                //                       );

                Navigator.popAndPushNamed(context, '/').then((_){
                  setState((){
                  context.read<AuthCubitCubit>().clear();

                  });
                } );
              },
              child: Text(
                'Keluar',
                style: primaryTextstyle.copyWith(
                    fontWeight: semibold, fontSize: 16),
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: whiteColor,
      body : BlocBuilder<AuthCubitCubit, AuthCubitState>(
        builder: (context, state) {
          if(state is AuthCubitSuccess){
              return ListView(
                  children: [
                    header(state.user.email,state.user.nama),
                    pembatas(10),
                    pengaturan(),
                    pembatas(10),
                    umum(),
                    pembatas(10),
                    keluar(),
                  ],
            );
          }
          return Center(child: CircularProgressIndicator(color: primaryColor),);
        },
      )
    );
  }
}
