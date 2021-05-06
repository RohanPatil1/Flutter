import 'package:chill_sounds/data/nightMode.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class Favorite extends StatelessWidget {
  final void Function() onBack;

  const Favorite({
    Key? key,
    required this.onBack,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        onBack();
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
            'Favorite',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
          actions: [
            IconButton(icon: Icon(Icons.clear), onPressed: onBack),
          ],
        ),
        body: ListView(
          children: [
            for (int i = 0; i < 5; i++)
              Container(
                margin: EdgeInsets.all(16),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(44.0),
                  gradient: LinearGradient(
                    begin: Alignment(0.0, -1.0),
                    end: Alignment(0.0, 1.0),
                    colors: [const Color(0x24494949), const Color(0x24ffffff)],
                    stops: [0.0, 1.0],
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListTile(
                      leading: Text(
                        'Favourite',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                      trailing: IconTheme(
                        data: IconThemeData(color: Colors.white),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Lottie.asset(
                              'assets/icons/playPause.json',
                              width: 46,
                              height: 46,
                            ),
                            IconButton(
                                icon: Icon(Icons.edit), onPressed: () {}),
                            IconButton(
                                icon: Icon(Icons.delete), onPressed: () {}),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            for (int i = 0; i < 16; i++)
                              Container(
                                margin: EdgeInsets.only(right: 16),
                                width: 38,
                                height: 38,
                                decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.3),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(14),
                                    ),
                                    border: Border.all(
                                      color: Colors.white.withOpacity(
                                          Provider.of<NightMode>(context)
                                                  .isNight
                                              ? 0.6
                                              : 0.8),
                                    )),
                                child: Icon(
                                  Icons.favorite_border,
                                  color: Theme.of(context)
                                      .iconTheme
                                      .color!
                                      .withOpacity(
                                          Provider.of<NightMode>(context)
                                                  .isNight
                                              ? 0.6
                                              : 0.8),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
