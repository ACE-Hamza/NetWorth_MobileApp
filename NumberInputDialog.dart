import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NumberInputDialog extends StatefulWidget {
  const NumberInputDialog({
    Key? key,
    required this.onTap,
    required this.title,
    required this.amount,
  }) : super(key: key);

  final Function(int) onTap;
  final String title;
  final int amount;

  @override
  _NumberInputDialogState createState() => _NumberInputDialogState();
}

class _NumberInputDialogState extends State<NumberInputDialog> {
  late final TextEditingController _controller;
  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(
        text: widget.amount == 0 ? '' : widget.amount.toString());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final outlineInputBorder = OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey.shade600, width: 1),
    );
    final screenSize = MediaQuery.of(context).size;
    return Dialog(
      backgroundColor: Colors.white,
      child: Container(
        padding: EdgeInsets.all(20),
        width: screenSize.width * 0.7,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.title,
              style: Theme.of(context).accentTextTheme.headline6?.copyWith(color: Colors.grey.shade800),
            ),
            SizedBox(height: 24),
            TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              style: TextStyle(color: Colors.grey.shade900),
              autofocus: true,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                enabledBorder: outlineInputBorder,
                focusedBorder: outlineInputBorder,
                labelText: 'Write amount',
              ),
            ),
            SizedBox(height: 24),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Theme.of(context).cardColor,
                padding: EdgeInsets.symmetric(horizontal: 56),
              ),
              onPressed: () {
                widget.onTap(int.parse(_controller.text));
                Navigator.of(context).pop();
              },
              child: Text(
                'Done',
                style: Theme.of(context).textTheme.button!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

