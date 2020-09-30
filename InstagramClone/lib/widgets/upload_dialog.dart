import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class UploadDialog extends StatelessWidget {
  final Function pickFromGallery, pickFromCamera;

  const UploadDialog({Key key, this.pickFromGallery, this.pickFromCamera})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        width: 300.0,
        height: 500.0,
        child: Stack(
          children: [
            ClipPath(
              clipper: BackgroundClipper(),
              child: Container(
                width: 280.0,
                height: 500.0,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.orange, Color(0xfff12711)],
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 12.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                           onTap: () => pickFromCamera(),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 40.0,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(18.0),
                                gradient: LinearGradient(
                                    colors: [Color(0xff8E2DE2),Color(0xff4A00E0)]
                                )
                            ),
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(FontAwesomeIcons.cameraRetro,color: Colors.white,size: 18,),
                                  Text(
                                    "Upload From Camera",
                                    style: TextStyle(
                                        fontFamily: "RalewayBold",
                                        fontSize: 14.0,
                                        color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                           onTap: () => pickFromGallery(),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 40.0,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(18.0),
                            gradient: LinearGradient(
                              colors: [Color(0xff8E2DE2),Color(0xff4A00E0)]
                            )
                            ),
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(FontAwesomeIcons.images,color: Colors.white,size: 18,),
                                  Text(
                                    "Upload From Gallery",
                                    style: TextStyle(
                                        fontFamily: "RalewayBold",
                                        fontSize: 14.0,
                                        color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          Navigator.of(context, rootNavigator: true).pop('dialog');

                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Cancel",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.0,
                                shadows: <Shadow>[
                                  Shadow(
                                    offset: Offset(1.0, 1.0),
                                    blurRadius: 1.2,
                                    color: Colors.black.withOpacity(0.2),
                                  ),
                                ],
                                fontFamily: "Raleway"),
                          ),
                        ),
                      ),


                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: 0.0,
              right: -40.0,
              child: Image.asset(
                "assets/images/mha.png",
                height: 300.0,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BackgroundClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var roundnessFactor = 50.0;

    var path = Path();

    path.moveTo(0, size.height * 0.33);
    path.lineTo(0, size.height - roundnessFactor);
    path.quadraticBezierTo(0, size.height, roundnessFactor, size.height);
    path.lineTo(size.width - roundnessFactor, size.height);
    path.quadraticBezierTo(
        size.width, size.height, size.width, size.height - roundnessFactor);
    path.lineTo(size.width, roundnessFactor * 2);
    path.quadraticBezierTo(size.width - 10, roundnessFactor,
        size.width - roundnessFactor * 1.5, roundnessFactor * 1.5);
    path.lineTo(
        roundnessFactor * 0.6, size.height * 0.33 - roundnessFactor * 0.3);
    path.quadraticBezierTo(
        0, size.height * 0.33, 0, size.height * 0.33 + roundnessFactor);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
