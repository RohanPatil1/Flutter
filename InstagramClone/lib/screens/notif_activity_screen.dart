import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:luffyvio/screens/home_screen.dart';
import 'package:luffyvio/widgets/custom_appbar.dart';
import 'package:luffyvio/widgets/notif_tile.dart';
import 'package:video_player/video_player.dart';

class NotifActivityScreen extends StatefulWidget {
  @override
  _NotifActivityScreenState createState() => _NotifActivityScreenState();
}

class _NotifActivityScreenState extends State<NotifActivityScreen> {

  VideoPlayerController _notifBgCtrl;
  @override
  void initState() {
    // TODO: implement initState
    _notifBgCtrl = VideoPlayerController.asset(
        'assets/videos/bg4.mp4')
      ..initialize().then((_) {

        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        _notifBgCtrl.play();
        _notifBgCtrl.setLooping(true);

        setState(() {});
      });

    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _notifBgCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Stack(
        children: [
          SizedBox.expand(
            child: FittedBox(
              fit: BoxFit.fill,
              child: SizedBox(
                width: _notifBgCtrl.value.size?.width ?? 0,
                height: _notifBgCtrl.value.size?.height ?? 0,
                child: VideoPlayer(_notifBgCtrl),
              ),
            ),
          ),


          Positioned(
              bottom: 0,
              left: 160,
              child: Image.asset(
                "assets/images/rias.png",
                fit: BoxFit.cover,
                width: 240,
              )),
          Align(
            alignment: Alignment.topCenter,
            child: Column(
              children: [
                SizedBox(
                  height: 140.0,
                  width: 0,
                ),
                Container(
                  height: 300.0,
                  width: MediaQuery.of(context).size.width,
                  child: FutureBuilder(
                    future: fetchNotif(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }


                      return ListView(
                        children: snapshot.data,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  fetchNotif() async {
    QuerySnapshot notifQuerySnapshot = await feedCollectionRef
        .document(currUserData.id)
        .collection("feedItems")
        .orderBy("timeStamp", descending: true)
        .limit(60)
        .getDocuments();

    List<NotificationTile> notifDataList = [];
    int size=0;
    notifQuerySnapshot.documents.forEach((doc) {
      notifDataList.add(NotificationTile.fromDocument(doc));
    });
    // size=notifDataList.length;
    // notifDataList.removeAt(0);
    return notifDataList;
  }
}
