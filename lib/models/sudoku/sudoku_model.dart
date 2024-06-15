import 'package:sudoku/utils/sudoku/sudoku_generator.dart';
 
class SudokuModel {
  late List<List<int>> sudokuBoard;
  late List<List<int>> sudokuBoardFull;
  late List<List<List<int>>> notes;
  late int lives;
  late int _lives;
  late String difficulty;
  late int selectedRow;
  late int selectedCol;
 
  SudokuModel(this.lives, this.difficulty) {
    _lives = lives;
    sudokuBoard = [];
    sudokuBoardFull = [];
    notes = List.generate(9, (index) => List.generate(9, (index) => []));
    selectedRow = -1;
    selectedCol = -1;
    _generateSudoku();
  }
 
  void resetGame(){
    lives = _lives;
    selectedCol = -1;
    selectedRow = -1;
    notes = List.generate(9, (index) => List.generate(9, (index) => []));
    _generateSudoku();
  }
 
  void _generateSudoku() {
    Sudoku sudoku = Sudoku(9, _numberByDifficulty());
    sudokuBoard = sudoku.boardAfter;
    sudokuBoardFull = sudoku.boardBefore;
  }
 
  int _numberByDifficulty() {
    switch (difficulty) {
      case 'easy':
        return 2; //30
      case 'medium':
        return 40;
      case 'hard':
        return 50;
    }
    return 30;
  }
 
  bool isEndGame(){
    for (int row = 0; row < 9; row ++) {
      for (int col = 0; col < 9; col ++) {
        if (sudokuBoard[row][col] != sudokuBoardFull[row][col]) return false;
      }
    }
    return true;
  }
 
  bool isNumberCorrect(int rowIndex, int colIndex) {
    return sudokuBoard[rowIndex][colIndex] == sudokuBoardFull[rowIndex][colIndex];
  }
 
  bool checkNumber(int number, int row, int col) {
    return number == sudokuBoardFull[row][col];
  }
 
  bool isValidCell() {
    return selectedRow != -1 && selectedCol != -1;
  }
 
  bool isCellEmpty() {
    return sudokuBoard[selectedRow][selectedCol] == 0;
  }
 
  bool isNumberMissing(int number) {
    for (int row = 0; row < 9; row ++) {
      for (int col = 0; col < 9; col ++) {
        if ((sudokuBoard[row][col] == 0 || !isNumberCorrect(row, col)) &&
             checkNumber(number, row, col)){
          return false; 
        }
      }
    }
    return true;
  }
  
  void resetColAndRow() {
    selectedCol = -1;
    selectedRow = -1;
  }
 
  int handleInsert(bool onNotes, int number){
      int handle = -1;
      if (onNotes) {
        _handleNotesMode(number);
      } else {
        handle = _handleNormalMode(number);
      }
      return handle;
  }
 
  void _handleNotesMode(int number) {
    if (isValidCell() &&
    (isCellEmpty() || !isNumberCorrect(selectedRow, selectedCol))) {
      _toggleNoteEntry(number);
    }
  }
 
  void _toggleNoteEntry(int number) {
    sudokuBoard[selectedRow][selectedCol] = 0;
    final note = notes[selectedRow][selectedCol];
    if (note.contains(number)) {
      note.remove(number);
    } else {
      note.add(number);
    }
  }
 
  int _handleNormalMode(int number) {
    if (isValidCell() && 
    (isCellEmpty() || !isNumberCorrect(selectedRow, selectedCol))) {
      notes[selectedRow][selectedCol] = [];
        bool correct = _updateCell(number);
        return correct ? 1 : 0;
    }
    return -1;
  }
 
  bool _updateCell(int number) {
    sudokuBoard[selectedRow][selectedCol] = number;
    if(isNumberCorrect(selectedRow, selectedCol)){
      resetColAndRow();
      return true;
    }
    return false;
  }
}
