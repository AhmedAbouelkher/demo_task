import 'package:demo/Helpers/Constants.dart';
import 'package:demo/Widgets/Check.dart';
import 'package:demo/Widgets/Chip.dart';
import 'package:demo/Widgets/MaxDepthSlider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SearchFilterPanel extends AnimatedWidget {
  final VoidCallback onTap;
  const SearchFilterPanel({
    this.onTap,
    Key key,
    Animation controller,
  }) : super(key: key, listenable: controller);

  double get animationValue {
    Animation<double> animation = listenable;
    return animation.value;
  }

  double get animationValueRev {
    Animation<double> animation = listenable;
    return (animation.value - 1).abs();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Opacity(
      opacity: animationValue,
      // opacity: 1,
      child: Visibility(
        visible: animationValue > 0,
        child: Container(
          height: height * (0.5 + animationValueRev * 0.04),
          width: width * 0.74,
          decoration: ShapeDecoration(
            color: Colors.white,
            shadows: [
              BoxShadow(
                color: Colors.black.withAlpha(50),
                spreadRadius: 2,
                blurRadius: 8,
              ),
            ],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 40,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Transform.translate(
                        offset: Offset(0, -13 * animationValueRev),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'Filters'.toUpperCase(),
                              style: TextStyle(
                                color: Constants.blackBlue,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'reset filters',
                              style: TextStyle(
                                color: Constants.blackBlue,
                                fontSize: 12,
                                decoration: TextDecoration.underline,
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 23),
                      Transform.translate(
                        offset: Offset(0, 15 * animationValueRev),
                        child: MultiChoiseChips(
                          label: "DIVE TIMES",
                          labels: ['Day', 'Night', 'Early Morning'],
                          icons: [
                            FontAwesomeIcons.sun,
                            FontAwesomeIcons.moon,
                            FontAwesomeIcons.cloudSun
                          ],
                        ),
                      ),
                      Transform.translate(
                        offset: Offset(0, 19 * animationValueRev),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: MaxDepthSlider(),
                        ),
                      ),
                      Transform.translate(
                        offset: Offset(0, 23 * animationValueRev),
                        child: MultiChoiseChips(
                          reverse: true,
                          label: "SEASONS",
                          labels: ['Spring', 'Summer', 'Autumn', 'Winter'],
                          icons: [],
                        ),
                      ),
                      SizedBox(height: 10),
                      Column(
                        children: <Widget>[
                          Transform.translate(
                              offset: Offset(0, 16 * animationValueRev),
                              child: Check(title: "Hide old dives")),
                          Transform.translate(
                              offset: Offset(0, 16 * animationValueRev),
                              child: Check(title: 'Guided dives only')),
                        ],
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: onTap,
                  child: Container(
                    height: 43,
                    decoration: ShapeDecoration(
                      color: Constants.darkBlue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        ),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        "Set",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
