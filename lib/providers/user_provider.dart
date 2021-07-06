import 'package:floof/core/models/user_model.dart';
import 'package:floof/providers/login_provider.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:location/location.dart';

class UserProvider extends GetxController {
  LoginProvider _loginProvider = Get.find<LoginProvider>();
  late LocationData currentUserLocation;

  LocationData get locationData => currentUserLocation;
  set locationData(LocationData location) {
    currentUserLocation = location;
    update();
  }

  CollectionReference _userCollection =
      FirebaseFirestore.instance.collection('user');

//adding new userData to firebase
  Future<void> addUser(UserModel userModel) async {
    try {
      await _userCollection.doc(userModel.userId).get()
          //
          .then((DocumentSnapshot snapshot) async {
        //
        if (!snapshot.exists) {
          await _userCollection
              .doc(userModel.userId)
              .set(userModel.toJson(userModel));
        }
        //
      });
      //

    } catch (PlatformException) {
      print(PlatformException.toString());

      Get.snackbar('Error', PlatformException.toString());
    }
  }

  //get user location
  Future<void> getUserLocation() async {
    late bool _servicesEnabled;

    Location location = Location();

    late PermissionStatus _permissionStatus;

    _servicesEnabled = await location.serviceEnabled();
    if (!_servicesEnabled) {
      _servicesEnabled = await location.requestService();
      if (!_servicesEnabled) {
        return;
      }
    }
    _permissionStatus = await location.hasPermission();
    if (_permissionStatus == PermissionStatus.denied) {
      _permissionStatus = await location.requestPermission();
      if (_permissionStatus == PermissionStatus.granted) {
        return;
      }
    }
    locationData = await location.getLocation();
    _loginProvider.userData.lat = locationData.latitude!;
    _loginProvider.userData.long = locationData.longitude!;
    update();
  }
}
