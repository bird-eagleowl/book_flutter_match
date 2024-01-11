import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MemoryMatchGame(),
    );
  }
}

class MemoryMatchGame extends StatefulWidget {
  const MemoryMatchGame({super.key});

  @override
  State<MemoryMatchGame> createState() => _MemoryMatchGameState();
}

class _MemoryMatchGameState extends State<MemoryMatchGame> {
  List<String> cardList = [
    'A',
    'B',
    'C',
    'D',
    'E',
    'F',
    'A',
    'B',
    'C',
    'D',
    'E',
    'F',
  ];

  @override
  void initState() {
    // match3
    // 그리드 초기화 하기
    super.initState();
    _startGame();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('같은 카드 찾기 게임'),
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
        ),
        itemCount: cardList.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {},
            child: Container(
              margin: const EdgeInsets.all(4),
              color: Colors.blue,
              child: Center(
                child: Text(
                  cardList[index],
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _startGame() {
    setState(() {
      // match3
      // 카드 섞기
      cardList.shuffle();
    });
  }
}
