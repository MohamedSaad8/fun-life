import 'package:flutter/material.dart';
import 'package:funlife/models/onBoardingModel.dart';
import 'package:page_view_indicator/page_view_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();

  static String id = "onBoardingScreen";
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  List<OnBoardingModel> model = [
    OnBoardingModel(
        title: "make new friends".toUpperCase(),
        iconLocation: "images/friends.png",
        description:
            "Making new friends can be intimidating, but it’s definitely rewarding. After all, friends form a big part of our life for most of us"),
    OnBoardingModel(
        title: "new happy life".toUpperCase(),
        iconLocation: "images/Happy.png",
        description:
            "If I could be perfectly free, I would be happy , With FUN-LIFE app you will be more happy "),
    OnBoardingModel(
        title: "discover our world".toUpperCase(),
        iconLocation: "images/discover.png",
        description:
            "Discover the World  with Fun-LIVE to know the new countries, Customs and traditions")
  ];
  ValueNotifier<int> _pageIndexNotifier = ValueNotifier(0);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          PageView.builder(
            itemBuilder: (context, index) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Transform.translate(
                    child: SizedBox(
                      child: Image(
                        image: ExactAssetImage(model[index].iconLocation),
                        fit: BoxFit.fill,
                      ),
                      width: screenWidth * 0.45,
                      height: screenHeight * 0.2,
                    ),
                    offset: Offset(0, -screenHeight * .12),
                  ),
                  Text(
                    model[index].title,
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 10),
                    child: Text(
                      model[index].description,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              );
            },
            itemCount: model.length,
            onPageChanged: (index) {
              _pageIndexNotifier.value = index;
            },
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10, left: 16, right: 16),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      side: BorderSide(color: Colors.purple)),
                  color: Colors.grey.shade200,
                  child: Text(
                    "Skip",
                    style: TextStyle(color: Colors.purple, fontSize: 16),
                  ),
                  onPressed: () {},
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Transform.translate(
              child: _displayPageView(model.length),
              offset: Offset(0, screenHeight * .3),
            ),
          ),
        ],
      ),
    );
  }

  Widget _displayPageView(int length) {
    return PageViewIndicator(
      pageIndexNotifier: _pageIndexNotifier,
      length: length,
      normalBuilder: (animationController, index) => Circle(
        size: 8.0,
        color: Colors.purple,
      ),
      highlightedBuilder: (animationController, index) => ScaleTransition(
        scale: CurvedAnimation(
          parent: animationController,
          curve: Curves.ease,
        ),
        child: Circle(
          size: 12.0,
          color: Colors.purpleAccent,
        ),
      ),
    );
  }
}
