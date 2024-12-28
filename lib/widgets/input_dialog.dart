import 'package:flutter/material.dart';

class InputDialog extends StatefulWidget {
  final String title;
  final String hint;

  // Constructor to receive title and hint
  const InputDialog({Key? key, required this.title, required this.hint})
      : super(key: key);

  @override
  _InputDialogState createState() => _InputDialogState();
}

class _InputDialogState extends State<InputDialog> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title),
      content: TextFormField(
        controller: _controller,
        decoration: InputDecoration(hintText: widget.hint),
        keyboardType: TextInputType.text,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter a value';
          }
          return null;
        },
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(null); // Cancel action
          },
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            if (_controller.text.isNotEmpty) {
              Navigator.of(context).pop(_controller.text); // Add action
            } else {
              // Show a SnackBar for validation
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Please enter a value')),
              );
            }
          },
          child: Text('Add'),
        ),
      ],
    );
  }
}
