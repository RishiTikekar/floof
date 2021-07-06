import 'package:firebase_auth/firebase_auth.dart';
import 'package:floof/core/models/user_model.dart';
import 'package:floof/presentation/login_screen.dart';
import 'package:floof/providers/user_provider.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:get/get.dart';

import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class LoginProvider extends GetxController {
  late UserModel _user;

  //getter for userdata
  UserModel get userData => _user;

  //setter for user data
  set userData(UserModel user) {
    _user = user;
    update();
  }

//facebook login
  Future<bool> signInWithFacebook() async {
    try {
      final LoginResult result = await FacebookAuth.instance.login();

      if (result.status == LoginStatus.success) {
        print(result.status.toString());
        final AccessToken accessToken = result.accessToken!;

        final OAuthCredential credential =
            FacebookAuthProvider.credential(accessToken.token);

        final UserCredential userCredential =
            await FirebaseAuth.instance.signInWithCredential(credential);

        userData = UserModel(
            userId: userCredential.user!.uid,
            email: userCredential.user!.email as String,
            name: userCredential.user!.displayName as String,
            photoUrl: userCredential.user!.photoURL as String,
            lat: 0.0,
            long: 0.0,
            petAdvertiseId: '',
            provider: 'Facebook',
            favouritList: []);

        //adding new user data
        UserProvider _userProvider = Get.find<UserProvider>();
        await _userProvider.addUser(userData);

        Get.snackbar('Logged in successfully', '');
        return true;
      }
      return false;
    } catch (PlatFormException) {
      print(PlatFormException.toString());

      Get.snackbar(PlatFormException.toString(), '');

      return false;
    }
  }

//facebook logout
  Future<bool> logoutFacebook() async {
    try {
      await FacebookAuth.instance.logOut();

      await FirebaseAuth.instance.signOut();

      Get.offAll(() => LoginScreen());

      return true;
    } catch (PlatFormException) {
      print(PlatFormException.toString());

      Get.snackbar(PlatFormException.toString(), '');

      return false;
    }
  }

//google sign in
  Future<bool> signInWithGoogle() async {
    try {
      GoogleSignIn _googleSignIn = GoogleSignIn();
      //sign in with google
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();

      if (googleSignInAccount != null) {
        GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;

        AuthCredential authCredential = GoogleAuthProvider.credential(
            accessToken: googleSignInAuthentication.accessToken,
            idToken: googleSignInAuthentication.idToken);

        final UserCredential userCredential =
            await FirebaseAuth.instance.signInWithCredential(authCredential);

        userData = UserModel(
            userId: userCredential.user!.uid,
            email: userCredential.user!.email as String,
            name: userCredential.user!.displayName as String,
            photoUrl: userCredential.user!.photoURL as String,
            lat: 0.0,
            long: 0.0,
            petAdvertiseId: '',
            favouritList: [],
            provider: 'Google');
      }
      //adding new user data to database
      UserProvider _userProvider = Get.find<UserProvider>();
      await _userProvider.addUser(userData);
      Get.snackbar('Logged in successfully', '');

      return true;
    } catch (PlatFormException) {
      print(PlatFormException.toString());

      Get.snackbar(PlatFormException.toString(), '');

      return false;
    }
  }

//google signout
  Future<bool> signOutGoogle() async {
    try {
      GoogleSignIn _googleSignIn = GoogleSignIn();

      await FirebaseAuth.instance.signOut();

      await _googleSignIn.signOut();

      Get.offAll(() => LoginScreen());

      return true;
    } catch (PlatFormException) {
      Get.snackbar('Error', PlatFormException.toString());

      return false;
    }
  }
}
