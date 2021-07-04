import 'package:floof/core/models/pet_model.dart';
import 'package:floof/core/theme/floof_theme.dart';
import 'package:floof/presentation/pet_details_screen.dart';
import 'package:floof/providers/login_provider.dart';
import 'package:floof/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final LoginProvider loginProvider = Get.find<LoginProvider>();
//testing purpose data
  List<String> categories = ['Dog', 'Cat', 'Fish', 'Hamster', 'Other'];

  late String selectedCategory = 'Dog';

  List<PetModel> petList = [
    PetModel(
        name: 'Tomya',
        geneder: 'Male',
        id: '1',
        age: 7,
        breed: 'Vodaphone cha kutra',
        category: 'Dog',
        ownerId: '220',
        images: [
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRm48SyQFkfDroxQZ5mgiJO0LplBlXdwG3A2w&usqp=CAU',
          'https://thumbs.dreamstime.com/b/group-pets-kitten-puppy-raw-isolated-white-41268955.jpg',
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTBwghTLclKJqu2Uci3eqXHqNKsW-B83KO7uA&usqp=CAU',
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSmSCdfvxccsJ5RRwfCtzTHT2gaPP2FVlRowg&usqp=CAU'
        ],
        description:
            'amch moti kutra london la gela suite boot ghalun saheb banun ala')
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () async {
      //     if (loginProvider.userData.provider == "Google") {
      //       await loginProvider.signOutGoogle();
      //     } else {
      //       await loginProvider.logoutFacebook();
      //     }
      //   },
      //   child: Icon(Icons.person),
      // ),
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.menu),
        ),
        title: Text.rich(
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
        actions: [
          CircleAvatar(
            maxRadius: 35,
            backgroundImage: NetworkImage(
              loginProvider.userData.photoUrl,
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                children: [
                  IconButton(
                      onPressed: () {},
                      iconSize: 20,
                      icon: Icon(Icons.location_on)),
                  Text(
                    "India",
                    style: Theme.of(context).textTheme.headline3,
                  )
                ],
              ),
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
            petListWidget(size: size)
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
                        ? FloofTheme.COLOR5
                        // FloofTheme.FONT_DARK_COLOR
                        : FloofTheme.PRIMARY_COLOR,
                  ),
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      currentCategory,
                      style: Theme.of(context).textTheme.headline2!.copyWith(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
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

  Expanded petListWidget({required Size size}) {
    return Expanded(
      child: ListView(
          children: petList.map((currentPet) {
        return InkWell(
          onTap: () => Get.to(() => PetDetailsScreen()),
          child: Container(
            height: 200,
            width: double.infinity,
            margin: EdgeInsets.symmetric(horizontal: 4),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                boxShadow: [BoxShadow(blurRadius: 3, color: Colors.grey)],
                color: FloofTheme.PRIMARY_COLOR),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    margin: EdgeInsets.all(7),
                    height: double.infinity,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        currentPet.images[0],
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                // Spacer(),
                Expanded(
                    flex: 3,
                    child: Container(
                      padding: EdgeInsets.only(right: 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Flexible(
                                child: Text(
                                  currentPet.name,
                                  style: Theme.of(context).textTheme.headline3,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Spacer(),
                              IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.favorite,
                                  size: 35,
                                ),
                              )
                            ],
                          ),
                          Text(
                            currentPet.breed,
                            style: Theme.of(context).textTheme.bodyText2,
                          ),
                          Text(
                            currentPet.age.toString() + " years old",
                            style: Theme.of(context).textTheme.headline4,
                          )
                        ],
                      ),
                    ))
              ],
            ),
          ),
        );
      }).toList()),
    );
  }
}
