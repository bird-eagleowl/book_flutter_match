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
              // match5
              // 그리드 onTap 용 함수 추가
              _flipCard(index);
            },
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

  // match5
  // 그리드 탭한 내용 확인
  // debugPrint로 선택한 카드 내용 확인하기
  void _flipCard(int index) {
    debugPrint('$index : ${cardList[index]}');
  }

  void _startGame() {
    setState(() {
      cardList.shuffle();
    });
  }
}
