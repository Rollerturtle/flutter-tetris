import 'package:tetris/board.dart';
import 'package:tetris/values.dart';
import 'dart:ui';

class Piece {
  Tetromino type;

  Piece({required this.type});

  List<int> position = [];

  Color get color{
    return tetrominoColors[type] ?? 
      const Color(0xFFFFFFFF);
  }

  void initializePiece() {
    switch (type) {
      case Tetromino.L:
        position = [-26, -16, -6, -5];
        break;
      case Tetromino.J:
        position = [-25, -15, -5, -6];
        break;
      case Tetromino.I:
        position = [-4, -5, -6, -7];
        break;
      case Tetromino.O:
        position = [-15, -16, -5, -6];
        break;
      case Tetromino.S:
        position = [-15, -14, -6, -5];
        break;
      case Tetromino.Z:
        position = [-17, -16, -6, -5];
        break;
      case Tetromino.T:
        position = [-26, -16, -6, -15];
        break;
      default:
    }
  }

  void movePiece(Direction direction) {
    switch (direction) {
      case Direction.down:
        for (int i = 0; i < position.length; i++) {
          position[i] += rowLength;
        }
        break;
      case Direction.left:
        for (int i = 0; i < position.length; i++) {
          position[i] -= 1;
        }
        break;
      case Direction.right:
        for (int i = 0; i < position.length; i++) {
          position[i] += 1;
        }
        break;
      default:
    }
  }

