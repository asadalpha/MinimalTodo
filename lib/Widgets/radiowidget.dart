import 'package:flutter/material.dart';

class RadioWidget extends StatefulWidget {
  final String rtitle;
  final Color rcolor;
  final int rvalue;

  const RadioWidget({
    Key? key,
    required this.rtitle,
    required this.rcolor,
    required this.rvalue,
  }) : super(key: key);

  @override
  _RadioWidgetState createState() => _RadioWidgetState();
}

class _RadioWidgetState extends State<RadioWidget> {
  int? _selectedValue; // Use nullable int to indicate no selection initially

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Theme(
        data: ThemeData(unselectedWidgetColor: widget.rcolor),
        child: RadioListTile(
          contentPadding: EdgeInsets.zero,
          title: Transform.translate(
            offset: const Offset(-22, 0),
            child: Text(widget.rtitle),
          ),
          value: widget.rvalue,
          groupValue: _selectedValue,
          onChanged: (value) {
            setState(() {
              _selectedValue = value;
            });
          },
          selected: _selectedValue == widget.rvalue,
        ),
      ),
    );
  }
}
