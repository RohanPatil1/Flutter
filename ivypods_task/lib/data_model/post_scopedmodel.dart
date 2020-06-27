import 'dart:io';

import 'package:ivypodstask/utils/utils.dart';
import 'package:scoped_model/scoped_model.dart';

class PostScopedModel extends Model {
  List<Map<String, dynamic>> _posts = [];

  List<Map<String, dynamic>> get posts => _posts;

  bool _isLoading = false;

  bool get isLoading => _isLoading;
  bool _isEmpty = false;

  bool get isEmpty => _isEmpty;

  getData() async {
    _isLoading = true;
    notifyListeners();

    Utils _apiUtils = Utils();

    _posts = await _apiUtils.fetchPosts();
    if (_posts.isEmpty) {
      _isEmpty = true;
      notifyListeners();
    }
    if (_posts.isNotEmpty) {
      _isEmpty = false;
      notifyListeners();
    }

    _isLoading = false;
    notifyListeners();
  }

  uploadPost(File image) async {
    _isLoading = true;
    notifyListeners();
    Utils _apiUtils = Utils();

    _posts = await _apiUtils.uploadImage(image);
    _isLoading = false;
    _isEmpty = false;
    notifyListeners();
  }

  getLikeStatus(int index) {
    Map<String, dynamic> post = posts[index];
    var _list = post.values.toList();
    String likeStatus = _list[1].toString();
    return likeStatus;
  }
}
