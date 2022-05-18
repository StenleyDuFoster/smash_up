import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:smash_up/domain/db_model/fraction_db_model.dart';

class FirestoreManager {
  FirestoreManager._privateConstructor();

  static FirestoreManager? _instance;

  static FirestoreManager instance() {
    FirestoreManager? localInstance = _instance;
    if (localInstance != null) {
      return localInstance;
    } else {
      FirestoreManager newInstance = FirestoreManager._privateConstructor();
      _instance = newInstance;
      return newInstance;
    }
  }

  FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  final String _fractionCollection = "fraction";

  Future<List<FractionDbModel>> getFraction() async {
    try {
      var data = await _fireStore.collection(_fractionCollection).get();
      print("start");

      List<FractionDbModel> dataList = [];

      await Future.forEach(
          data.docs.map((e) {
            return FractionDbModel.fromJson(e.data());
          }).toList(), (FractionDbModel element) async {
        String? url = element.imageNetwork;
        FractionDbModel newElement = element;
        if (url != null) {
          try {
            newElement.imageNetwork = await FirebaseStorage.instance
                .refFromURL(element.imageNetwork ?? "")
                .getDownloadURL();
          } catch (_) {

          }
        }
        dataList.add(newElement);
      });

      return dataList;
    } catch (e) {
      print(e);
      return List.empty();
    }
  }
}
