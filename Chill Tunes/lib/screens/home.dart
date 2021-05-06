import 'dart:async';

import 'package:chill_sounds/data/audioBrain.dart';
import 'package:chill_sounds/data/modal.dart';
import 'package:chill_sounds/data/nightMode.dart';
import 'package:chill_sounds/widgets/lottieButton.dart';
import 'package:chill_sounds/widgets/soundTile.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  final void Function() onFavourite;
  final void Function() onDrawerTap;

  Home({Key? key, required this.onFavourite, required this.onDrawerTap})
      : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  bool _isDataLoaded = false;
  double lottieInitPos = 0.0;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();

    initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    fetchData();
    _tabController =
        new TabController(length: Category.categories.length, vsync: this);

    if (Provider.of<NightMode>(context, listen: false).isNight) {
      lottieInitPos = 0.5;
    } else {
      lottieInitPos = 0.0;
    }
  }

  Future<void> initConnectivity() async {
    late ConnectivityResult result;
    try {
      result = await _connectivity.checkConnectivity();
      print("CONNECTION RESULT: $result");
    } on PlatformException catch (e) {
      print(e.toString());
      return;
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    setState(() {
      _connectionStatus = result;
    });
  }

  Future<void> fetchData() async {
    if (_isDataLoaded) return;

    try {
      await Category.getCategories();
      await Sound.getSounds();
      AudioBrain.init();
    } catch (e) {
      print('Error #3242 = $e');
    }

    /// handling cases

    if ((Sound.sounds.isEmpty || Category.categories.isEmpty) &&
        _connectionStatus != ConnectivityResult.none) {
      Fluttertoast.showToast(msg: 'Internet Is Required To Download Sounds!');
    }

    setState(() {
      _isDataLoaded = true;
      print("CAT LEN: ${Category.categories.length}");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.37,
          ),
          TabBar(
            controller: _tabController,
            isScrollable: true,
            indicator: BoxDecoration(),
            unselectedLabelColor: Colors.white.withOpacity(0.6),
            labelStyle: TextStyle(
                fontSize: 18.0,
                color: Colors.white,
                fontFamily: 'PoppinsMedium'),
            labelColor: Colors.white,
            unselectedLabelStyle: TextStyle(
                fontSize: 14.0,
                color: Colors.red.withOpacity(0.4),
                fontFamily: 'PoppinsLight'),
            tabs: [
              for (int i = 0; i < Category.categories.length; i++)
                Tab(
                  text: Category.categories[i].name,
                  // child: Text(
                  //   Category.categories[i].name,
                  //   style: TextStyle(fontSize: 18.0, color: Colors.white),
                  // ),
                ),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                for (int i = 0; i < Category.categories.length; i++)
                  GridView.count(
                    physics: ScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    crossAxisCount: 4,
                    children: [
                      for (Sound sound in Sound.sounds
                          .where((element) =>
                              element.categoryId ==
                              Category.categories[i].categoryId)
                          .toList())
                        SoundTile(
                          sound: sound,
                          isConnectedToNetwork:
                              _connectionStatus != ConnectivityResult.none,
                        ),
                    ],
                  )
              ],
            ),
          ),
          //Bottom Padding for Grid
          Container(
            height: 60.0,
            width: 200.0,
          ),
        ],
      ),
    );
  }

  /*
      child: Row(
        // crossAxisAlignment: CrossAxisAlignment.center,

        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,

        mainAxisSize: MainAxisSize.max,
        children: [
          // Container(
          //   height: MediaQuery.of(context).size.height * 0.37,
          // ),
          Expanded(
            flex: 1,
            child: RotatedBox(
              quarterTurns: 3,
              child: Container(
                color: Colors.blue,
                child: TabBar(
                  controller: _tabController,
                  isScrollable: true,
                  indicator: BoxDecoration(),
                  unselectedLabelColor: const Color(0x60f2f2f2),
                  tabs: [
                    for (int i = 0; i < Category.categories.length; i++)
                      Tab(
                        text: Category.categories[i].name,
                      ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: RotatedBox(
              quarterTurns: 0,
              child: TabBarView(
                controller: _tabController,
                children: [
                  for (int i = 0; i < Category.categories.length; i++)
                    GridView.count(
                      physics: ScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      crossAxisCount: 4,
                      children: [
                        for (Sound sound in Sound.sounds
                            .where((element) =>
                                element.categoryId ==
                                Category.categories[i].categoryId)
                            .toList())
                          SoundTile(
                            sound: sound,
                            isConnectedToNetwork:
                                _connectionStatus != ConnectivityResult.none,
                          ),
                        for (Sound sound in Sound.sounds
                            .where((element) =>
                                element.categoryId ==
                                Category.categories[i].categoryId)
                            .toList())
                          SoundTile(
                            sound: sound,
                            isConnectedToNetwork:
                                _connectionStatus != ConnectivityResult.none,
                          ),
                        for (Sound sound in Sound.sounds
                            .where((element) =>
                                element.categoryId ==
                                Category.categories[i].categoryId)
                            .toList())
                          SoundTile(
                            sound: sound,
                            isConnectedToNetwork:
                                _connectionStatus != ConnectivityResult.none,
                          ),
                      ],
                    )
                ],
              ),
            ),
          ),
          //Bottom Padding for Grid
          // Container(
          //   height: 60.0,
          //   width: 200.0,
          // ),
        ],
      ),
   */

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }
}
