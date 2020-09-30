import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:luffyvio/data_models/user_data.dart';
import 'package:luffyvio/screens/profile_screen.dart';

class SearchUserTile extends StatelessWidget {
  final User currUser;

  SearchUserTile(this.currUser);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        //Go to search results profile page
        print("[onTap() of InkWell==>userId: + ${currUser.id}]");
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProfileScreen(
                userProfileId: currUser.id,
              ),
            ));
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 0.0, vertical: 4.0),
        decoration: BoxDecoration(
color: Colors.transparent,
          borderRadius: BorderRadius.circular(20.0)
        ),
        child: ListTile(
          leading: CircleAvatar(
            backgroundImage: CachedNetworkImageProvider(currUser.imgUrl),
          ),
          title: Text(
            currUser.fullName,
            style: TextStyle(color: Colors.white, fontSize: 17.0,fontFamily: "RalewayBold"),
          ),
          subtitle: Text(
            currUser.userName,
            style: TextStyle(color: Colors.white, fontSize: 13.0,fontFamily: "Lato"),
          ),
        ),
      ),
    );
  }
}
