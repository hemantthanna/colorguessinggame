import 'package:flutter/material.dart';

import 'database.dart';
import 'home.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //////////////////////////
  AppDatabase database =
      await $FloorAppDatabase.databaseBuilder('app_database.db').build();
  try {
    await database.colordao.insertColor(
        SingleColor(0, const Color.fromARGB(255, 255, 17, 0).value, 'RED'));

    await database.colordao.insertColor(
        SingleColor(1, const Color.fromARGB(255, 0, 0, 0).value, 'BLACK'));
    await database.colordao.insertColor(
        SingleColor(2, const Color.fromARGB(255, 0, 140, 255).value, 'BLUE'));
    await database.colordao.insertColor(
        SingleColor(3, const Color.fromARGB(255, 255, 230, 0).value, 'YELLOW'));
    await database.colordao.insertColor(
        SingleColor(4, const Color.fromARGB(255, 255, 0, 85).value, 'PINK'));
    await database.colordao.insertColor(
        SingleColor(5, const Color.fromARGB(255, 76, 175, 80).value, 'GREEN'));
    await database.colordao.insertColor(
        SingleColor(6, const Color.fromARGB(255, 217, 0, 255).value, 'PURPLE'));
    await database.colordao
        .insertColor(SingleColor(7, Colors.brown.value, 'BROWN'));
    await database.colordao.insertColor(
        SingleColor(8, const Color.fromARGB(255, 184, 184, 184).value, 'GREY'));
    await database.colordao
        .insertColor(SingleColor(9, Colors.white.value, 'WHITE'));
    database =
        await $FloorAppDatabase.databaseBuilder('app_database.db').build();
  } catch (e) {}

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Home(
      color: await database.colordao
          .findColorById(0)
          .first
          .then((value) => value!.color),
      pageindex: 0,
      name: await database.colordao
          .findColorById(0)
          .first
          .then((value) => value!.name),
      database: database,
    ),
  ));
}
