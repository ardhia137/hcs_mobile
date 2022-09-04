import 'package:hcs_mobile/model/SearchModel.dart';
import 'package:sqflite/sqflite.dart';
class SearchServices{
   Database? db;
  Future open() async {
    db = await openDatabase('search.db', version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('''create table search (
    id integer primary key autoincrement,
    search varchar(255) not null,
    tanggal varchar(255) not null
  ) ''').then((value) => print("database dibuat")).catchError((error) {
            print('error ketika database dibuat ${error.toString()}');
          });
    });
    return db;
  }

  Future<Database> get database async {
    if (db == null) {
      db = await open();
    }
    print(db);
    return db!;
  }

  Future<List<SearchModel>?> insertdata({
    String? search,
  }) async {
    try {
      // await prefs.setInt('saldo', 0);
      Database? db = await this.database;
      final now = DateTime.now();
      String? tanggal = now.toString();
      var cek = await db.rawQuery(
        "select * from search where search = '${search}'");
      if (cek.length == 0) {
         var sql = await db.insert('search', {
        'search': search,
        'tanggal': tanggal,
      });
      }else{
        var sql = await db.rawQuery(
        "update search set tanggal = '${tanggal}' where search = '${search}'");
        // print(sql);
      }
      // var cekk = await db.query('search',orderBy: "tanggal DESC",);
      // print(cekk);
      List<SearchModel> datalist = <SearchModel>[];
      return datalist;
    } catch (e) {
      print(e);
    }
  }
   Future<List<SearchModel>> getdata() async {
    Database? db;
    db = await database;
    var data = await db.query('search',orderBy: "tanggal DESC",);
    List<SearchModel> datalist = <SearchModel>[];
     for (var item in data) {
        datalist.add(SearchModel.fromJson(item));
      }
    return datalist;
  }  
  Future<List<SearchModel>> delete({int? id}) async {
    Database? db;
    db = await database;
    var data = await db.rawQuery("delete from search where id = ${id}");
    List<SearchModel> datalist = <SearchModel>[];
     for (var item in data) {
        datalist.add(SearchModel.fromJson(item));
      }
    return datalist;
  } 
  Future<List<SearchModel>> deleteall() async {
    Database? db;
    db = await database;
    var data = await db.rawQuery("delete from search");
    List<SearchModel> datalist = <SearchModel>[];
     for (var item in data) {
        datalist.add(SearchModel.fromJson(item));
      }
    return datalist;
  }
}