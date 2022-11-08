import 'package:colorguessinggame/widgets.dart';
import 'package:flutter/material.dart';

import 'database.dart';

class Home extends StatefulWidget {
  const Home(
      {super.key,
      required this.pageindex,
      required this.color,
      required this.name,
      required this.database});

  final int pageindex;
  final AppDatabase database;
  final int color;
  final String name;

  @override
  State<Home> createState() => _HomeState(
      database: database,
      name: name,
      color: color,
      currentpageindex: pageindex);
}

class _HomeState extends State<Home> {
  _HomeState(
      {required this.database,
      required this.color,
      required this.name,
      required this.currentpageindex});
  List randomcharacters = [];
  List<String> inputlist = [];
  List allchar = [
  'A',
  'B',
  'C',
  'D',
  'E',
  'F',
  'G',
  'H',
  'I',
  'J',
  'K',
  'L',
  'M',
  'N',
  'O',
  'P',
  'Q',
  'R',
  'S',
  'T',
  'U',
  'V',
  'W',
  'X',
  'Y',
  'Z'
];

  final int currentpageindex;
  final AppDatabase database;
  final int color;
  final String name;

  @override
  void initState() {
    super.initState();
    generaterandomcharacters();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 11, 94, 94),
      appBar: myappbar(level: currentpageindex),
      body: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        const Center(
          child: Padding(
            padding: EdgeInsets.only(top: 28.0, bottom: 5),
            child: Text(
              'Guess the color',
              style: TextStyle(color: Colors.white, fontSize: 23),
            ),
          ),
        ),
        Center(
          child: Container(
            width: 300,
            height: 300,
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(color: Color(color), boxShadow: const [
              BoxShadow(
                blurRadius: 5,
              )
            ]),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: generateemptychar(name.length, inputlist),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
          child: Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        const Color.fromARGB(255, 29, 189, 35))),
                onPressed: () {
                  List names = name.split('').toList();
                  names.shuffle();

                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('${names.join(' ')}'),
                  ));
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 35, vertical: 5),
                  child: Text(
                    'Hints',
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                )),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20.0, bottom: 25),
          child: SizedBox(
            height: 120,
            child: GridView.count(
              crossAxisCount: 7,
              children: List.generate(
                  14,
                  (index) =>
                      characterButton(character: randomcharacters[index])),
            ),
          ),
        )
      ]),
    );
  }

  void generaterandomcharacters() {
    allchar.shuffle();
    randomcharacters = allchar.take(14 - name.length).toList();
    randomcharacters.addAll(name.split(''));
    randomcharacters.shuffle();
  }

  Widget characterButton({required String character}) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: ElevatedButton(
          onPressed: () {
            setState(() {
              inputlist.add(character);
            });
            checkforwin(inputlist, currentpageindex, context, database);
          },
          style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all(Color.fromARGB(255, 255, 153, 0))),
          child: Text(
            character,
            style: const TextStyle(color: Colors.white, fontSize: 30),
          )),
    );
  }

  Future<void> checkforwin(List privateinputlist, int currentpageindex,
      BuildContext context, AppDatabase database) async {
    if (privateinputlist.length == name.length) {
      if (privateinputlist.join('') == name) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('${privateinputlist.join('')} is correct!!!'),
        ));

        Future.delayed(const Duration(seconds: 1));
        await database.colordao
            .findColorById(++currentpageindex)
            .first
            .then((value) {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: ((context) => Home(
                        database: database,
                        pageindex:
                            currentpageindex <= 9 ? ++currentpageindex : 0,
                        color: value!.color,
                        name: value.name,
                      ))));
        });
      } else {
        Future.delayed(Duration(milliseconds: 200)).then((value) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('${privateinputlist.join('')} is wrong spelling!!!'),
          ));
          setState(() {
            inputlist = [];
          });
        });
      }
    }
  }
}

List<Widget> generateemptychar(int namelength, List inputlist) {
  List<Widget> val = [];
  for (var i = 0; i < namelength; i++) {
    try {
      val.add(emptyCharacterSpace(inputlist[i]));
    } catch (e) {
      val.add(emptyCharacterSpace(''));
    }
  }
  return val;
}
