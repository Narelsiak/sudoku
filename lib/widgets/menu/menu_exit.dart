import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
 
class DialogUtils {
  static void showExitDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Are you sure?'),
        content: Text('Do you really want to exit the application?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Zamknij alert
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Zamknij alert
              SystemNavigator.pop(); // Wyjście z aplikacji
            },
            child: Text('Exit'),
          ),
        ],
      ),
    );
  }
}
