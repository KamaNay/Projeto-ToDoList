import 'package:flutter/material.dart';
import 'package:flutter_1/utilities/my_button.dart';

class DialogBox extends StatelessWidget {
  final controller;
  VoidCallback onSave;
  VoidCallback onCancel;

  DialogBox(
      {super.key,
      required this.controller,
      required this.onSave,
      required this.onCancel});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color.fromARGB(255, 6, 17, 79),
      content: SizedBox(
        height: 120,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // get user input
            TextField(
              controller: controller,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Add a new task",
                  hintStyle: TextStyle(color: Colors.white, fontSize: 16)),
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
            // buttons save and cancel
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // save button
                MyButton(
                  text: "Save",
                  onPressed: onSave,
                ),

                const SizedBox(
                  width: 8,
                ),

                // cancel button
                MyButton(text: "Cancel", onPressed: onCancel),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
