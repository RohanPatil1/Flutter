import 'package:fbk_clone/core/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:fbk_clone/ui/widgets/widgets.dart';

class UserCard extends StatelessWidget {
  final ChgUser user;

  const UserCard({
    Key key,
    @required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          ProfileAvatar(imageUrl: user.imageUrl),
          const SizedBox(width: 6.0),
          Flexible(
            child: Text(
              user.name,
              style: const TextStyle(fontSize: 16.0),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