  //muter piece
  int rotationState = 1;
  void rotatePiece(){

    //posisi baru
    List<int> newPosition = [];

    //rotasi berdasarkan tipe
    switch(type){

      //piece L
      case Tetromino.L:
      switch(rotationState){
        case 0:
        newPosition=[
          position[1] - rowLength,
          position[1],
          position[1] + rowLength,
          position[1] + rowLength + 1,
        ];

        if(piecePosisitionIsValid(newPosition)){
          //update posisi
        position = newPosition;
        //update state rotasi
        rotationState = (rotationState+1) % 4;
        }
        break;
      
      case 1:
       newPosition=[
          position[1] - 1,
          position[1],
          position[1] + 1,
          position[1] + rowLength - 1,
        ];

        if(piecePosisitionIsValid(newPosition)){
          //update posisi
        position = newPosition;
        //update state rotasi
        rotationState = (rotationState+1) % 4;
        }
        break;

        case 2:
        newPosition=[
          position[1] + rowLength,
          position[1],
          position[1] - rowLength,
          position[1] + rowLength - 1,
        ];

       if(piecePosisitionIsValid(newPosition)){
          //update posisi
        position = newPosition;
        //update state rotasi
        rotationState = (rotationState+1) % 4;
        }
        break;
      
        case 3:
        newPosition=[
          position[1] - rowLength + 1,
          position[1],
          position[1] + 1,
          position[1] - 1,
        ];

       if(piecePosisitionIsValid(newPosition)){
          //update posisi
        position = newPosition;
        //update state rotasi
        rotationState = (rotationState+1) % 4;
        }
        break;
      }
      
      //piece J
      case Tetromino.J:
      switch(rotationState){
        case 0:
        newPosition=[
          position[1] - rowLength,
          position[1],
          position[1] + rowLength,
          position[1] + rowLength - 1,
        ];

        if(piecePosisitionIsValid(newPosition)){
          //update posisi
        position = newPosition;
        //update state rotasi
        rotationState = (rotationState+1) % 4;
        }
        break;
      
      case 1:
       newPosition=[
          position[1] - rowLength - 1,
          position[1],
          position[1] - 1,
          position[1] + 1,
        ];

        if(piecePosisitionIsValid(newPosition)){
          //update posisi
        position = newPosition;
        //update state rotasi
        rotationState = (rotationState+1) % 4;
        }
        break;

        case 2:
        newPosition=[
          position[1] + rowLength,
          position[1],
          position[1] - rowLength,
          position[1] - rowLength + 1,
        ];

       if(piecePosisitionIsValid(newPosition)){
          //update posisi
        position = newPosition;
        //update state rotasi
        rotationState = (rotationState+1) % 4;
        }
        break;
      
        case 3:
        newPosition=[
          position[1] + 1,
          position[1],
          position[1] - 1,
          position[1] + rowLength + 1,
        ];

       if(piecePosisitionIsValid(newPosition)){
          //update posisi
        position = newPosition;
        //update state rotasi
        rotationState = (rotationState+1) % 4;
        }
        break;
      }

      //======2
       case Tetromino.I:
      switch(rotationState){
        case 0:
        newPosition=[
          position[1] - 1,
          position[1],
          position[1] + 1,
          position[1] + 2,
        ];

        if(piecePosisitionIsValid(newPosition)){
          //update posisi
        position = newPosition;
        //update state rotasi
        rotationState = (rotationState+1) % 4;
        }
        break;
      
      case 1:
       newPosition=[
          position[1] - 1,
          position[1],
          position[1] + rowLength,
          position[1] + rowLength + 2,
        ];

        if(piecePosisitionIsValid(newPosition)){
          //update posisi
        position = newPosition;
        //update state rotasi
        rotationState = (rotationState+1) % 4;
        }
        break;

        case 2:
        newPosition=[
          position[1] + 1,
          position[1],
          position[1] - 1,
          position[1] - 2,
        ];

       if(piecePosisitionIsValid(newPosition)){
          //update posisi
        position = newPosition;
        //update state rotasi
        rotationState = (rotationState+1) % 4;
        }
        break;
      
        case 3:
        newPosition=[
          position[1] + rowLength,
          position[1],
          position[1] - rowLength,
          position[1] - 2 * rowLength,
        ];

       if(piecePosisitionIsValid(newPosition)){
          //update posisi
        position = newPosition;
        //update state rotasi
        rotationState = (rotationState+1) % 4;
        }
        break;
      }
      
      //=====3 OOOOOO
      case Tetromino.O:
      break;

      //=====4
       case Tetromino.S:
      switch(rotationState){
        case 0:
        newPosition=[
          position[1],
          position[1] + 1,
          position[1] - rowLength - 1,
          position[1] + rowLength
        ];

        if(piecePosisitionIsValid(newPosition)){
          //update posisi
        position = newPosition;
        //update state rotasi
        rotationState = (rotationState+1) % 4;
        }
        break;
      
      case 1:
       newPosition=[
          position[0] - rowLength,
          position[0],
          position[0] + 1,
          position[0] + rowLength + 1,
        ];

        if(piecePosisitionIsValid(newPosition)){
          //update posisi
        position = newPosition;
        //update state rotasi
        rotationState = (rotationState+1) % 4;
        }
        break;

        case 2:
        newPosition=[
          position[1],
          position[1] + 1,
          position[1] + rowLength - 1,
          position[1] + rowLength,
        ];

       if(piecePosisitionIsValid(newPosition)){
          //update posisi
        position = newPosition;
        //update state rotasi
        rotationState = (rotationState+1) % 4;
        }
        break;
      
        case 3:
        newPosition=[
          position[0] - rowLength,
          position[0],
          position[0] + 1,
          position[0] - rowLength + 1,
        ];

       if(piecePosisitionIsValid(newPosition)){
          //update posisi
        position = newPosition;
        //update state rotasi
        rotationState = (rotationState+1) % 4;
        }
        break;
      }

       case Tetromino.Z:
      switch(rotationState){
        case 0:
        newPosition=[
          position[0] + rowLength - 2,
          position[1],
          position[2] + rowLength - 1,
          position[3] + 1,
        ];

        if(piecePosisitionIsValid(newPosition)){
          //update posisi
        position = newPosition;
        //update state rotasi
        rotationState = (rotationState+1) % 4;
        }
        break;
      
      case 1:
       newPosition=[
          position[1] - rowLength + 2,
          position[1],
          position[1] - rowLength + 1,
          position[1] - 1,
        ];

        if(piecePosisitionIsValid(newPosition)){
          //update posisi
        position = newPosition;
        //update state rotasi
        rotationState = (rotationState+1) % 4;
        }
        break;

        case 2:
        newPosition=[
          position[0] + rowLength - 2,
          position[1],
          position[2] - rowLength - 1,
          position[3] + 1,
        ];

       if(piecePosisitionIsValid(newPosition)){
          //update posisi
        position = newPosition;
        //update state rotasi
        rotationState = (rotationState+1) % 4;
        }
        break;
      
        case 3:
        newPosition=[
          position[1] - rowLength + 2,
          position[1],
          position[1] + rowLength + 1,
          position[1] - 1,
        ];

       if(piecePosisitionIsValid(newPosition)){
          //update posisi
        position = newPosition;
        //update state rotasi
        rotationState = (rotationState+1) % 4;
        }
        break;
      }

       case Tetromino.T:
      switch(rotationState){
        case 0:
        newPosition=[
          position[2] - rowLength,
          position[2],
          position[2] + 1,
          position[2] + rowLength,
        ];

        if(piecePosisitionIsValid(newPosition)){
          //update posisi
        position = newPosition;
        //update state rotasi
        rotationState = (rotationState+1) % 4;
        }
        break;
      
      case 1:
       newPosition=[
          position[1] - 1,
          position[1],
          position[1] + 1,
          position[1] + rowLength,
        ];

        if(piecePosisitionIsValid(newPosition)){
          //update posisi
        position = newPosition;
        //update state rotasi
        rotationState = (rotationState+1) % 4;
        }
        break;

        case 2:
        newPosition=[
          position[1] - rowLength,
          position[1] - 1,
          position[1] ,
          position[1] + rowLength,
        ];

       if(piecePosisitionIsValid(newPosition)){
          //update posisi
        position = newPosition;
        //update state rotasi
        rotationState = (rotationState+1) % 4;
        }
        break;
      
        case 3:
        newPosition=[
          position[2] - rowLength,
          position[2] - 1,
          position[2],
          position[2] + 1,
        ];

       if(piecePosisitionIsValid(newPosition)){
          //update posisi
        position = newPosition;
        //update state rotasi
        rotationState = (rotationState+1) % 4;
        }
        break;
      }
      break;
    }
  }

  bool posisitionIsValid(int position){
    //ambil row & col
    int row = (position / rowLength).floor();
    int col = position %rowLength;

    if(row<0 || col < 0 || gameBoard[row][col] != null){
      return false;
    }else{
      return true;
    }
  }

  bool piecePosisitionIsValid(List<int> piecePosition){
    bool firstColOccupied = false;
    bool lastColOccupied = false;

    for(int pos in piecePosition){
      if(!posisitionIsValid(pos)){
        return false;
      }

      //cek posisi kolom yang diisi
      int col = pos % rowLength;
      if(col == 0 ){
        firstColOccupied = true;
      }
      if(col == rowLength - 1){
        lastColOccupied = true;
      }
    }

    return !(firstColOccupied && lastColOccupied);
  }
}


