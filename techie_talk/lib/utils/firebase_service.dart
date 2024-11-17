import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseService {
  static late FirebaseFirestore _fireStore;
  static late FirebaseAuth _auth;

  static init() {
    _fireStore = FirebaseFirestore.instance;
    _auth = FirebaseAuth.instance;
  }

  FirebaseService._internal();

  static FirebaseFirestore get fireStore => _fireStore;

  static FirebaseAuth get auth => _auth;
}
