import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_pokemon_game/button.dart';
import 'package:flutter_pokemon_game/characters/boy.dart';
import 'package:flutter_pokemon_game/maps/littleRoot.dart';
import 'package:flutter_pokemon_game/maps/pokelab.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  /*
  VARIABLES
  */

  // littleroot
  double mapX = 0.125;
  double mapY = 0.65;

  // pokelab
  double labMapX = 0;
  double labMapY = 0;

  // boy character
  int boySpriteCount = 0;
  String boyDirection = 'Down';

  // game stuff
  String currentLocation = 'littleroot';
  double step = 0.25;

  // no mans land for littleroot
  List<List<double>> noMansLandLittleroot = [
    [1.33, -0.1],
    [1.08, -0.1],
    [0.83, -0.1],
    [0.58, -0.1],
    [0.33, -0.1],
    [0.08, -0.1],
    [0.83, 0.149],
    [-0.1, 1.33],
    [-0.1, 1.08],
    [-0.1, 0.83],
    [-0.1, 0.58],
    [-0.1, 0.33],
    [-0.1, 0.08],
    [-0.1, 0.839],
  ];

  void moveUp() {
    boyDirection = 'Up';
    if (currentLocation == 'littleroot') {
      if (canMoveTo(boyDirection, noMansLandLittleroot, mapX, mapY)) {
        setState(() {
          mapY += step;
        });
      }
      if (double.parse((mapX).toStringAsFixed(4)) == 0.375 &&
          double.parse((mapY).toStringAsFixed(4)) == -0.6) {
        setState(() {
          currentLocation = 'pokelab';
          labMapX = 0;
          labMapY = -2.73;
        });
      }
      animateWalk();
    }
  }

  void moveRight() {
    boyDirection = 'Right';
    if (currentLocation == 'littleroot') {
      if (canMoveTo(boyDirection, noMansLandLittleroot, mapX, mapY)) {
        setState(() {
          mapX -= step;
        });
      }
      animateWalk();
    }
  }

  void moveDown() {
    boyDirection = 'Down';
    if (currentLocation == 'littleroot') {
      if (canMoveTo(boyDirection, noMansLandLittleroot, mapX, mapY)) {
        setState(() {
          mapY -= step;
        });
      }
      animateWalk();
    }
  }

  void moveLeft() {
    boyDirection = 'Left';

    if (currentLocation == 'littleroot') {
      if (canMoveTo(boyDirection, noMansLandLittleroot, mapX, mapY)) {
        setState(() {
          mapX += step;
        });
      }
      animateWalk();
    }
  }

  void pressedA() {}
  void pressedB() {}

  void animateWalk() {
    print('x:' + mapX.toString() + ', y:' + mapY.toString());

    Timer.periodic(Duration(milliseconds: 50), (timer) {
      setState(() {
        boySpriteCount++;
      });
      if (boySpriteCount == 3) {
        boySpriteCount = 0;
        timer.cancel();
      }
    });
  }

  bool canMoveTo(String direction, var noMansLand, double x, double y) {
    double stepX = step;
    double stepY = 0;

    if (direction == 'Left') {
      stepX = step;
      stepY = 0;
    } else if (direction == 'Right') {
      stepX = -step;
      stepY = 0;
    } else if (direction == 'Up') {
      stepX = 0;
      stepY = step;
    } else if (direction == 'Down') {
      stepX = 0;
      stepY = -step;
    }

    for (int i = 0; i < noMansLand.length; i++) {
      if (((noMansLand[i][0]) == (x + stepX)) &&
          ((noMansLand[i][1]) == (y + stepY))) {
        return false;
      }
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        AspectRatio(
          aspectRatio: 1,
          child: Container(
            color: Colors.black,
            child: Stack(
              children: [
                //littleroot
                LittleRoot(
                  x: mapX,
                  y: mapY,
                  currentMap: currentLocation,
                ),
                // pokelab
                MyPokeLab(x: labMapX, y: labMapY, currentMap: currentLocation),
                // boy character
                Container(
                  alignment: Alignment(0, 0),
                  child: MyBoy(
                    location: currentLocation,
                    boySpriteCount: boySpriteCount,
                    direction: boyDirection,
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: Container(
            color: Colors.grey[900],
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'G A M E B O Y',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      Text(
                        '  ???  ',
                        style: TextStyle(color: Colors.red, fontSize: 20),
                      ),
                      Text(
                        'F L U T T E R',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        children: [
                          Column(
                            children: [
                              Container(
                                height: 50,
                                width: 50,
                              ),
                              MyButton(
                                text: '???',
                                function: moveLeft,
                              ),
                              Container(
                                height: 50,
                                width: 50,
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              MyButton(
                                text: '???',
                                function: moveUp,
                              ),
                              Container(
                                height: 50,
                                width: 50,
                              ),
                              MyButton(
                                text: '???',
                                function: moveDown,
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Container(
                                height: 50,
                                width: 50,
                              ),
                              MyButton(
                                text: '???',
                                function: moveRight,
                              ),
                              Container(
                                height: 50,
                                width: 50,
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Column(
                            children: [
                              Container(
                                height: 50,
                                width: 50,
                              ),
                              MyButton(
                                text: 'B',
                                function: pressedB,
                              )
                            ],
                          ),
                          Column(
                            children: [
                              MyButton(
                                text: 'A',
                                function: pressedA,
                              ),
                              Container(
                                height: 50,
                                width: 50,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  const Text(
                    'C R E A T E D  B Y  T R A V I S',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    ));
  }
}
