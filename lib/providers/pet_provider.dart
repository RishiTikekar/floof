import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:floof/core/models/pet_model.dart';
import 'package:floof/providers/storage_service.dart';
import 'package:get/get.dart';

class PetProvider extends GetxController {
  CollectionReference _petCollection =
      FirebaseFirestore.instance.collection('pet');
  Future<void> addPetForAdoption(PetModel petModel, List<File> files) async {
    try {
      CollectionReference reference =
          _petCollection.doc(petModel.category).collection(petModel.breed);

      reference.add(petModel.toJson(petModel)).then((value) {
        StorageService()
          ..uploadFiles(files, value.id).then((list) {
            reference.doc(value.id).update({'images': list, 'id': value.id});
          });
      });

      // reference.
    } catch (PlatFormException) {
      print(PlatFormException.toString());
    }
  }

  // Future<List<PetModel>> getPetFromCategory(String category) async {
  //   try {
  //     List<PetModel> petList = [];
  //     DocumentSnapshot snapshot = await _petCollection.doc(category).get();
  //     // QuerySnapshot snap = snapshot.data() as QuerySnapshot;

  //   } catch (PlatFormExceptio) {
  //     print(PlatFormExceptio.toString());
  //   }
  // }
}
