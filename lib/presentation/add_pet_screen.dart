import 'dart:io';
import 'package:floof/core/models/pet_model.dart';
import 'package:floof/presentation/home_screen.dart';
import 'package:floof/providers/login_provider.dart';
import 'package:floof/providers/pet_provider.dart';
import 'package:floof/providers/user_provider.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';
import 'package:floof/core/theme/floof_theme.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_slider/carousel_slider_indicators.dart';
import 'package:image_picker/image_picker.dart';

class AddPetScreen extends StatefulWidget {
  final Size size;
  AddPetScreen({required this.size});
  @override
  _AddPetScreenState createState() => _AddPetScreenState();
}

class _AddPetScreenState extends State<AddPetScreen> {
  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  String petName = '';
  String breedName = '';
  int petAge = 1;
  String petCategory = '';
  String gender = '';
  String description = '';

  int _radioSelected = 0;

  late String _selectedCategory = '';

  late String _selectedBreed = '';
  List<String> animalCategory = ['Dog', 'Cat', 'Hamster', 'Fish', 'Other'];

  Map<String, List<String>> breedData = {
    '': [''],
    'Dog': ['Labrador', 'German shepard', 'Husky', 'Poodle'],
    'Cat': ['Persia cat', 'Maine Coon', 'Bengal Cat', 'Ragdoll'],
    'Hamster': [
      'Syrian Hamster',
      'Chinese Hamster',
      'Dwarf Campbell',
      'Winter white'
    ],
    'Fish': ['Koi', 'Velitali', 'Oranda', 'Comet'],
    'Other': ['Other']
  };

  late List<Widget> _imagesWidgetListPrimary = [];
  List<File> images = [];

  LoginProvider _loginProvider = Get.find<LoginProvider>();
  UserProvider _userProvider = Get.find<UserProvider>();
  PetProvider _petProvider = Get.find<PetProvider>();

  // pickup image
  Future<void> pickImage() async {
    PickedFile? _image = await ImagePicker.platform
        .pickImage(source: ImageSource.gallery, imageQuality: 40);
    setState(() {
      _imagesWidgetListPrimary
          .removeWhere((element) => element == _imagesWidgetListPrimary.last);
      images.add(File(_image!.path));
      _imagesWidgetListPrimary.add(Image.file(File(_image.path)));

      _imagesWidgetListPrimary.add(imagePickerWidget(widget.size));
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title:
            Text("Add Adoption", style: Theme.of(context).textTheme.headline3),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: size.height * 0.3,
                width: size.width,
                child: _imagesWidgetListPrimary.length == 0
                    ? imagePickerWidget(size)
                    : slider(size),
              ),
              addPetdataField()
            ],
          ),
        ),
      ),
    );
  }

  //image picker widget
  Widget imagePickerWidget(Size size) {
    return InkWell(
      onTap: () async {
        await pickImage();
      },
      child: Center(
          child: Container(
        padding: EdgeInsets.symmetric(vertical: 8),
        height: size.height * 0.27,
        width: size.width * 0.5,
        decoration: BoxDecoration(
            color: FloofTheme.PRIMARY_COLOR,
            // border: Border.all(color: FloofTheme.FONT_DARK_COLOR),
            borderRadius: BorderRadius.circular(35),
            boxShadow: [BoxShadow(blurRadius: 5, color: Colors.grey)]),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Icon(
            Icons.add_a_photo,
            size: 45,
          ),
          Text(
            "Add image \nof your pet",
            style: Theme.of(context).textTheme.bodyText2,
          )
        ]),
      )),
    );
  }

  // CarouselSlider
  Widget slider(Size size) {
    return CarouselSlider(
      children: _imagesWidgetListPrimary,
      initialPage: _imagesWidgetListPrimary.length + 1,
      viewportFraction: 1,
      unlimitedMode: false,
      slideIndicator: CircularSlideIndicator(
        alignment: Alignment.bottomCenter,
        currentIndicatorColor: FloofTheme.FONT_DARK_COLOR,
      ),
    );
  }

