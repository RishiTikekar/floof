import 'package:floof/providers/login_provider.dart';
import 'package:floof/providers/user_provider.dart';
import 'package:get/get.dart';

void initProvider() {
  //login provider
  // ignore: unused_local_variable
  LoginProvider _loginProvider = Get.put(LoginProvider());

  //User provider injection
  // ignore: unused_local_variable
  UserProvider _userProvider = Get.put(UserProvider());
}
