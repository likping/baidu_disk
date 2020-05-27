import 'package:sqflite/sqflite.dart';
import "./SearchHistory.dart";
import "./PathUtils.dart";
import './Constant.dart';
class DbHelper{
  /*不知名语法。。。*/
  factory DbHelper()=>_getInstance();
  static DbHelper get instance =>_getInstance();
  static DbHelper _instance;
  DbHelper._internal();
  static DbHelper _getInstance(){
    if(_instance==null){
      _instance=new DbHelper._internal();
    }
    return _instance;
  }
  Database _db;
  Future<Database>get db async{
    var databasesPath = await getDatabasesPath();
    String path = databasesPath+'/'+Constant.dbName;

// Delete the database
    await deleteDatabase(path);

// open the database
    Database database = await openDatabase(
        path,
        version: 1,
        onCreate: (Database db, int version) async {
          // When creating the db, create the table
          await db.execute('create table ${Constant.searchHistoryTable}'
              '("id" integer primary key autoincrement,'
              '"keyword" text unique,"time" integer )');
        });
    /*
    if(null==_db) _db=await _initDb();
     return db;*/
    _db=database;
    return database;
  }
  _initDb() async{
    String databasesPath =await getDatabasesPath();
    // 实验三
    String path=PathUtils.join(databasesPath,Constant.dbName);

    print(path);
    return await openDatabase(
        path,
        version: Constant.dbVersion,
        onCreate: _onCreate,
    );

  }
  /**/
  void _onCreate(Database db,int version) {
    db.execute('create table ${Constant.searchHistoryTable}''("id" integer primary key autoincrement,''"keyword" text unique,"time" integer )'
    );
  }
  void close() async{
    if(_db!=null ) await _db.close();
  }
  Future<SearchHistory> insert(SearchHistory searchHistory)async{
    /*实验3：*/
    var __db=await db;
    try{
      searchHistory.id=
          await __db.insert(Constant.searchHistoryTable,searchHistory.toMap());
    }catch(e){}
    return searchHistory;

  }
  Future<SearchHistory>queryById(int id)async{
    var __db=await db;

    List<Map> maps= await __db.
            query(Constant.searchHistoryTable,where: "id=?",whereArgs: [id]);
    ;
    if(maps.length>0){
      return SearchHistory.fromMap(maps.first);
    }
    return null;
  }
  Future<List<SearchHistory>> query()async{
    var __db=await db;
    List<Map> maps=await __db.query(Constant.searchHistoryTable);
    if(maps.length>0){
      List<SearchHistory> list=new List<SearchHistory>();
      for(var map in maps){
        list.add(SearchHistory.fromMap(map));
      }
      return list;
    }
    return null;
  }
  Future<List<SearchHistory>> search(String key)async{
  
    var __db=await db;
    List<Map>maps=await __db.query(Constant.searchHistoryTable,
        where:"keyword like %?%",
        whereArgs: [key]
    );
    var list=List<SearchHistory>();
    maps.forEach((value){
      list.add(SearchHistory.fromMap(value));
    });
    return list;

  }
  Future<List<SearchHistory>> queryAll() async{
    /**/
    
   
    var __db=await db;
    List<Map> maps=await __db.query(Constant.searchHistoryTable);
    var list=List<SearchHistory>();
    maps.forEach((value){
      list.add(SearchHistory.fromMap(value));
    });
    return list;
  }
  Future<int> deleteAll() async{
    /* */
    var __db=await db;
    return await __db.delete(Constant.searchHistoryTable);
  }
  Future<int>deleteById(int id) async{
    var __db=await db;
     await __db.delete(Constant.searchHistoryTable,where: "id=?",whereArgs: [id]);
    return id;
  }

}

