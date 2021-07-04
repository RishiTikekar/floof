class UserModel {
  late String userId;
  late String email;
  late String name;
  late String photoUrl;
  late String provider;
  late String petAdvertiseId;
  UserModel(
      {required this.userId,
      required this.email,
      required this.name,
      required this.photoUrl,
      required this.petAdvertiseId,
      required this.provider});
  factory UserModel.fromJson(Map<String, dynamic> mapData, String id) {
    assert(mapData.isEmpty, 'Null User data recieved!');

    return UserModel(
        userId: id,
        email: mapData['email'],
        name: mapData['name'],
        photoUrl: mapData['photoUrl'],
        petAdvertiseId: mapData['petAdvertiseId'],
        provider: mapData['provider']);
  }
  Map<String, dynamic> toJson(UserModel userModel) {
    return {
      'userId': userModel.userId,
      'email': userModel.email,
      'name': userModel.name,
      'photoUrl': userModel.photoUrl,
      'petAdvertiseId': userModel.petAdvertiseId,
      'provider': userModel.provider
    };
  }
}
