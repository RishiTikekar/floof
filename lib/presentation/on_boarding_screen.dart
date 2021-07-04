import 'dart:math';

import 'package:floof/core/theme/assets.dart';
import 'package:floof/core/theme/floof_theme.dart';
import 'package:floof/presentation/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class OnBoardingScreen extends StatefulWidget {
  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  int currentPageIndex = 0;

  List<Map<String, String>> splashScreenData = [
    {
      'image': Assets.ONBOARDING1,
      'title': 'Welcome to floof!',
      'subtitle':
          'With our app you\'ll make life of\n    our furry friends happier.'
    },
    {
      'image': Assets.ONBOARDING2,
      'title': 'Find the nearest pet\n from your location',
      'subtitle':
          'Choose a location of your for finding\n          the nearest pet for you.'
    },
    {
      'image': Assets.ONBOARDING3,
      'title': 'Make new friends',
      'subtitle': 'Here you can meet your dream\n   friends and joy with them.'
    }
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Column(
          children: [
            page(size: size),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 50),
              child: IconButton(
                onPressed: () {
                  Get.to(() => LoginScreen());
                },
                icon: Icon(
                  Icons.arrow_forward_ios,
                  color: FloofTheme.FONT_DARK_COLOR,
                  size: 30,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Expanded page({required Size size}) {
    return Expanded(
      child: PageView.builder(
        itemCount: splashScreenData.length,
        onPageChanged: (value) {
          setState(() {
            currentPageIndex = value;
          });
        },
        itemBuilder: (context, index) {
          return Column(
            children: [
              Spacer(),
              Container(
                  height: min<double>(size.height * 0.8, size.width),
                  width: min<double>(size.height * 0.8, size.width),
                  child:
                      Image.asset(splashScreenData[index]['image'] as String)),
              Spacer(),
              Text(
                splashScreenData[index]['title'] as String,
                style: Theme.of(context).textTheme.bodyText1,
              ),
              SizedBox(height: 20),
              Text(
                splashScreenData[index]['subtitle'] as String,
                style: Theme.of(context).textTheme.bodyText2,
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                    splashScreenData.length, (index) => buildDots(index)),
              )
            ],
          );
        },
      ),
    );
  }

  AnimatedContainer buildDots(int index) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 5),
      margin: EdgeInsets.only(right: 5),
      height: 6,
      width: currentPageIndex == index ? 25 : 6,
      decoration: BoxDecoration(
          color: currentPageIndex == index
              ? FloofTheme.FONT_DARK_COLOR
              : FloofTheme.COLOR4,
          borderRadius: BorderRadius.circular(4)),
    );
  }
}
