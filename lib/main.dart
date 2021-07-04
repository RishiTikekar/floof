import 'package:firebase_core/firebase_core.dart';
import 'package:floof/core/provider_injection.dart';
import 'package:floof/presentation/on_boarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:floof/core/theme/floof_theme.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  //  await EasyLocalization.ensureInitialized();
  runApp(MyApp());
  initProvider();
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: FloofTheme.mytheme,
      title: 'floof',
      home: OnBoardingScreen(),
    );
  }
}
