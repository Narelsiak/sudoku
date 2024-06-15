import 'dart:math';
 
class Sudoku {
  late int N;
  late int K;
  late int SRN;
  late List<List<int>> boardBefore;
  late List<List<int>> boardAfter;
 
  Sudoku(this.N, this.K) {
    double SRNd = sqrt(N.toDouble());
    SRN = SRNd.toInt();
    boardBefore = List.generate(N, (index) => List.filled(N, 0));
    fillValues();
  }
 
  void copy(){
    boardAfter = List.generate(9, (i) => List.generate(9, (j) => boardBefore[i][j]));
  }
 
  void fillValues() {
    fillDiagonal();
    fillRemaining(0, SRN);
    copy();
    removeKDigits();
  }
 
  void fillDiagonal() {
    for (int i = 0; i < N; i += SRN) {
      fillBox(i, i);
    }
  }
 
  bool unUsedInBox(int rowStart, int colStart, int num) {
    for (int i = 0; i < SRN; i++) {
      for (int j = 0; j < SRN; j++) {
        if (boardBefore[rowStart + i][colStart + j] == num) {
          return false;
        }
      }
    }
    return true;
  }
 
  void fillBox(int row, int col) {
    int num = 0;
    for (int i = 0; i < SRN; i++) {
      for (int j = 0; j < SRN; j++) {
        while (true) {
          num = randomGenerator(N);
          if (unUsedInBox(row, col, num)) {
            break;
          }
        }
        boardBefore[row + i][col + j] = num;
      }
    }
  }
 
  int randomGenerator(int num) {
    return Random().nextInt(num) + 1;
  }
 
  bool checkIfSafe(int i, int j, int num) {
    return (unUsedInRow(i, num) &&
        unUsedInCol(j, num) &&
        unUsedInBox(i - (i % SRN), j - (j % SRN), num));
  }
 
  bool unUsedInRow(int i, int num) {
    for (int j = 0; j < N; j++) {
      if (boardBefore[i][j] == num) {
        return false;
      }
    }
    return true;
  }
 
  bool unUsedInCol(int j, int num) {
    for (int i = 0; i < N; i++) {
      if (boardBefore[i][j] == num) {
        return false;
      }
    }
    return true;
  }
 
  bool fillRemaining(int i, int j) {
    if (i == N - 1 && j == N) {
      return true;
    }
 
    if (j == N) {
      i++;
      j = 0;
    }
 
    if (boardBefore[i][j] != 0) {
      return fillRemaining(i, j + 1);
    }
 
    for (int num = 1; num <= N; num++) {
      if (checkIfSafe(i, j, num)) {
        boardBefore[i][j] = num;
        if (fillRemaining(i, j + 1)) {
          return true;
        }
        boardBefore[i][j] = 0;
      }
    }
    return false;
  }
 
  void removeKDigits() {
    int count = K;
 
    while (count != 0) {
      int i = randomGenerator(N) - 1;
      int j = randomGenerator(N) - 1;
      if (boardAfter[i][j] != 0) {
        count--;
        boardAfter[i][j] = 0;
      }
    }
  }
}
