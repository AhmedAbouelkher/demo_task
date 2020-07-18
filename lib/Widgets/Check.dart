import 'package:demo/Helpers/Constants.dart';
import 'package:flutter/material.dart';

class Check extends StatefulWidget {
  final bool value;
  final Function(bool) onSelected;
  final String title;
  const Check({
    Key key,
    this.value,
    this.onSelected,
    this.title,
  }) : super(key: key);

  @override
  _CheckState createState() => _CheckState();
}

class _CheckState extends State<Check> {
  bool _isSelected = false;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          widget.title,
          style: TextStyle(
            color: Constants.blackBlue,
          ),
        ),
        SizedBox(
          height: 30,
          child: Checkbox(
            value: widget.value ?? _isSelected,
            onChanged: (value) {
              setState(() => _isSelected = value);
              if (widget.onSelected != null) widget.onSelected(value);
            },
            activeColor: Constants.blackBlue,
          ),
        ),
      ],
    );
  }
}
