import 'package:flutter/material.dart';
import 'package:sudoku/utils/sudoku/other_utils.dart';

class EndGameDialog extends StatelessWidget {
  final bool win;
  final int elapsedSeconds;
  final int lives;
  final Function() onPlayAgain;
  final Function() onExit;

  const EndGameDialog({
    required this.win,
    required this.elapsedSeconds,
    required this.lives,
    required this.onPlayAgain,
    required this.onExit,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: win ? Text("Success!") : Text("Defeat!"),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (win)
            Text('Time: ${OtherUtils.getFormattedTime(elapsedSeconds)}\n${lives > 0 ? "Left lives $lives" : ""}'),
          Text('Do you want to play again?'),
        ],
      ),
      actions: [
        TextButton(
          onPressed: onPlayAgain,
          child: Text("Yes"),
        ),
        TextButton(
          onPressed: onExit,
          child: Text("No"),
        ),
      ],
    );
  }
}
