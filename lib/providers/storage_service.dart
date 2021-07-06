import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
//  as storage_service;

class StorageService {
  FirebaseStorage storage = FirebaseStorage.instance;

  Future<List<String>> uploadFiles(List<File> files, String id) async {
    List<String> allUrl = [];

    files.map((file) async {
      allUrl.add(await uploadSingleFile(file, id));
    });

    return allUrl;
  }

  Future<String> uploadSingleFile(File file, String id) async {
    try {
      Reference reference = storage.ref().child('pet images').child(id);

      final UploadTask uploadTask = reference.putFile(file);

      final TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});

      final url = await taskSnapshot.ref.getDownloadURL();

      return url;
    } catch (PlatFormException) {
      print(PlatFormException.toString());
      return 'null';
    }
  }
}
