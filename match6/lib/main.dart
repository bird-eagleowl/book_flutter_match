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

  // match6
  // 카드 앞면 뒷면 상태.
  // true 앞면(알파벳 표시 : 파란색)
  // flase 뒷면(빈 문자 표시 : 회색)
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
              // match6
              // 앞면 파란색, 뒷면 회색
              color: flippedCards[index] ? Colors.blue : Colors.grey,
              child: Center(
                child: Text(
                  // match6
                  // 앞면 알파벳, 뒷면 빈 문자.
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
    // match6
    // 카드 뒤집기
    setState(() {
      flippedCards[index] = !flippedCards[index];
    });
  }

  void _startGame() {
    setState(() {
      // match6
      // 게임 시작 할 때는 모두 뒷면
      flippedCards = List<bool>.generate(12, (index) => false);
      cardList.shuffle();
    });
  }
}
