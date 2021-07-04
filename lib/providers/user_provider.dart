import 'package:floof/core/models/user_model.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserProvider extends GetxController {
  CollectionReference _userCollection =
      FirebaseFirestore.instance.collection('user');

//adding new userData to firebase
  Future<void> addUser(UserModel userModel) async {
    try {
      await _userCollection.doc(userModel.userId).get()
          //
          .then((DocumentSnapshot snapshot) {
        //
        if (!snapshot.exists) {
          _userCollection
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
}
