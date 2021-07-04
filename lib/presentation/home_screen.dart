import 'package:floof/providers/login_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  final LoginProvider loginProvider = Get.find<LoginProvider>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await loginProvider.signOutGoogle();
        },
        child: Icon(Icons.person),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Text(
              "Search ",
              style: Theme.of(context).textTheme.headline1,
            )
          ],
        ),
      ),
    );
  }
}