//add pet data widgets
  Form addPetdataField() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Text(
              "Name of Pet :",
              style: Theme.of(context).textTheme.bodyText2,
            ),
          ),
          TextFormField(
            decoration: InputDecoration(hintText: 'pet name'),
            onSaved: (newValue) => petName = newValue!,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Pet name cannot be empty!';
              }
              return null;
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Text(
              "Age :",
              style: Theme.of(context).textTheme.bodyText2,
            ),
          ),
          TextFormField(
            decoration: InputDecoration(hintText: 'pet age'),
            onSaved: (newValue) => petAge = int.parse(newValue!.trim()),
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Pet age cannot be empty!';
              }

              return null;
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Text(
              "Description about pet :",
              style: Theme.of(context).textTheme.bodyText2,
            ),
          ),
          TextFormField(
            decoration: InputDecoration(hintText: 'pet description'),
            onSaved: (newValue) => description = newValue!,
            keyboardType: TextInputType.multiline,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Pet description cannot be empty!';
              }

              return null;
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Text(
              "Gender :",
              style: Theme.of(context).textTheme.bodyText2,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Radio(
                value: 0,
                groupValue: _radioSelected,
                // activeColor: Colors.blue,
                onChanged: (int? value) {
                  setState(() {
                    _radioSelected = value!;
                  });
                },
              ),
              Text('Male'),
              Radio(
                value: 1,
                groupValue: _radioSelected,
                // activeColor: Colors.pink,
                onChanged: (int? value) {
                  setState(() {
                    _radioSelected = value!;
                  });
                },
              ),
              Text('Female'),
            ],
          ),
          DropdownButton<String>(
            elevation: 5,
            hint: Text(
              _selectedCategory.isEmpty
                  ? 'Please choose category'
                  : _selectedCategory,
              style: Theme.of(context).textTheme.bodyText2,
            ),
            // value: 'choose',
            onChanged: (String? newValue) {
              setState(() {
                _selectedCategory = newValue!;
              });
            },
            items: animalCategory
                .map<DropdownMenuItem<String>>((String currentCategory) {
              return DropdownMenuItem(
                child: Text(
                  currentCategory,
                  style: Theme.of(context).textTheme.bodyText2,
                ),
                value: currentCategory,
              );
            }).toList(),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: DropdownButton<String>(
              elevation: 5,
              hint: Text(
                _selectedBreed.isEmpty ? 'Please choose breed' : _selectedBreed,
                style: Theme.of(context).textTheme.bodyText2,
              ),
              // value: 'choose',
              onChanged: (String? newValue) {
                setState(() {
                  _selectedBreed = newValue!;
                });
              },
              items: breedData[_selectedCategory]!
                  .map<DropdownMenuItem<String>>((String currentBreed) {
                return DropdownMenuItem(
                  child: Text(
                    currentBreed,
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                  value: currentBreed,
                );
              }).toList(),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: ElevatedButton(
                onPressed: () async {
                  await addPetForAdoption();
                },
                child: Text('Submit',
                    style: Theme.of(context).textTheme.headline2)),
          )
        ],
      ),
    );
  }

  Future<void> addPetForAdoption() async {
    bool validate = _formKey.currentState!.validate();
    if (validate && _selectedBreed != '' && _selectedCategory != '') {
      _formKey.currentState!.save();

      //creating new instance of petmodel
      PetModel newPet = PetModel(
        name: petName,
        id: '',
        age: petAge,
        breed: _selectedBreed,
        category: _selectedCategory,
        ownerId: _loginProvider.userData.userId,
        description: description,
        images: [],
        geneder: _radioSelected == 0 ? 'Male' : 'Female',
        lat: _userProvider.locationData.latitude!,
        long: _userProvider.locationData.longitude!,
      );
      await _petProvider.addPetForAdoption(newPet, images);

      Get.off(HomeScreen());
    } else if (_selectedBreed == '') {
      Get.snackbar('Error', 'Select appropriate breed');
    } else if (_selectedCategory == '') {
      Get.snackbar('Error', 'Select appropriate category');
    }
  }
}
