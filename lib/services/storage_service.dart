import 'package:disaster_hackathon_app/utils/storage_constants.dart';
import 'package:get_storage/get_storage.dart';

class StorageService {
  static final GetStorage storage = GetStorage();

  // To get the user session
  static String getUserSession = storage.read(StorageConstants.authKey);
}
