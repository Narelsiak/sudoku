import 'package:flutter/material.dart';

class DropdownSetting extends StatelessWidget {
  final String title;
  final String value;
  final void Function(String) onChanged;
  final List<String> items;

  const DropdownSetting({
    required this.title,
    required this.value,
    required this.onChanged,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      trailing: DropdownButton<String>(
        value: value,
        onChanged: (String? newValue) {
          if (newValue != null) {
            onChanged(newValue);
          }
        },
        items: items.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }
}
