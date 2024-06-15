import 'package:flutter/material.dart';
import 'package:sudoku/widgets/menu/menu_screen_buttons.dart';
 
class MenuScreen extends StatefulWidget {
  @override
  _MenuScreenState createState() => _MenuScreenState();
 
}
class _MenuScreenState extends State<MenuScreen> {
  @override
  void initState() {
    super.initState();
  }  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Sudoku'),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background_image.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: MenuScreenButtons(context: context),
        ),
      ),
    );
  }
}
