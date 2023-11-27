import 'dart:async';
import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:tetris/piece.dart';
import 'package:tetris/pixel.dart';
import 'package:tetris/values.dart';

List<List<Tetromino?>> gameBoard = List.generate(
  colLength,
  (i) => List.generate(
    rowLength,
    (j) => null,
  ),
);

class GameBoard extends StatefulWidget {
  const GameBoard({Key? key}) : super(key: key);

  @override
  _GameBoardState createState() => _GameBoardState();
}

class _GameBoardState extends State<GameBoard> {
  Piece currentPiece = Piece(type: Tetromino.S);

  int currentScore = 0 ;
  bool gameOver = false;

  @override
  void initState() {
    super.initState();

    startGame();
  }

  void startGame() {
    currentPiece.initializePiece();

    Duration frameRate = const Duration(milliseconds: 800);
    gameLoop(frameRate);
  }

  void gameLoop(Duration frameRate) {
    Timer.periodic(frameRate, (timer) {
      setState(() {
        clearLines();
        checkLanding();
        if(gameOver== true){
          timer.cancel();
          showGameOverDialog();
        }
        currentPiece.movePiece(Direction.down);
      });
    });
  }

//game over dialogue

void showGameOverDialog() {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text('Game Over'),
      content: Text("Skormu: $currentScore"),
      actions: [
        TextButton(
          onPressed: () {
            // Reset the game
            resetGame();
            Navigator.pop(context);
          },
          child: Text('Main Lagi'),
        ),
      ],
    ),
  );
}

//reset game
void resetGame(){
 gameBoard = List.generate(
    colLength,
    (i) => List.generate(
      rowLength,
      (j) => null,
    ),
  );
  gameOver = false;
  currentScore = 0;

  createNewPiece();
  startGame();
}

  bool checkCollision(Direction direction) {
    for (int i = 0; i < currentPiece.position.length; i++) {
      int row = (currentPiece.position[i] / rowLength).floor();
      int col = currentPiece.position[i] % rowLength;

      if (direction == Direction.left) {
        col -= 1;
      } else if (direction == Direction.right) {
        col += 1;
      } else if (direction == Direction.down) {
        row += 1;
      }

      if (row >= col || col < 0 || col >= rowLength) {
        return true;
      }
    }

    return false;
  }

  void checkLanding() {
    if (checkCollision(Direction.down)) {
      for (int i = 0; i < currentPiece.position.length; i++) {
        int row = (currentPiece.position[i] / rowLength).floor();
        int col = currentPiece.position[i] % rowLength;
        if (row >= 0 && col >= 0) {
          gameBoard[row][col] = currentPiece.type;
        }
      }

      createNewPiece();
    }
  }

  void createNewPiece() {
    Random rand = Random();

    Tetromino randomType =
        Tetromino.values[rand.nextInt(Tetromino.values.length)];
    currentPiece = Piece(type: randomType);
    currentPiece.initializePiece();

    if(isGameOver()){
      gameOver = true;
    }
  }

//gerak kiri
void moveLeft(){
if(!checkCollision(Direction.left)){
  setState(() {
    currentPiece.movePiece(Direction.left);
  });
}
}

//gerak kanan
void moveRight(){
if(!checkCollision(Direction.right)){
  setState(() {
    currentPiece.movePiece(Direction.right);
  });
}
}

//puter piece
void rotatePiece(){
  setState(() {
    currentPiece.rotatePiece();
  });
}


//clear line
void clearLines(){
 for(int row = colLength - 1; row>= 0 ; row--){
  bool rowIsFull = true;
  for(int col = 0 ; col < rowLength ;col++){
    if (gameBoard[row][col] == null){
      rowIsFull = false;
      break;
    }
  }
  if(rowIsFull){
    for(int r = row; r>0 ; r--){
      gameBoard[r] = List.from(gameBoard[r-1]);
    }

    gameBoard[0] = List.generate(row,(index) => null);
    currentScore++;
  }
 }
}

//gameover 
bool isGameOver(){
  for(int col=0; col<rowLength ; col++){
    if(gameBoard[0][col]!=null){
      return true;
    }
  }
return false;
}



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [

          //game Grid
          Expanded(
            child: GridView.builder(
                itemCount: rowLength * colLength,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: rowLength),
                itemBuilder: (context, index) {
                  int row = (index / rowLength).floor();
                  int col = index % rowLength;
          
                  if (currentPiece.position.contains(index)) {
                    return Pixel(color: currentPiece.color);
                  } else if (gameBoard[row][col] != null) {
                    final Tetromino? tetrominoType = gameBoard[row][col];
                    return Pixel(color: tetrominoColors[tetrominoType]);
                  } else {
                    return Pixel(color: Colors.grey);
                  }
                }),
          ),

          //skor
          Text('Skor: $currentScore',
          style: TextStyle(color: Colors.white),
          ),


          //control Game 
          Padding(
            padding: const EdgeInsets.only(bottom:50.0,top:50.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
              //kiri 
              IconButton(onPressed: moveLeft,color: Colors.white, icon: Icon(Icons.arrow_back_ios_new)),
          
              //putar
               IconButton(onPressed: rotatePiece,color: Colors.white,icon: Icon(Icons.rotate_right)),
               
               //kanan 
                IconButton(onPressed: moveRight,color: Colors.white,icon: Icon(Icons.arrow_forward_ios)),
            ],),
          )
        ],
      ),
    );
  }
}
