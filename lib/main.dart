import 'package:flutter/material.dart';
import 'package:flutter_stateless_chessboard/flutter_stateless_chessboard.dart';
import 'package:get/get.dart';

void main() {
  runApp(GetMaterialApp(home: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.brown,
        appBarTheme: const AppBarTheme(
          iconTheme: IconThemeData(color: Colors.black),
          color: Colors.brown,
        ),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class TurnController extends GetxController {
  RxString fen = "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1".obs;

  final boardNumber = 1.obs;

  void updateFen(String newFen) {
    fen.value = newFen;
  }

  TurnController(int player) {
    boardNumber.value = player;
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Roman\'s Chessboard 🍄',
              style: TextStyle(fontSize: 60, color: Colors.brown),
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GetX<TurnController>(
                  tag: "board1",
                  init: TurnController(1),
                  builder: (controller) {
                    return Column(
                      children: [
                        Chessboard(
                          size: 350,
                          fen: controller.fen.value,
                          orientation: BoardColor.WHITE,
                          lightSquareColor:
                              const Color.fromRGBO(240, 217, 181, 1),
                          darkSquareColor:
                              const Color.fromRGBO(181, 136, 99, 1),
                        ),
                        const SizedBox(
                          height: 27,
                        ),
                        Container(
                          height: 60,
                          decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [
                                  Color.fromRGBO(200, 177, 141, 1),
                                  Color.fromRGBO(181, 136, 99, 1)
                                ],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(25.0),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.pink.withOpacity(0.2),
                                  spreadRadius: 4,
                                  blurRadius: 10,
                                  offset: Offset(0, 3),
                                )
                              ]),
                          child: ElevatedButton(
                            onPressed: () async {
                              controller.updateFen(await Get.to(
                                  () => FenPage(fen: controller.fen.value)));
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Colors.transparent,
                              shadowColor: Colors.transparent,
                              elevation: 10,
                              padding: const EdgeInsets.all(8.0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            child: const Text(
                              "Change FEN",
                              style: TextStyle(fontSize: 40),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
                const SizedBox(
                  width: 50,
                ),
                GetX<TurnController>(
                  tag: "board2",
                  init: TurnController(2),
                  builder: (controller) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Chessboard(
                          size: 350,
                          fen: controller.fen.value,
                          orientation: BoardColor.WHITE,
                          lightSquareColor:
                              const Color.fromRGBO(240, 217, 181, 1),
                          darkSquareColor:
                              const Color.fromRGBO(181, 136, 99, 1),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        Container(
                          height: 60,
                          decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [
                                  Color.fromRGBO(200, 177, 141, 1),
                                  Color.fromRGBO(181, 136, 99, 1)
                                ],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(25.0),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.pink.withOpacity(0.2),
                                  spreadRadius: 4,
                                  blurRadius: 10,
                                  offset: Offset(0, 3),
                                )
                              ]),
                          child: ElevatedButton(
                            onPressed: () async {
                              controller.updateFen(await Get.to(
                                  () => FenPage(fen: controller.fen.value)));
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Colors.transparent,
                              shadowColor: Colors.transparent,
                              elevation: 10,
                              padding: const EdgeInsets.all(8.0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: const Text(
                              "Change FEN",
                              style: TextStyle(fontSize: 40),
                            ),
                          ),
                        )
                      ],
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class FenPage extends StatefulWidget {
  final String fen;

  FenPage({required this.fen});

  @override
  State<FenPage> createState() => FenPageState();
}

class FenPageState extends State<FenPage> {
  final TextEditingController _textEditingController = TextEditingController();
  String get fen => widget.fen;
  @override
  void initState() {
    super.initState();
    _textEditingController.text = fen;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'FEN Page',
        ),
        backgroundColor: const Color.fromRGBO(181, 136, 99, 1),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Enter FEN:',
                style: TextStyle(
                    fontSize: 30, color: Color.fromRGBO(181, 136, 99, 1))),
            TextField(
              controller: _textEditingController,
              decoration: const InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide:
                      BorderSide(color: Color.fromRGBO(181, 136, 99, 1)),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide:
                      BorderSide(color: Color.fromRGBO(181, 136, 99, 1)),
                ),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Container(
              height: 60,
              decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color.fromRGBO(200, 177, 141, 1),
                      Color.fromRGBO(181, 136, 99, 1)
                    ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(25.0),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.pink.withOpacity(0.2),
                      spreadRadius: 4,
                      blurRadius: 10,
                      offset: Offset(0, 3),
                    )
                  ]),
              child: ElevatedButton(
                onPressed: () async {
                  Get.back(result: _textEditingController.text);
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.transparent,
                  shadowColor: Colors.transparent,
                  elevation: 10,
                  padding: const EdgeInsets.all(8.0),
                ),
                child: const Text(
                  "Change FEN",
                  style: TextStyle(fontSize: 40),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
