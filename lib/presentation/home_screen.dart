import 'package:floof/core/models/pet_model.dart';
import 'package:floof/core/theme/floof_theme.dart';
import 'package:floof/providers/login_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final LoginProvider loginProvider = Get.find<LoginProvider>();
//testing purpose data
  List<String> categories = ['Dog', 'Cat', 'Fishes', 'Hamster', 'Other'];

  late String selectedCategory = 'Dog';

  List<PetModel> petList = [
    PetModel(
        name: 'Tomya',
        id: '1',
        age: 7,
        breed: 'Labrador',
        category: 'Dog',
        ownerId: '220',
        description:
            'amch moti kutra london la gela suite boot ghalun saheb banun ala')
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (loginProvider.userData.provider == "Google") {
            await loginProvider.signOutGoogle();
          } else {
            await loginProvider.logoutFacebook();
          }
        },
        child: Icon(Icons.person),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: size.height * 0.02),
            Text.rich(
              TextSpan(children: [
                TextSpan(
                  text: 'Search',
                  style: Theme.of(context).textTheme.headline1,
                ),
                TextSpan(
                    text: ' Friend',
                    style: TextStyle(
                      fontSize: 34,
                      fontWeight: FontWeight.w800,
                      fontFamily: 'Nunito',
                      foreground: Paint()
                        ..style = PaintingStyle.stroke
                        ..strokeWidth = 2
                        ..color = FloofTheme.FONT_DARK_COLOR,
                    ))
              ]),
            ),
            TextField(
              decoration: InputDecoration(
                hintText: 'Search',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(55))),
                prefixIcon: IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.search),
                ),
              ),
            ),
            catgoriesWidget(size: size),
            petListWidget()
          ],
        ),
      ),
    );
  }

//categories secotion
  Container catgoriesWidget({required Size size}) {
    return Container(
      height: 94,
      width: size.width,
      child: ListView(
          scrollDirection: Axis.horizontal,
          children: categories.map(
            (currentCategory) {
              return InkWell(
                onTap: () => setState(() => selectedCategory = currentCategory),
                child: Container(
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.symmetric(horizontal: 8),
                  height: 70,
                  width: 70,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [BoxShadow(blurRadius: 3, color: Colors.grey)],
                    color: selectedCategory == currentCategory
                        ? FloofTheme.FONT_DARK_COLOR
                        : FloofTheme.PRIMARY_COLOR,
                  ),
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      currentCategory,
                      style: Theme.of(context).textTheme.headline2!.copyWith(
                            fontSize: 18,
                            color: selectedCategory == currentCategory
                                ? FloofTheme.PRIMARY_COLOR
                                : FloofTheme.FONT_DARK_COLOR,
                          ),
                    ),
                  ),
                ),
              );
            },
          ).toList()),
    );
  }

  Expanded petListWidget() {
    return Expanded(
      child: ListView(
          children: petList.map((currentPet) {
        return Container();
      }).toList()),
    );
  }
}
