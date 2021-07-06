import 'package:floof/core/theme/assets.dart';
import 'package:floof/core/theme/floof_theme.dart';
import 'package:floof/presentation/home_screen.dart';
import 'package:floof/providers/login_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  final LoginProvider loginProvider = Get.find<LoginProvider>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: Stack(
          children: [
            Positioned(
              top: -10,
              left: -50,
              child: Container(
                width: size.width * 0.4,
                height: size.width * 0.4,
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: FloofTheme.FONT_DARK_COLOR),
              ),
            ),
            Positioned(
              bottom: -200,
              right: -100,
              child: Container(
                width: size.width * 0.8,
                height: size.width * 0.8,
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: FloofTheme.FONT_DARK_COLOR),
              ),
            ),
            Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  Assets.PAWVECTOR,
                  scale: 5,
                  fit: BoxFit.scaleDown,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30),
                  child: Text(
                    "Let's get started",
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
                loginUi(size: size, context: context),
              ],
            )),
          ],
        ),
      ),
    );
  }

  Widget loginUi({required Size size, required BuildContext context}) {
    return Column(
      children: [
        ElevatedButton(
          style: ButtonStyle(
              padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                  EdgeInsets.symmetric(horizontal: 25))),
          onPressed: () async {
            bool outCome = await loginProvider.signInWithGoogle();

            //route if sign in successful
            if (outCome) {
              Get.to(() => HomeScreen());
            }
          },
          child: Text(
            "Login with Google",
            style: Theme.of(context).textTheme.headline2,
          ),
        ),
        SizedBox(
          height: 20,
        ),
        ElevatedButton(
          onPressed: () async {
            bool outCome = await loginProvider.signInWithFacebook();

            //route if sign in successful
            if (outCome) {
              Get.to(() => HomeScreen());
            }
          },
          child: Text(
            "Login with Facebook",
            style: Theme.of(context).textTheme.headline2,
          ),
        )
      ],
    );
  }
}
