import 'package:demo/Helpers/Constants.dart';
import 'package:demo/Widgets/BottomPanelButton.dart';
import 'package:demo/Widgets/CustomDrawer.dart';
import 'package:demo/Widgets/SearchFiltersPanel.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  AnimationController _animationController;
  AnimationController _panelAnimationController;
  AnimationController _popupAimationController;
  AnimationController _searchFilterAimationController;
  Animation _animation;
  Animation _panelAnimation;
  Animation _popupAimation;
  Animation _searchFilterAimation;
  PanelController _panelController;

  @override
  void initState() {
    super.initState();
    /*
        
         */
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    _animation = Tween<double>(begin: 0, end: 1)
        .chain(CurveTween(curve: Curves.decelerate))
        .animate(_animationController);
    /*
        
         */
    _panelAnimationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));
    _panelAnimation =
        Tween<double>(begin: 0, end: 1).animate(_panelAnimationController);
    /*
        
         */
    _popupAimationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));
    _popupAimation =
        Tween<double>(begin: 0, end: 1).animate(_popupAimationController);
    _panelController = PanelController();
    /*
        
         */
    _searchFilterAimationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 400));
    _searchFilterAimation = Tween<double>(begin: 0, end: 1)
        .animate(_searchFilterAimationController);
    _panelController = PanelController();
    //
    _panelAnimationController?.forward();
  }

  @override
  void dispose() {
    _animationController?.dispose();
    _panelAnimationController?.dispose();
    _popupAimationController?.dispose();
    _searchFilterAimationController?.dispose();
    super.dispose();
  }

  openSlidePanel() async {
    await _panelController?.open();
    if (_panelAnimationController?.isCompleted ?? false) {
      _panelAnimationController?.reverse();
    }
  }

  closeSlidePanel() async {
    await _panelController?.close();
    if (_panelAnimationController?.isCompleted ?? true) {
      _panelAnimationController?.forward();
    }
  }

  void driveDrawerAnimation() => _animationController.isCompleted
      ? _animationController?.reverse()
      : _animationController?.forward();
  void drivePopupAnimation() => _popupAimationController.isCompleted
      ? _popupAimationController?.reverse()
      : _popupAimationController?.forward();
  void driveSearchFilterAnimation() =>
      _searchFilterAimationController.isCompleted
          ? _searchFilterAimationController?.reverse()
          : _searchFilterAimationController?.forward();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    BorderRadiusGeometry radius = BorderRadius.only(
      topLeft: Radius.circular(15.0),
      topRight: Radius.circular(15.0),
    );

    final boldishTextStyle = TextStyle(
      color: Color(0xff011426),
      fontWeight: FontWeight.w600,
      fontSize: 10,
    );
    final normalishTextStyle = TextStyle(
      color: Color(0xff011426),
      fontWeight: FontWeight.w300,
      fontSize: 10,
    );
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(0),
        child: AppBar(
          backgroundColor: Constants.darkBlue,
          brightness: Brightness.dark,
          elevation: 0,
        ),
      ),
      body: SafeArea(
        top: false,
        bottom: false,
        child: Stack(
          overflow: Overflow.visible,
          children: <Widget>[
            GestureDetector(
              onTap: () {
                FocusScope.of(context).requestFocus(FocusNode());
                if (_popupAimationController.isCompleted) {
                  _popupAimationController?.reverse();
                }
                if (_searchFilterAimationController.isCompleted) {
                  _searchFilterAimationController?.reverse();
                }
                if (_panelController.isPanelOpen) {
                  closeSlidePanel();
                }
              },
              child: Container(
                color: Constants.lightBlue,
                height: height,
                width: width,
                child: Transform(
                  transform: Matrix4.identity()
                    ..scale(1.7 * 1.0)
                    ..translate(-150 * 1.0, -180 * 1.0),
                  child: Image.asset(
                    Constants.map,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Align(
              child: GestureDetector(
                onTap: () => drivePopupAnimation(),
                child: Image.asset(Constants.diveSpot),
              ),
            ),
            Align(
              alignment: Alignment(0, -0.29),
              child: AnimatedBuilder(
                animation: _popupAimation,
                child: _divingInformationPopup(
                  width,
                  normalishTextStyle,
                  boldishTextStyle,
                ),
                builder: (BuildContext context, Widget child) {
                  double value = _popupAimation.value;
                  double valueInversed = (_popupAimation.value - 1).abs();
                  return Visibility(
                    visible: value > 0,
                    child: Opacity(
                      opacity: value,
                      child: Transform.translate(
                        offset: Offset(0, 11 * valueInversed),
                        child: child,
                      ),
                    ),
                  );
                },
              ),
            ),
            Positioned(
              top: 20 + 30.0,
              right: 35,
              child: SearchFilterPanel(
                controller: _searchFilterAimation,
                onTap: driveSearchFilterAnimation,
              ),
            ),
            Positioned(
              bottom: 38,
              left: 0,
              right: 0,
              // alignment: Alignment.bottomCenter,
              child: SlidingUpPanel(
                controller: _panelController,
                onPanelClosed: () => _panelAnimationController.forward(),
                onPanelOpened: () => _panelAnimationController.reverse(),
                panel: _buildSlidePanelBody(
                    width, normalishTextStyle, boldishTextStyle),
                collapsed: Container(
                  decoration: BoxDecoration(
                    color: Colors.white60,
                    borderRadius: radius,
                  ),
                  padding: EdgeInsets.only(top: 5),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Divider(
                      color: Colors.grey.withAlpha(200),
                      indent: width / 2 - 20,
                      endIndent: width / 2 - 20,
                      thickness: 2,
                    ),
                  ),
                ),
                body: Center(),
                minHeight: 36,
                maxHeight: 213,
                borderRadius: radius,
              ),
            ),
            Positioned(
              top: 20,
              left: 20,
              width: width - 40,
              child: SizedBox(
                height: 60,
                child: _buildAppBar(context),
              ),
            ),

            Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 40,
                  color: Colors.white,
                  width: width,
                )),
            //* Should be at the top
            CustomDrawer(
              controller: _animation,
              onTap: driveDrawerAnimation,
            ),
          ],
        ),
      ),
    );
  }

  Container _divingInformationPopup(
      double width, TextStyle normalishTextStyle, TextStyle boldishTextStyle) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: 117,
        minHeight: 117,
        maxWidth: width * 0.85,
        minWidth: width * 0.85,
      ),
      margin: EdgeInsets.only(top: 25),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            offset: Offset(0, 2),
            blurRadius: 7,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          _buildSlidablePanelContant(
            normalishTextStyle,
            boldishTextStyle,
            width,
          ),
          Expanded(
            child: GestureDetector(
              onTap: () => openSlidePanel(),
              child: Container(
                constraints: BoxConstraints(
                    // maxHeight: 37,
                    ),
                decoration: ShapeDecoration(
                  color: Constants.darkBlue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                  ),
                ),
                child: Center(
                  child: Text(
                    "Add Site to List",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  AnimatedBuilder _buildSlidePanelBody(
    double width,
    TextStyle normalishTextStyle,
    TextStyle boldishTextStyle,
  ) {
    return AnimatedBuilder(
      animation: _panelAnimation,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                PanelButton(
                  title: "Save for later".toUpperCase(),
                ),
                PanelButton(
                  reversed: true,
                  title: "find center".toUpperCase(),
                  padding: EdgeInsets.symmetric(horizontal: 60),
                  dropShadow: true,
                ),
              ],
            ),
            Container(
              constraints: BoxConstraints(
                maxHeight: 85,
                minHeight: 80,
                maxWidth: width * 0.85,
                minWidth: width * 0.85,
              ),
              margin: EdgeInsets.only(top: 25),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.15),
                    offset: Offset(0, 2),
                    blurRadius: 7,
                    spreadRadius: 1,
                  ),
                ],
              ),
              child: _buildSlidablePanelContant(
                  normalishTextStyle, boldishTextStyle, width),
            ),
          ],
        ),
      ),
      builder: (BuildContext context, Widget child) {
        double value = _panelAnimation.value;
        return Transform.translate(
          offset: Offset(0, value * 10),
          child: child,
        );
      },
    );
  }

  Row _buildSlidablePanelContant(
      TextStyle normalishTextStyle, TextStyle boldishTextStyle, double width) {
    return Row(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
            ),
          ),
          child: Image.asset(
            Constants.divecenter,
            fit: BoxFit.fill,
          ),
        ),
        SizedBox(width: 15),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Rick’s Reef Rick’s Reef Rick’s",
                style: TextStyle(
                  color: Color(0xff011426),
                  fontWeight: FontWeight.w500,
                  fontSize: 13,
                ),
              ),
              _builtDivingDetailsRow(normalishTextStyle, boldishTextStyle),
              SizedBox(
                width: width * 0.56,
                child: Row(
                  children: <Widget>[
                    Spacer(),
                    SmoothStarRating(
                      allowHalfRating: false,
                      starCount: 5,
                      rating: 4,
                      size: 16.0,
                      color: Constants.ratingOrange,
                      borderColor: Colors.grey,
                      spacing: -1,
                    ),
                    Text(
                      " (50)",
                      style: normalishTextStyle.copyWith(fontSize: 9),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  Row _builtDivingDetailsRow(
      TextStyle normalishTextStyle, TextStyle boldishTextStyle) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Max Depth",
                      style: normalishTextStyle,
                    ),
                    Text(
                      "Dive Type",
                      style: normalishTextStyle,
                    ),
                  ],
                ),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "25m",
                      style: boldishTextStyle,
                    ),
                    Text(
                      "Shore Dive",
                      style: boldishTextStyle,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        SizedBox(width: 25),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Site Type",
                      style: normalishTextStyle,
                    ),
                    Text(
                      "Visibility",
                      style: normalishTextStyle,
                    ),
                  ],
                ),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Wreck",
                      style: boldishTextStyle,
                    ),
                    Text(
                      "~15m",
                      style: boldishTextStyle,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          GestureDetector(
            onTap: driveDrawerAnimation,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Icon(
                FontAwesomeIcons.bars,
                color: Colors.black,
                size: 20,
              ),
            ),
          ),
          Container(
            color: Colors.grey,
            width: 0.5,
            height: 20,
          ),
          Expanded(
            child: TextField(
              autofocus: false,
              decoration: InputDecoration(
                hintText: 'Search by City, Site or Promo Code',
                hintStyle: Theme.of(context)
                    .textTheme
                    .headline6
                    .copyWith(fontSize: 13, fontWeight: FontWeight.w300),
                contentPadding: EdgeInsets.only(left: 10),
                border: InputBorder.none,
              ),
            ),
          ),
          GestureDetector(
            onTap: driveSearchFilterAnimation,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Icon(
                FontAwesomeIcons.slidersH,
                color: Colors.black,
                size: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
