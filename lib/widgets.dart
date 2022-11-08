import 'package:flutter/material.dart';

Widget emptyCharacterSpace(String character) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 6),
    child: Column(
      children: [
        Container(
          child: Text(
            character,
            style: TextStyle(color: Colors.white, fontSize: 30),
          ),
        ),
        Container(
          width: 30,
          decoration:
              BoxDecoration(border: Border.all(color: Colors.grey, width: 2)),
        )
      ],
    ),
  );
}

//////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////Extra Widgets for cleanliness ////////////////////////////////////////////////

PreferredSizeWidget myappbar({required int level}) {
  return AppBar(
    toolbarHeight: 45,
    backgroundColor: Colors.transparent,
    elevation: 0,
    leading: const Icon(
      Icons.menu,
      size: 40,
      color: Color.fromARGB(255, 45, 154, 243),
    ),
    actions: [
      ElevatedButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(
                const Color.fromARGB(255, 25, 199, 31))),
        onPressed: () {},
        child: Text('Level $level'),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: ElevatedButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.purple)),
            onPressed: () {},
            child: const Text('60')),
      ),
    ],
  );
}
