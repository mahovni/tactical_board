import 'package:flutter/material.dart';
import 'package:board/widgets/draggable_icon.dart';
import 'package:board/widgets/painter.dart';

void main() {
  runApp(const MaterialApp(debugShowCheckedModeBanner: false, home: Board()));
}

class Board extends StatefulWidget {
  const Board({super.key});

  @override
  State<Board> createState() => _BoardState();
}

class _BoardState extends State<Board> {
  late bool canPaint;

  @override
  void initState() {
    super.initState();
    canPaint = false;
  }

  void _reset() {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => const Board(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Image> iconsRed = [
      Image.asset(scale: 8.0, 'images/red1.png'),
      Image.asset(scale: 8.0, 'images/red2.png'),
      Image.asset(scale: 8.0, 'images/red3.png'),
      Image.asset(scale: 8.0, 'images/red4.png'),
      Image.asset(scale: 8.0, 'images/red5.png'),
      Image.asset(scale: 8.0, 'images/red6.png'),
      Image.asset(scale: 8.0, 'images/red7.png'),
      Image.asset(scale: 8.0, 'images/red8.png'),
      Image.asset(scale: 8.0, 'images/red9.png'),
      Image.asset(scale: 8.0, 'images/red10.png'),
      Image.asset(scale: 8.0, 'images/red11.png'),
    ];
    List<Image> iconsBlue = [
      Image.asset(scale: 8.0, 'images/blue1.png'),
      Image.asset(scale: 8.0, 'images/blue2.png'),
      Image.asset(scale: 8.0, 'images/blue3.png'),
      Image.asset(scale: 8.0, 'images/blue4.png'),
      Image.asset(scale: 8.0, 'images/blue5.png'),
      Image.asset(scale: 8.0, 'images/blue6.png'),
      Image.asset(scale: 8.0, 'images/blue7.png'),
      Image.asset(scale: 8.0, 'images/blue8.png'),
      Image.asset(scale: 8.0, 'images/blue9.png'),
      Image.asset(scale: 8.0, 'images/blue10.png'),
      Image.asset(scale: 8.0, 'images/blue11.png')
    ];
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                  Color.fromARGB(255, 152, 241, 143),
                  Color.fromARGB(255, 4, 110, 9),
                ])),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                    decoration: BoxDecoration(boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.4),
                        blurRadius: 10.0,
                        spreadRadius: 5.0,
                      )
                    ]),
                    child: Stack(
                      children: [
                        Image.asset('images/field.jpg'),
                        SizedBox(
                          height:
                              MediaQuery.of(context).size.width * (1637 / 1251),
                          width: MediaQuery.of(context).size.width,
                          child: IgnorePointer(
                            ignoring: !canPaint,
                            child: const Signature(
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                        onPressed: () {
                          setState(() {
                            _reset();
                          });
                        },
                        icon: const Icon(Icons.delete,
                            color: Colors.black, size: 35.0)),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          canPaint = !canPaint;
                        });
                      },
                      icon: Icon(
                        Icons.draw_sharp,
                        color: canPaint ? Colors.white : Colors.black,
                        size: 35.0,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(25),
            child: Stack(
              children: [for (var icon in iconsRed) DraggableIcon(child: icon)],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 70, 25),
            child: Stack(
              children: [
                for (var icon in iconsBlue) DraggableIcon(child: icon)
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 120, 25),
            child: DraggableIcon(
              child: Image.asset(
                'images/ball.png',
                scale: 15.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
