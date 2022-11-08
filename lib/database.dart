// database.dart

// required package imports
import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;


part 'database.g.dart'; // the generated code will be there/

@Database(version: 1, entities: [SingleColor])
abstract class AppDatabase extends FloorDatabase {
  ColorDAO get colordao;
}

// entity/person.dart

@entity
class SingleColor {
  @primaryKey
  final int id;
  final int color;
  final String name;

  SingleColor(this.id, this.color, this.name);
}

// dao/person_dao.dart

@dao
abstract class ColorDAO {

  @Query('SELECT * FROM SingleColor WHERE id = :id')
  Stream<SingleColor?> findColorById(int id);

  @insert
  Future<void> insertColor(SingleColor singleColor);

  
}


/////////////insert data in database///////////////
