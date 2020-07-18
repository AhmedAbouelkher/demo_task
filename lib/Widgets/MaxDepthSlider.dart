import 'package:demo/Helpers/Constants.dart';
import 'package:flutter/material.dart';

class MaxDepthSlider extends StatefulWidget {
  MaxDepthSlider({Key key}) : super(key: key);

  @override
  _MaxDepthSliderState createState() => _MaxDepthSliderState();
}

class _MaxDepthSliderState extends State<MaxDepthSlider> {
  double _sliderValue = 27.5;
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final _textStyle = TextStyle(
      color: Constants.blackBlue,
      fontSize: 10,
      fontWeight: FontWeight.w600,
    );
    return Transform(
      transform: Matrix4.identity()
        ..scale(1.0)
        ..translate(-20.0),
      child: Stack(
        alignment: Alignment.centerLeft,
        children: <Widget>[
          Positioned(
            left: 21,
            top: 0,
            child: Text(
              "Max Depth".toUpperCase(),
              style: TextStyle(
                color: Constants.blackBlue,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Positioned(
            top: 33,
            left: 2 + 22.0,
            right: 0 + 22.0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("15", style: _textStyle),
                  Text("\t\t30", style: _textStyle),
                  Text("40+", style: _textStyle),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: SliderTheme(
              data: Theme.of(context).sliderTheme.copyWith(
                    activeTrackColor: Constants.blackBlue,
                    inactiveTrackColor: Constants.blackBlue.withAlpha(80),
                    thumbColor: Colors.white,
                    overlayColor: Colors.transparent,
                  ),
              child: Slider(
                min: 15,
                value: _sliderValue,
                max: 40,
                divisions: 2,
                onChanged: (value) {
                  setState(() => _sliderValue = value);
                  print(value);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
