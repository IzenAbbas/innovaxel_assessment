import 'package:cloud_firestore/cloud_firestore.dart';

class LocalDbService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> initializeLocalDatabase() async {
    _firestore.settings = const Settings(
      persistenceEnabled: true,
      cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED,
    );
  }
}
