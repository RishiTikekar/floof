class PetModel {
  late String name;
  late String id;
  late String breed;
  late String category;
  late String ownerId;
  late String description;
  late int age;
  late List<String> images = [];
  late String geneder;
  late double lat;
  late double long;

  PetModel(
      {required this.name,
      required this.id,
      required this.age,
      required this.breed,
      required this.category,
      required this.ownerId,
      required this.description,
      required this.images,
      required this.geneder,
      required this.lat,
      required this.long});

  factory PetModel.fromJson(Map<String, dynamic> data, String id) {
    assert(data.isEmpty, 'Pet Data cannot be null!');
    return PetModel(
        name: data['name'],
        id: id,
        age: data['age'],
        breed: data['breed'],
        category: data['category'],
        ownerId: data['ownerId'],
        description: data['description'],
        images: data['images'],
        geneder: data['gender'],
        lat: data['lat'],
        long: data['long']);
  }

  Map<String, dynamic> toJson(PetModel petData) {
    return {
      'name': petData.name,
      'id': petData.id,
      'age': petData.age,
      'breed': petData.breed,
      'category': petData.category,
      'ownerId': petData.ownerId,
      'description': petData.description,
      'gender': petData.geneder,
      'images': petData.images,
      'lat': petData.lat,
      'long': petData.long
    };
  }
}
