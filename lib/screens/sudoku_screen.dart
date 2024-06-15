import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:sudoku/models/sudoku/sudoku_model.dart';
import 'package:sudoku/widgets/sudoku/restart_dialog.dart';
import 'package:sudoku/widgets/sudoku/sudoku_button.dart';
import 'dart:async'; 
import 'package:sudoku/utils/high_score/high_scores_manager.dart';
import 'package:vibration/vibration.dart';
import 'package:sudoku/utils/sudoku/other_utils.dart';

class SudokuScreen extends StatefulWidget {
  final int lives;
  final String difficulty;
  final bool music;
  final bool vibration;
  
  SudokuScreen(this.lives, this.difficulty, this.music, this.vibration);
  @override
  _SudokuScreenState createState() => _SudokuScreenState();
}

class _SudokuScreenState extends State<SudokuScreen> {
  late SudokuModel sudokuModel;
  bool onNotes = false;
  bool onPause = false;

  late Timer _timer;
  int _elapsedSeconds = 0;
  final AudioPlayer audioPlayer = AudioPlayer();

  @override
  void initState() {
    sudokuModel = SudokuModel(widget.lives, widget.difficulty);
    super.initState();
    startTimer();
  }

  void resetGame(){
    setState(() {
      sudokuModel.resetGame();
    });
    _timer.cancel();
    startTimer();
  }

