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
  // match8
  // 카드 맞추기 판정용 변수 추가
  // 첫번째 오픈 카드 위치
  // 두번째 오픈 카드 위치
  int? firstFlippedIndex;
  int? secondFlippedIndex;

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

  // match8
  // _flipCard 전반 적인 수정
  // 게임 로직을 완성한다.
  // 첫번째 카드와 두번째 카드를 비교 판정한다.
  void _flipCard(int index) {
    // 1. 이미 열려 있는 경우.
    // => 아무 것도 하지 않는다.
    // 2. 덥혀 있는 경우
    // 카드를 연다.(setState에서 처리한다.)
    // 2-1. 첫번째, 두번째 열린 카드 정보가 모두 없는 경우.
    // => 선택한 카드를 첫번째 열린 카드 정보에 저장한다.
    // 2-2. 첫번째 열린 카드 정보는 있고, 두번째 열린 카드 정보가 없는 경우.
    // => 선택한 카드를 두번째 열린 카드 정보에 저장한다.
    // 2-3. 첫번째, 두번째 열린 카드 정보가 모두 있는 경우
    // 기존에 열려 있는 첫번째 카드와 두번째 카드의 값이 같은지 체크.
    // 2-3-1 같은 경우.
    // => 기존의 첫번째 두번째 카드를 열린 상태로 둔다.
    // => 선택한 카드를 첫번째 열린 카드 정보에 저장한다.
    // => 두번째 열린 카드 정보를 삭제한다.
    // 2-3-2 다른 경우.
    // => 기존 첫번째 두번째 카드를 덥는다.
    // => 선택한 카드를 첫번째 열린 카드 정보에 저장한다.
    // => 두번째 열린 카드 정보를 삭제한다.
    // 2-4. 첫번째 열린 카드 정보가 없고, 두번째 열린 카드 정보가 있는 경우.
    // => 아무 것도 하지 않는다. (있을 수 없는 경우)

    if (flippedCards[index]) {
      debugPrint("1. 이미 열려 있는 경우");
      // 1. 이미 열려 있는 경우.
      // => 아무 것도 하지 않는다.
    } else {
      debugPrint("2. 덥혀 있는 경우");
      // 2. 덥혀 있는 경우
      if (firstFlippedIndex == null && secondFlippedIndex == null) {
        debugPrint("2-1. 경우");
        // 2-1. 첫번째, 두번째 열린 카드 정보가 모두 없는 경우.
        // => 선택한 카드를 첫번째 열린 카드 정보에 저장한다.
        firstFlippedIndex = index;
      } else if (firstFlippedIndex != null && secondFlippedIndex == null) {
        debugPrint("2-2. 경우");
        // 2-2. 첫번째 열린 카드 정보는 있고, 두번째 열린 카드 정보가 없는 경우.
        // => 선택한 카드를 두번째 열린 카드 정보에 저장한다.
        secondFlippedIndex = index;
      } else if (firstFlippedIndex != null && secondFlippedIndex != null) {
        debugPrint("2-3. 경우");
        // 2-3. 첫번째, 두번째 열린 카드 정보가 모두 있는 경우
        // 기존에 열려 있는 첫번째 카드와 두번째 카드의 값이 같은지 체크.
        if (cardList[firstFlippedIndex!] == cardList[secondFlippedIndex!]) {
          debugPrint("2-3-1. 경우");
          // 2-3-1 같은 경우.
          // => 기존의 첫번째 두번째 카드를 열린 상태로 둔다.
          // => 선택한 카드를 첫번째 열린 카드 정보에 저장한다.
          // => 두번째 열린 카드 정보를 삭제한다.
          firstFlippedIndex = index;
          secondFlippedIndex = null;
        } else {
          debugPrint("2-3-2. 경우");
          // 2-3-2 다른 경우.
          // => 기존 첫번째 두번째 카드를 덥는다.
          // => 선택한 카드를 첫번째 열린 카드 정보에 저장한다.
          // => 두번째 열린 카드 정보를 삭제한다.
          flippedCards[firstFlippedIndex!] = false;
          flippedCards[secondFlippedIndex!] = false;
          firstFlippedIndex = index;
          secondFlippedIndex = null;
        }
      } else {
        debugPrint("2-4. 경우");
        // 2-4. 첫번째 열린 카드 정보가 없고, 두번째 열린 카드 정보가 있는 경우.
        // => 아무 것도 하지 않는다. (있을 수 없는 경우)
      }
    }

    // setState를 이용해서 처리한 내용을 화면에 반영한다.
    setState(() {
      // 선택한 카드 연다.
      flippedCards[index] = true;
    });

    if (flippedCards.every((card) => card)) {
      debugPrint("종료 새롭게 시작하기");
      _showGameCompleteDialog();
    }
  }

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
      // match8
      // 첫번째 오픈 카드 위치 초기화
      // 두번째 오픈 카드 위치 초기화
      firstFlippedIndex = null;
      secondFlippedIndex = null;
      cardList.shuffle();
    });
  }
}
