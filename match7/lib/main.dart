import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
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

  List<bool> flippedCards = [];

  @override
  void initState() {
    super.initState();
    _startGame();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('같은 카드 찾기 게임'),
        actions: [
          IconButton(
            icon: const Icon(Icons.replay),
            onPressed: () {
              _startGame();
            },
          ),
        ],
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
        ),
        itemCount: cardList.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              _flipCard(index);
            },
            child: Container(
              margin: const EdgeInsets.all(4),
              color: flippedCards[index] ? Colors.blue : Colors.grey,
              child: Center(
                child: Text(
                  flippedCards[index] ? cardList[index] : '',
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

  void _flipCard(int index) {
    setState(() {
      flippedCards[index] = !flippedCards[index];
    });

    // match7
    // 모든 카드 앞면이면 게임 클리어
    // 다이알로그 보여주고 게임 다시 하기
    if (flippedCards.every((card) => card)) {
      debugPrint("종료 새롭게 시작하기");
      _showGameCompleteDialog();
    }
  }

  // match7
  // 게임 성공 다이알로그 보여주기
  void _showGameCompleteDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('성공'),
          content: const Text('축하합니다! 퀴즈 풀이에 성공했습니다.'),
          actions: [
            TextButton(
              onPressed: () {
                _startGame();
                Navigator.pop(context);
              },
              child: const Text('게임 하기'),
            ),
          ],
        );
      },
    );
  }

  void _startGame() {
    setState(() {
      flippedCards = List<bool>.generate(12, (index) => false);
      cardList.shuffle();
    });
  }
}
