import 'package:flutter/material.dart';

class SudokuButton extends StatefulWidget {
  final bool initialState;
  final IconData iconData;
  final void Function(bool) onChanged;

  const SudokuButton({
    Key? key,
    required this.initialState,
    required this.iconData,
    required this.onChanged, 
  }) : super(key: key);

  @override
  _SudokuButtonState createState() => _SudokuButtonState();
}

class _SudokuButtonState extends State<SudokuButton> {
  late bool isOn;

  @override
  void initState() {
    super.initState();
    isOn = widget.initialState;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggleState,
      child: Container(
        padding: const EdgeInsets.all(8),
        child: Icon(
          widget.iconData,
          color: isOn ? Colors.blue : Colors.black,
          size: 30,
        ),
      ),
    );
  }

  void _toggleState() {
    setState(() {
      isOn = !isOn;
      widget.onChanged(isOn);
    });
  }
}