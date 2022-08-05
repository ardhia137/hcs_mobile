import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hcs_mobile/Screen/home/HomeScreen.dart';
import 'package:hcs_mobile/Screen/home/ProfileScreen.dart';
import 'package:hcs_mobile/cubit/change_page_cubit_cubit.dart';
import 'package:hcs_mobile/utils/theme.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    Widget customBottomNav(currentIndex) {
      return Container(
        decoration: BoxDecoration(
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              blurRadius: 5,
            ),
          ],
        ),
        child: BottomAppBar(
          child: BottomNavigationBar(
            backgroundColor: whiteColor,
            selectedItemColor: secondaryColor,
            elevation: 10,
            onTap: (value) {
              context.read<ChangePageCubit>().setPage(value);
            },
            type: BottomNavigationBarType.fixed,
            items: [
              BottomNavigationBarItem(
                
                icon: Container(
                  margin: EdgeInsets.symmetric(vertical: 5),
                  child: Image.asset(
                    'assets/icon_home.png',
                    width: 25,
                    color: currentIndex == 0
                        ? primaryColor
                        : secondaryColor,
                  ),
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Container(
                  margin: EdgeInsets.symmetric(vertical: 5),
                  child: Image.asset(
                    'assets/icon_berita.png',
                    width: 25,
                    // color: pageProvider.currentIndex == 1
                    //     ? primaryColor
                    //     : Color(0xff808191),
                  ),
                ),
                label: 'Berita',
              ),
              BottomNavigationBarItem(
                icon: Container(
                  margin: EdgeInsets.symmetric(vertical: 5),
                  child: Image.asset(
                    'assets/icon_whislist.png',
                    width: 25,
                    // color: pageProvider.currentIndex == 2
                    //     ? primaryColor
                    //     : Color(0xff808191),
                  ),
                ),
                label: 'Whislist',
              ),
              BottomNavigationBarItem(
                icon: Container(
                  margin: EdgeInsets.symmetric(vertical: 5),
                  child: Image.asset(
                    'assets/icon_transaksi.png',
                    width: 25,
                    // color: pageProvider.currentIndex == 2
                    //     ? primaryColor
                    //     : Color(0xff808191),
                  ),
                ),
                label: 'Transaksi',
              ),
              BottomNavigationBarItem(
                icon: Container(
                  margin: EdgeInsets.symmetric(vertical: 5),
                  child: Image.asset(
                    'assets/icon_user.png',
                    width: 25,
                    color: currentIndex == 4
                        ? primaryColor
                        : secondaryColor,
                  
                  ),
                ),
                label: 'Profile',
              ),
            ],
          ),
        ),
      );
    }

    Widget body(int currentIndex) {
      switch (currentIndex) {
        case 0:
          return HomeScreen();
          break;
        case 1:
          return HomeScreen();
          break;
        case 2:
          return HomeScreen();
          break;
        case 3:
          return HomeScreen();
          break;
        case 4:
          return ProfileScreen();
          break;

        default:
          return HomeScreen();
      }
    }

    return BlocBuilder<ChangePageCubit, int>(
      builder: (context, currentIndex) {
        print(currentIndex);
        return Scaffold(
          backgroundColor: whiteColor,
          // floatingActionButton: cartButton(),
          // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: customBottomNav(currentIndex),
          body: body(currentIndex),
        );
      },
    );
  }
}
