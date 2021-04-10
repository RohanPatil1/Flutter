import 'dart:io';

import 'package:fbk_clone/core/models/user.dart';
import 'package:fbk_clone/core/services/auth_service.dart';
import 'package:fbk_clone/core/services/firebase_storage_service.dart';
import 'package:fbk_clone/core/services/firestore_service.dart';
import 'package:fbk_clone/core/viewmodels/base_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as Img;
import 'package:path_provider/path_provider.dart';

import 'package:uuid/uuid.dart';

import '../../locator.dart';

class UploadPostViewModel extends BaseModel {
  final FirestoreService _firestoreService = locator<FirestoreService>();
  final FirebaseStorageService _firebaseStorageService =
      locator<FirebaseStorageService>();
  final AuthService _authService = locator<AuthService>();
  final picker = ImagePicker();
  String postID = Uuid().v4();

  UserData _currUser;

  UserData get currUser => _currUser;

  File _image;

  File get image => _image;

  //OnModelReady==>
  Future getUserName() async {
    UserData user = _authService.currUser;
    _currUser = user;
    notifyListeners();
    print("=================================");
    print(user.fullName);
    print("=================================");
  }

  uploadPost() async {
    setBusy(true);
    await compressImg();
    String downloadUrl =
        await _firebaseStorageService.uploadImage(image, postID);

    await _firestoreService.storePostData(
        currUser, downloadUrl, "This is my caption", postID);

    setBusy(false);
    _image = null;
    postID = Uuid().v4();
    notifyListeners();
  }

  compressImg() async {
    final tempDir = await getTemporaryDirectory();
    final path = tempDir.path;
    Img.Image mImage = Img.decodeImage(image.readAsBytesSync());
    final compressedImg = File('$path/post_$postID.jpg')
      ..writeAsBytesSync(Img.encodeJpg(mImage, quality: 60));
    _image = compressedImg;
  }

  uploadImageFromCamera() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    _image = File(pickedFile.path);
  }

  uploadImageFromGallery() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    _image = File(pickedFile.path);
    notifyListeners();
  }
//
// pickImage() {
//   return showDialog(
//     context: context,
//     builder: (context) {
//       return UploadDialog(
//         pickFromGallery: uploadImageFromGallery,
//         pickFromCamera: uploadImageFromCamera,
//       );
//     },
//   );
// }

}