  void startTimer() {
    _elapsedSeconds = 0;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if(!onPause){
          _elapsedSeconds++;
        }
      });
    });
  }
  
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double cellSize = (screenWidth - 40) / 9;
    return Scaffold(
      appBar: AppBar(
        title: Text('Sudoku'),
        actions: [
          DropdownButton<String>(
                value: sudokuModel.difficulty,
                onChanged: (String? newValue) {
                  setState(() {
                    sudokuModel.difficulty = newValue!;
                    resetGame();
                  });
                },
                items: <String>['easy', 'medium', 'hard']
                    .map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
              ),
          SudokuButton(
            iconData: Icons.pause,
            initialState: false,
            onChanged: (value) {
              onPause = !onPause;
              sudokuModel.resetColAndRow();
            },
          ),
          SudokuButton(
            iconData: Icons.edit,
            initialState: false,
            onChanged: (value) {
              onNotes = !onNotes;
            },
          ),
        ],
      ),
      body: Center(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Time: ${OtherUtils.getFormattedTime(_elapsedSeconds)}',
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 20),
              const Text(
                'Sudoku Board',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Column(
                children: List.generate(
                  9,
                  (rowIndex) => Row(
                    children: List.generate(
                      9,
                      (colIndex) {
                        return GestureDetector(
                          onTap: () {
                            if(!onPause){
                              _selectCell(rowIndex, colIndex);
                            }
                          },
                            onLongPress: () {
                            if(!onPause && sudokuModel.selectedRow == rowIndex && sudokuModel.selectedCol == colIndex
                                && sudokuModel.sudokuBoard[rowIndex][colIndex] != 0
                                && !sudokuModel.isNumberCorrect(rowIndex, colIndex)){
                                sudokuModel.sudokuBoard[rowIndex][colIndex] = 0;
                            }
                          },
                          child: Container(
                            width: cellSize,
                            height: cellSize,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              border: Border(
                                top: _getBorderSideWeight(rowIndex, colIndex, 1),
                                bottom: _getBorderSideWeight(rowIndex, colIndex, 2),
                                left: _getBorderSideWeight(rowIndex, colIndex, 3),
                                right: _getBorderSideWeight(rowIndex, colIndex, 4),
                              ),
                              color: _getCellColor(rowIndex, colIndex),
                            ),
                            child: onPause ? const Text('') : Text(
                              (sudokuModel.sudokuBoard[rowIndex][colIndex] == 0 ? sudokuModel.notes[rowIndex][colIndex].isEmpty ?
                               '' : OtherUtils.sortAndJoin(sudokuModel.notes[rowIndex][colIndex]) : sudokuModel.sudokuBoard[rowIndex][colIndex].toString()),
                              style: TextStyle(
                                fontSize: cellSize * (sudokuModel.notes[rowIndex][colIndex].isNotEmpty && sudokuModel.sudokuBoard[rowIndex][colIndex] == 0 ? 0.23 : 0.5),
                                color: sudokuModel.isNumberCorrect(rowIndex, colIndex) || sudokuModel.sudokuBoard[rowIndex][colIndex] == 0 ? Colors.black : Colors.red,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  sudokuModel.lives > 0 ? sudokuModel.lives : 0, 
                  (index) => const Icon(
                    Icons.favorite,
                    color: Colors.red,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  for (int row = 0; row < 3; row++)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        for (int col = 1 + row * 3; col <= 3 + row * 3; col++)
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: SizedBox(
                              width: 80,
                              height: 50,
                              child: ElevatedButton(
                                onPressed: sudokuModel.isNumberMissing(col) ? null : () {
                                  _insertNumber(col);
                                },
                                style: ButtonStyle(
                                  backgroundColor: onNotes && !onPause && !sudokuModel.isNumberMissing(col) ? sudokuModel.isValidCell() 
                                  && sudokuModel.notes[sudokuModel.selectedRow][sudokuModel.selectedCol].contains(col)
                                      ? MaterialStateProperty.all(Colors.blue)
                                      : MaterialStateProperty.all(Colors.grey) : null,
                                ),
                                child: Text(col.toString()),
                              ),
                            ),
                          ),
                      ],
                    ),
                ],
              ),
            ]
          ),
        ),
      ),
    );
  }

  Color _getCellColor(int rowIndex, int colIndex) {
    final int selectedRow = sudokuModel.selectedRow;
    final int selectedCol = sudokuModel.selectedCol;
    
    if(!selectedRow.isNegative && !selectedCol.isNegative){
      if(rowIndex == selectedRow && colIndex == selectedCol){
        return Colors.grey;
      }
      if(sudokuModel.sudokuBoard[rowIndex][colIndex] == sudokuModel.sudokuBoard[selectedRow][selectedCol] 
          && sudokuModel.sudokuBoard[rowIndex][colIndex] != 0){ 
          return Color.fromARGB(255, 216, 205, 205);
        }
      if((selectedRow ~/ 3 == rowIndex ~/ 3 && selectedCol ~/3 == colIndex ~/ 3)
          || (selectedCol == colIndex) || (selectedRow == rowIndex)){
        return Colors.blue[50]!;
      }
    }
    bool isGray = (rowIndex ~/ 3 + colIndex ~/ 3) % 2 == 1;
    return isGray ? Colors.white : Colors.grey[200]!;
  }

  BorderSide _getBorderSideWeight(int rowIndex, int colIndex, int direction) {
    final bool isTop = rowIndex == 0;
    final bool isBottom = rowIndex == 8;
    final bool isLeft = colIndex == 0;
    final bool isRight = colIndex == 8;

    double borderWidth = 0.5;

    switch (direction) {
      case 1:
        if (!isTop && rowIndex % 3 == 0 || isTop) {
          borderWidth = isTop ? 2.0 : 1.0;
        }
        break;
      case 2:
        if (!isBottom && (rowIndex + 1) % 3 == 0 || isBottom) {
          borderWidth = isBottom ? 2.0 : 1.0;
        }
        break;
      case 3:
        if (!isLeft && colIndex % 3 == 0 || isLeft) {
          borderWidth = isLeft ? 2.0 : 1.0;
        }
        break;
      case 4:
        if (!isRight && (colIndex + 1) % 3 == 0 || isRight) {
          borderWidth = isRight ? 2.0 : 1.0;
        }
        break;
    }

    return BorderSide(
      color: Colors.black,
      width: borderWidth,
    );
  }

  void _selectCell(int rowIndex, int colIndex) {
    setState(() {
      final newRow = sudokuModel.selectedRow == rowIndex && sudokuModel.selectedCol == colIndex ? -1 : rowIndex;
      sudokuModel.selectedCol = sudokuModel.selectedRow == rowIndex && sudokuModel.selectedCol == colIndex ? -1 : colIndex;
      sudokuModel.selectedRow = newRow;
    });
  }

  void _insertNumber(int number) {
    setState(() {
      int handle = sudokuModel.handleInsert(onNotes, number);
      if(!handle.isNegative) _handleGameStatus(handle == 1);
    });
  }

  void _handleGameStatus(bool correct) {
    String sound = '';
    int vibration = 0;
    if(correct){
      sound = 'success';
      vibration = 100;
      if(sudokuModel.isEndGame()) _endGame(true);
    }else{
      sound = 'error';
      vibration = 300;
      sudokuModel.lives --;
    }
    if(widget.music) playMusic(sound);
    if(widget.vibration) Vibration.vibrate(duration: vibration);
    if(sudokuModel.lives == 0)  _endGame(false); 
  }

  void playMusic(String type) async{
    await audioPlayer.stop();
    await audioPlayer.play(AssetSource('${type}.wav'));
  }
  void _endGame(bool win) {
    _timer.cancel();
    if (win) {
      HighScoreManager().updateStats(sudokuModel.difficulty, 1, _elapsedSeconds);
    }
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return EndGameDialog(
          win: win,
          elapsedSeconds: _elapsedSeconds,
          lives: sudokuModel.lives,
          onPlayAgain: () {
            Navigator.of(context).pop();
            resetGame();
          },
          onExit: () {
            Navigator.popUntil(context, ModalRoute.withName('/'));
          },
        );
      },
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}