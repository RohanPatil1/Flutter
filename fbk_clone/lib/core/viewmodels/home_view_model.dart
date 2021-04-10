import 'package:fbk_clone/core/models/post_model.dart';
import 'package:fbk_clone/core/models/user.dart';
import 'package:fbk_clone/core/services/auth_service.dart';
import 'package:fbk_clone/core/services/firestore_service.dart';
import 'package:fbk_clone/core/viewmodels/base_model.dart';

import '../../locator.dart';

class HomeViewModel extends BaseModel {
  final FirestoreService _firestoreService = locator<FirestoreService>();
  final AuthService _authService = locator<AuthService>();

  List<Post> _posts;

  List<Post> get posts => _posts;

  UserData _currUser;

  UserData get currUser => _currUser;

  Future getUserName() async {
    UserData user = _authService.currUser;
    _currUser = user;
    notifyListeners();
    print("=================================");
    print(user.fullName);
    print("=================================");
  }

  Future fetchPosts() async {
    setBusy(true);
    _posts = await _firestoreService.getAllPost(currUser.id);
    setBusy(false);
    notifyListeners();
  }
}
