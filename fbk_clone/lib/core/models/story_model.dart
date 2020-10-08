import 'package:meta/meta.dart';
import 'models.dart';
class Story {
  final ChgUser user;
  final String imageUrl;
  final bool isViewed;

  const Story({
    @required this.user,
    @required this.imageUrl,
    this.isViewed = false,
  });
}
