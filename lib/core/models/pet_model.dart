class PetModel {
  late String name;
  late String id;
  late String breed;
  late String category;
  late String ownerId;
  late String description;
  late int age;

  PetModel({
    required this.name,
    required this.id,
    required this.age,
    required this.breed,
    required this.category,
    required this.ownerId,
    required this.description,
  });

  factory PetModel.fromJson(Map<String, dynamic> data) {
    assert(data.isEmpty, 'Pet Data cannot be null!');
    return PetModel(
        name: data['name'],
        id: data['id'],
        age: data['age'],
        breed: data['breed'],
        category: data['category'],
        ownerId: data['ownerId'],
        description: data['description']);
  }

  Map<String, dynamic> toJson(PetModel petData) {
    return {
      'name': petData.name,
      'id': petData.id,
      'age': petData.age,
      'breed': petData.breed,
      'category': petData.category,
      'ownerId': petData.ownerId,
      'description': petData.description
    };
  }
}
