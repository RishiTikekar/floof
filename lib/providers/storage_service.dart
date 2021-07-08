import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
//  as storage_service;

class StorageService {
  FirebaseStorage storage = FirebaseStorage.instance;

  Future<List<String>> uploadFiles(List<File> files, String id) async {
    List<String> allUrl = [];
    String current;

    files.forEach((file) async {
      int index = files.indexOf(file);
      print(index);
      current = await uploadSingleFile(file, id, index);
      allUrl.add(current);
    });

    print(allUrl);
    return allUrl;
  }

  Future<String> uploadSingleFile(File file, String id, int index) async {
    try {
      print(file);
      print("*********");
      Reference reference = storage
          .ref()
          .child('pet images')
          .child(id)
          .child(id + "_" + index.toString());

      final UploadTask uploadTask = reference.putFile(file);

      final TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});

      final url = await taskSnapshot.ref.getDownloadURL();

      return url;
    } catch (PlatFormException) {
      print(PlatFormException.toString());
      return 'data ka zol';
    }
  }
}
