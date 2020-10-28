import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:funlife/constants.dart';
import 'package:funlife/screens/addPostScreen.dart';
import 'package:funlife/screens/homeScreen.dart';
import 'package:funlife/screens/notification.dart';
import 'package:funlife/screens/search.dart';
import 'package:funlife/screens/userProfileScreen.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class FunLifeMainScreen extends StatefulWidget {
  @override
  _FunLifeMainScreenState createState() => _FunLifeMainScreenState();
  static String id = "funLifeMainScreen" ;
}
PersistentTabController _controller;

class _FunLifeMainScreenState extends State<FunLifeMainScreen> {
  @override
  void initState() {
    _controller = PersistentTabController(initialIndex: 0);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
        controller: _controller,
        screens: _buildScreens(),
        items: _navBarsItems(),
        confineInSafeArea: true,
        backgroundColor: Colors.white,
        handleAndroidBackButtonPress: true,
        resizeToAvoidBottomInset: true, // This needs to be true if you want to move up the screen when keyboard appears.
        stateManagement: true,
        hideNavigationBarWhenKeyboardShows: true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument.
        decoration: NavBarDecoration(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(40),topRight: Radius.circular(40)),
          colorBehindNavBar: Colors.white,
          border: Border.all(
            color: kMainColor
          )
        ),
        popAllScreensOnTapOfSelectedTab: true,
        popActionScreens: PopActionScreensType.all,
        itemAnimationProperties: ItemAnimationProperties( // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
    curve: Curves.ease,
    ),
        screenTransitionAnimation: ScreenTransitionAnimation( // Screen transition animation on change of selected tab.
    animateTabTransition: true,
    curve: Curves.ease,
    duration: Duration(milliseconds: 200),
    ),
        navBarStyle: NavBarStyle.style15,
        navBarHeight: 65,
      // Choose the nav bar style with this property.
    );
  }

  List<Widget> _buildScreens() {
    return [
      UserProfileScreen(),
      Search(),
      AddPostScreen(),
      NotificationScreen(),
      HomeScreen(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.person,),
        title: ("Profile"),
        activeColor: kMainColor,
        inactiveColor: CupertinoColors.systemGrey,
        titleFontSize: 14,


      ),
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.search),
        title: ("Search"),
        activeColor: kMainColor,
        inactiveColor: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.add_circled ,color: Colors.white,),
        title: ("New Post"),
        activeColor: kMainColor,
        inactiveColor: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.bell),
        title: ("Notifications"),
        activeColor: kMainColor,
        inactiveColor: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.home),
        title: ("Home"),
        activeColor: kMainColor,
        inactiveColor: CupertinoColors.systemGrey,
      ),
    ];
  }
}
