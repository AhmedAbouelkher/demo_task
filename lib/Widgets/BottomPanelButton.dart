import 'package:demo/Helpers/Constants.dart';
import 'package:flutter/material.dart';

class PanelButton extends StatelessWidget {
  final bool reversed;
  final String title;
  final EdgeInsetsGeometry padding;
  final bool dropShadow;

  const PanelButton(
      {Key key,
      this.reversed = false,
      this.title,
      this.padding,
      this.dropShadow = false})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        constraints: BoxConstraints(maxHeight: 40),
        decoration: BoxDecoration(
            color: reversed ? Constants.darkBlue : Colors.white,
            border: Border.all(
              color: Constants.blackBlue,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: dropShadow
                    ? Constants.darkBlue.withOpacity(0.5)
                    : Colors.transparent,
                blurRadius: 5,
                spreadRadius: 1,
              ),
            ]),
        padding: padding,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              title,
              style: TextStyle(
                color: reversed ? Colors.white : Constants.blackBlue,
                fontSize: 11,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
