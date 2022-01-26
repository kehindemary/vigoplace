import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';

import 'package:vigoplace/core/colors/colors.dart';
import 'package:vigoplace/core/constants/sizes.dart';
import 'package:vigoplace/screens/home.dart';
import 'package:vigoplace/screens/posts.dart';
import 'package:vigoplace/screens/profile.dart';
import 'package:vigoplace/screens/search.dart';
import 'package:websafe_svg/websafe_svg.dart';

import 'notification_screen.dart';

// ignore: use_key_in_widget_constructors
class Home extends StatefulWidget {
  static String routeName = 'Home';

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  PageController pageController = PageController();

  List<Widget> screens = [
    HomePage(),
    Search(),
    NotificationScreen(),
    Profile()
  ];

  int _selectedIndex = 0;

  void _onPageChanged(int currentIndex) {
    setState(() {
      _selectedIndex = currentIndex;
    });
  }

  void _handleClick(int selectedIndex) {
    pageController.jumpToPage(selectedIndex);
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DoubleBackToCloseApp(
        snackBar: const SnackBar(
          content: Text('Press Back button again to Exit'),
        ),
        child: PageView(
            controller: pageController,
            physics: const NeverScrollableScrollPhysics(),
            onPageChanged: _onPageChanged,
            children: screens),
      ),
      bottomNavigationBar: SizedBox(
        height: sizeFit(
          false,
          85,
          context,
        ),
        child: BottomNavigationBar(
          backgroundColor: kWhite,
          type: BottomNavigationBarType.fixed,
          onTap: _handleClick,
          items: [
            BottomNavigationBarItem(
              label: '',
              icon: WebsafeSvg.asset(
                'images/home.svg',
                color: _selectedIndex == 0 ? kPurple : kGray,
              ),
            ),
            BottomNavigationBarItem(
              label: '',
              icon: Icon(
                Icons.search,
                color: _selectedIndex == 1 ? kPurple : kGray,
              ),
              // ignore: deprecated_member_use
            ),
            BottomNavigationBarItem(
              label: '',
              icon: FloatingActionButton(
                  backgroundColor: kPurple,
                  child: const Center(
                    child: Icon(
                      Icons.add,
                      color: kWhite,
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, PostScreen.routeName);
                  }),
              // ignore: deprecated_member_use
            ),
            BottomNavigationBarItem(
              label: '',
              icon: Icon(
                Icons.notifications_active_outlined,
                color: _selectedIndex == 2 ? kPurple : kGray,
              ),
              // ignore: deprecated_member_use
            ),
            BottomNavigationBarItem(
              label: '',
              icon: Icon(
                Icons.person,
                color: _selectedIndex == 3 ? kPurple : kGray,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
