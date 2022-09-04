import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hcs_mobile/Screen/SearchProdukScreen.dart';
import 'package:hcs_mobile/cubit/kategori_cubit_cubit.dart';
import 'package:hcs_mobile/cubit/search_cubit_cubit.dart';
import 'package:hcs_mobile/model/KategoriModel.dart';
import 'package:hcs_mobile/utils/theme.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('object');
    Widget history_search() {
      return BlocBuilder<SearchCubitCubit, SearchCubitState>(
        bloc: BlocProvider.of<SearchCubitCubit>(context)..getData(),
        builder: (context, state) {
          if (state is SearchSuccess) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 20, bottom: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Terakhir dicari',
                          style: secondaryTextstyle.copyWith(
                              fontWeight: semibold, fontSize: 15),
                        ),
                        state.data.length > 0
                            ? InkWell(
                                onTap: () {
                                  context.read<SearchCubitCubit>().deleteall();
                                  BlocProvider.of<SearchCubitCubit>(context)
                                    ..getData();
                                },
                                child: Text(
                                  'Hapus Semua',
                                  style: redTextstyle.copyWith(
                                      fontWeight: semibold, fontSize: 14),
                                ),
                              )
                            : const SizedBox(),
                      ],
                    ),
                  ),
                  state.data.isNotEmpty
                      ? ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: state.data.length,
                          itemBuilder: (BuildContext context, int index) {
                            return InkWell(
                              onTap: () => Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: ((context) => SearchProdukScreen(search: state.data[index].search,))), (route) => false),
                              child: Container(
                                margin: EdgeInsets.only(top: 15),
                                child: Row(
                                  children: [
                                    Image.asset(
                                      'assets/search.png',
                                      width: 23,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      '${state.data[index].search}',
                                      style: secondaryTextstyle.copyWith(
                                          fontWeight: medium),
                                    ),
                                    Expanded(
                                      child: Align(
                                          alignment: Alignment.centerRight,
                                          child: InkWell(
                                            onTap: () {
                                              context
                                                  .read<SearchCubitCubit>()
                                                  .delete(
                                                      id: state.data[index].id);
                                              BlocProvider.of<SearchCubitCubit>(
                                                  context)
                                                ..getData();
                                            },
                                            child: const Icon(
                                              Icons.close,
                                              color: Color(0xffC1CBDA),
                                            ),
                                          )),
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        )
                      : Center(
                          child: Text(
                          'tidak ada data',
                          style: secondaryTextstyle.copyWith(
                              fontWeight: light, fontSize: 13),
                        ))
                ],
              ),
            );
          }
          return SizedBox();
        },
      );
    }

    Widget kategori(List<KategoriModel> kategori) {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(top: 20, bottom: 5),
              child: Text(
                "Kategori",
                style: secondaryTextstyle.copyWith(
                    fontWeight: semibold, fontSize: 16),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: kategori.length,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap:(){
                  
                    //  Navigator.push(context, MaterialPageRoute(builder: ((context) => SearchProdukScreen())));
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: 15),
                    child: Row(
                      children: [
                        Text(
                          "${kategori[index].nama}",
                          style: primaryTextstyle.copyWith(
                              fontWeight: medium, fontSize: 14),
                        ),
                        const Expanded(
                            child: Align(
                                alignment: Alignment.centerRight,
                                child: Icon(
                                  Icons.arrow_forward_ios,
                                  color: Color(0xffBFC9D9),
                                  size: 20,
                                )))
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: whiteColor,
        elevation: 0,
        title: Row(
          children: [
            InkWell(
              onTap: () => Navigator.pop(context),
              child: Icon(
                Icons.arrow_back_ios,
                color: secondaryColor,
              ),
            ),
            SizedBox(
              width: 13,
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Color(0xffB6C0C1)),
                    color: Color(0xffF6F6F6)),
                padding: EdgeInsets.symmetric(horizontal: 11.0),
                height: 42,
                child: TextFormField(
                  autofocus: true,
                  onFieldSubmitted: (value) {
                    context.read<SearchCubitCubit>().search(search: value);
                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: ((context) => SearchProdukScreen(search: value,))), (route) => false);
                  },
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      icon: Icon(
                        Icons.search,
                        color: secondaryColor,
                      ),
                      hintText: "Cari",
                      hintStyle:
                          TextStyle(color: secondaryColor, fontWeight: medium),
                      // hintStyle: secondaryTextstyle,
                      hintMaxLines: 1),
                  //maxLines: 5,
                ),
              ),
            )
          ],
        ),
      ),
      backgroundColor: whiteColor,
      body: BlocBuilder<KategoriCubitCubit, KategoriCubitState>(
         bloc: BlocProvider.of<KategoriCubitCubit>(context)..get_kategori(),
        builder: (context, state) {
          
          if(state is KategoriCubitSuccess){
            return ListView(children: [
              history_search(),
              kategori(state.kategori)
            ],);
          }
          return Center(
            child: CircularProgressIndicator(color:primaryColor),
          );
        },
      )
    );
  }
}
