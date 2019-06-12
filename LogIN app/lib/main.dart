import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:flutter_twitter_login/flutter_twitter_login.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyMainPage(),
  ));
}

class MyMainPage extends StatefulWidget {
  @override
  _MyMainPageState createState() => _MyMainPageState();
}

class _MyMainPageState extends State<MyMainPage> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  bool isLogged = false;

  FirebaseUser myUser;

  Future<FirebaseUser> _loginWithFacebook() async {
    var facebookLogin = new FacebookLogin();
    var result = await facebookLogin.logInWithReadPermissions(['email']);

    debugPrint(result.status.toString());

    if (result.status == FacebookLoginStatus.loggedIn) {
      FirebaseUser user =
          await _auth.signInWithFacebook(accessToken: result.accessToken.token);
      return user;
    }
    return null;
  }

  Widget _goToProfile(BuildContext context) {
    FirebaseUser userr = this.myUser;
    return ProfilePage(userr);
  }

  Future<FirebaseUser> _loginWithTwitter() async {
    var twitterLogin = new TwitterLogin(
      consumerKey: 'vyic4oWdXISkTqcZssGI0Xrb1 ',
      consumerSecret: '8Ow5I6B1baNuH3wZJzavfudsAfk1sXLTvafu7VMzNz14lgu9je ',
    );

    final TwitterLoginResult result = await twitterLogin.authorize();

    switch (result.status) {
      case TwitterLoginStatus.loggedIn:
        var session = result.session;
        FirebaseUser user = await _auth.signInWithTwitter(
            authToken: session.token, authTokenSecret: session.secret);
        return user;
        break;
      case TwitterLoginStatus.cancelledByUser:
        debugPrint(result.status.toString());
        return null;
        break;
      case TwitterLoginStatus.error:
        debugPrint(result.errorMessage.toString());
        return null;
        break;
    }
    return null;
  }

  void _logOut() async {
    await _auth.signOut().then((response) {
      isLogged = false;
      setState(() {});
    });
  }

  void _logIn() {
    _loginWithFacebook().then((response) {
      if (response != null) {
        myUser = response;
        isLogged = true;
        setState(() {});
      }
    });
  }

  void _logInTwitter() {
    _loginWithTwitter().then((response) {
      if (response != null) {
        myUser = response;
        isLogged = true;
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      appBar: AppBar(
//        title: Text(isLogged ? "Profile Page" : "Facebook Loing Example"),
//      ),
      body: Center(
        child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/bg.png"), fit: BoxFit.cover)),
          child: Padding(
            padding:
                const EdgeInsets.only(bottom: 100.0, left: 8.0, right: 8.0),
            child: isLogged
                ? _goToProfile(context)
                : Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      SizedBox(
                        height: 20.0,
                      ),
                      Text(
                        "Sign In Now!",
                        style: TextStyle(
                            fontSize: 40.0,
                            color: Colors.white,
                            fontFamily: 'Raleway'),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          FacebookSignInButton(
                            onPressed: _logIn,
                          ),
                          SizedBox(height: 20.0),
                          TwitterSignInButton(
                            onPressed: _logInTwitter,
                          ),
                        ],
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}

class ProfilePage extends StatelessWidget {
  FirebaseUser user;

  ProfilePage(this.user);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/bg.png"), fit: BoxFit.cover)),
      child: Padding(
        padding: const EdgeInsets.only(top: 182.0),
        child: Stack(
          children: <Widget>[
            Positioned(
              height: MediaQuery.of(context).size.height / 2.5,
              width: MediaQuery.of(context).size.width - 20,
              left: 10.0,
              top: MediaQuery.of(context).size.height * 0.1,
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0)),
                elevation: 10.0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(
                              right: 8.0, left: 8.0, bottom: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              FilterChip(
                                label: Text(
                                  user.displayName,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20.0,
                                      fontFamily: 'Raleway'),
                                ),
                                onSelected: (b) {},
                                backgroundColor: Colors.redAccent,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              FilterChip(
                                label: Text(
                                  user.email,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20.0,
                                      fontFamily: 'Raleway'),
                                ),
                                onSelected: (b) {},
                                backgroundColor: Colors.blue,
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                height: 150,
                width: 150,
                child: CircleAvatar(
                  radius: 60.0,
                  backgroundImage: NetworkImage(user.photoUrl),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
