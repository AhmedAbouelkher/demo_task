import 'package:demo/Helpers/Constants.dart';
import 'package:flutter/material.dart';

class MultiChoiseChips extends StatefulWidget {
  final List<String> labels;
  final List<IconData> icons;
  final String label;
  final bool scaleDownl;
  final bool reverse;
  MultiChoiseChips(
      {Key key,
      @required this.labels,
      @required this.icons,
      this.label,
      this.scaleDownl,
      this.reverse = false})
      : super(key: key);

  @override
  _MultiChoiseChipsState createState() => _MultiChoiseChipsState();
}

class _MultiChoiseChipsState extends State<MultiChoiseChips> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          " " + widget.label,
          style: TextStyle(
            color: Constants.blackBlue,
            fontSize: 10,
            fontWeight: FontWeight.bold,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: SizedBox(
            height: 27,
            width: width * 0.80,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: widget.labels.length,
              itemBuilder: (context, index) {
                return _buildChooseChipAdv(index);
              },
            ),
          ),
        ),
      ],
    );
  }

  _buildChooseChipAdv(int index) {
    bool isSelected = index == _selectedIndex;
    if (widget.reverse) isSelected = !isSelected;
    return GestureDetector(
      onTap: () => setState(() => _selectedIndex = index),
      child: Padding(
        padding: const EdgeInsets.only(right: 5),
        child: Container(
          decoration: BoxDecoration(
            color: isSelected ? Constants.blackBlue : Colors.white,
            border: Border.all(
              color: Constants.blackBlue,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: <Widget>[
                  Text(
                    ' ' + widget.labels[index],
                    style: TextStyle(
                      color: isSelected ? Colors.white : Constants.blackBlue,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  !widget.reverse
                      ? Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: Icon(
                            widget.icons[index],
                            size: 15,
                            color:
                                isSelected ? Colors.white : Constants.blackBlue,
                          ),
                        )
                      : Container(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
