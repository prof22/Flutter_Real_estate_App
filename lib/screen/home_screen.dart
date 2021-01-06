// import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:real_estate_app/screen/all_properties_screen.dart';
import 'package:real_estate_app/screen/login_screen.dart';
import 'package:real_estate_app/screen/search_screen.dart';
import 'package:real_estate_app/screen/timeline_screen.dart';
import 'package:real_estate_app/users/user_dashboard.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:real_estate_app/users/user_dashboard.dart';
import 'contact_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PageController pageController;
  int pageIndex = 0;
  bool isLogin = false;
  var authToken, agentApproval, userApproval;


  @override
  void initState() {
    super.initState();
    _fetchAndRedirect();
    pageController = PageController();
  }

  @override
  void dispose() {
    _fetchAndRedirect();
    pageController.dispose();
    super.dispose();
  }

  onPageChanged(int pageIndex) {
    if (mounted) {
      setState(() {
        this.pageIndex = pageIndex;
      });
    }
  }

  onTap(int pageIndex) {
    pageController.animateToPage(pageIndex,
        duration: Duration(milliseconds: 200), curve: Curves.easeInOut);
  }

  void _fetchAndRedirect() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (mounted) {
      setState(() {
        authToken = prefs.getString('token');
        agentApproval = prefs.getString('agentApproval');
        userApproval = prefs.getString('userApproval');
      });
    }
    if (authToken != null) {
      if (mounted) {
        setState(() {
          isLogin = true;
        });
      }
    }
  }



 Widget display() {
   if (userApproval ==  'user approved' && isLogin == true) {
     return DashboardScreen();
    } else {
    return  LoginScreen();
    }
  }

  // fetchFive()
  // {
  //   for(int i = 0; i < 5; i++)
  //   {
  //      _getAllProperties();
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: PageView(
          children: <Widget>[
            Timeline(),
            HomeAllProperties(),
            Search(),
            display(),
            // ContactScreen()
          ],
          controller: pageController,
          onPageChanged: onPageChanged,
          physics: NeverScrollableScrollPhysics(),
        ),
      ),
      bottomNavigationBar: CupertinoTabBar(
          currentIndex: pageIndex,
          onTap: onTap,
          activeColor: Theme.of(context).primaryColor,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home, color: Colors.black,), title: Text('Home', style: TextStyle(color:Colors.black),)),
            BottomNavigationBarItem(icon: Icon(Icons.location_city, color: Colors.black), title: Text('Nearby', style: TextStyle(color:Colors.black),)),
            BottomNavigationBarItem(icon: Icon(Icons.search, color: Colors.black), title: Text('Advance Search', style: TextStyle(color:Colors.black),)),
            BottomNavigationBarItem(icon: Icon(Icons.person, color: Colors.black), title: Text('Profile', style: TextStyle(color:Colors.black),)),
            // BottomNavigationBarItem(icon: Icon(Icons.contacts), title: Text('Contact')),
            // BottomNavigationBarItem(icon: Icon(Icons.notifications)),
          ]),
    );
  }
}
