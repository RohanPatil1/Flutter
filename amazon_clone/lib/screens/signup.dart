import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:amazoine_clone/db/user.dart';
import 'package:amazoine_clone/screens/home.dart';
import 'package:provider/provider.dart';

import '../new.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  final key = GlobalKey<ScaffoldState>();

  UserServices _userServices = UserServices();
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _nameTextController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  String gender;
  String groupValue = "male";
  bool hidePass = true;
  bool loading = false;

//  Auth auth = Auth();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Center(
          child: Image.asset(
            'images/amazon_logo.png',
            fit: BoxFit.cover,
            width: 150.0,
            alignment: Alignment.center,
          ),
        ),
      ),
      key: key,
      body: user.status == Status.Authenticating
          ? Loading()
          : Stack(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20, right: 20.0, top: 100, bottom: 150),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey[350],
                          blurRadius:
                              20.0, // has the effect of softening the shadow
                        )
                      ],
                    ),
                    child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(left: 28.0),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  " Create Account",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 26.0),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  14.0, 8.0, 14.0, 8.0),
                              child: Material(
                                borderRadius: BorderRadius.circular(10.0),
                                color: Colors.grey.withOpacity(0.2),
                                elevation: 0.0,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 12.0),
                                  child: ListTile(
                                    title: TextFormField(
                                      controller: _nameTextController,
                                      decoration: InputDecoration(
                                          hintText: "Full name",
                                          icon: Icon(Icons.person_outline),
                                          border: InputBorder.none),
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return "The name field cannot be empty";
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  14.0, 8.0, 14.0, 8.0),
                              child: Material(
                                borderRadius: BorderRadius.circular(10.0),
                                color: Colors.grey.withOpacity(0.2),
                                elevation: 0.0,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 12.0),
                                  child: ListTile(
                                    title: TextFormField(
                                      controller: _emailTextController,
                                      decoration: InputDecoration(
                                          hintText: "Email",
                                          icon: Icon(Icons.alternate_email),
                                          border: InputBorder.none),
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          Pattern pattern =
                                              r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                                          RegExp regex = new RegExp(pattern);
                                          if (!regex.hasMatch(value))
                                            return 'Please make sure your email address is valid';
                                          else
                                            return null;
                                        }
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  14.0, 8.0, 14.0, 8.0),
                              child: Material(
                                borderRadius: BorderRadius.circular(10.0),
                                color: Colors.grey.withOpacity(0.2),
                                elevation: 0.0,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 12.0),
                                  child: ListTile(
                                    title: TextFormField(
                                      controller: _passwordTextController,
                                      obscureText: hidePass,
                                      decoration: InputDecoration(
                                          hintText: "Password",
                                          icon: Icon(Icons.lock_outline),
                                          border: InputBorder.none),
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return "The password field cannot be empty";
                                        } else if (value.length < 6) {
                                          return "the password has to be at least 6 characters long";
                                        }
                                        return null;
                                      },
                                    ),
                                    trailing: IconButton(
                                        icon: Icon(Icons.remove_red_eye),
                                        onPressed: () {
                                          setState(() {
                                            hidePass = false;
                                          });
                                        }),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  top: 1.0,
                                  right: 8.0,
                                  left: 18.0,
                                  bottom: 26.0),
                              child: Row(
                                children: <Widget>[
                                  Icon(Icons.info_outline, color: Colors.blue),
                                  Text(
                                      "  Passwords must be at least 6 characters."),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  14.0, 8.0, 14.0, 8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4.0),
                                  boxShadow: [BoxShadow(color: Colors.black)],
                                ),
                                child: Material(
                                    color: Color(0xffF0C047),
                                    elevation: 0.0,
                                    child: MaterialButton(
                                      onPressed: () async {
                                        if (_formKey.currentState.validate()) {
                                          if (!await user.siginUP(
                                              _nameTextController.text,
                                              _emailTextController.text,
                                              _passwordTextController.text,
                                              context)) {
                                            key.currentState.showSnackBar(
                                                SnackBar(
                                                    content:
                                                        Text("SignUp Failed")));
                                          }
                                        }
                                      },
                                      minWidth:
                                          MediaQuery.of(context).size.width,
                                      child: Text(
                                        "Continue",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 20.0),
                                      ),
                                    )),
                              ),
                            ),
                            Divider(
                              indent: 90.0,
                              color: Colors.black54,
                              endIndent: 90.0,
                            ),
                            Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: InkWell(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: RichText(
                                        text: TextSpan(
                                            style: new TextStyle(
                                              fontSize: 14.0,
                                              color: Colors.black,
                                            ),
                                            children: <TextSpan>[
                                          TextSpan(
                                              text:
                                                  "Already have an account? "),
                                          TextSpan(
                                              text: "Sign in",
                                              style: new TextStyle(
                                                  color: Colors.blue))
                                        ])))),
                          ],
                        )),
                  ),
                ),
                Visibility(
                  visible: loading ?? true,
                  child: Center(
                    child: Container(
                      alignment: Alignment.center,
                      color: Colors.white.withOpacity(0.9),
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                      ),
                    ),
                  ),
                )
              ],
            ),
    );
  }

  valueChanged(e) {
    setState(() {
      if (e == "male") {
        groupValue = e;
        gender = e;
      } else if (e == "female") {
        groupValue = e;
        gender = e;
      }
    });
  }

  Future validateForm() async {
    FormState formState = _formKey.currentState;

    if (formState.validate()) {
      FirebaseUser user = await firebaseAuth.currentUser();
      if (user == null) {
        firebaseAuth
            .createUserWithEmailAndPassword(
                email: _emailTextController.text,
                password: _passwordTextController.text)
            .then((user) => {
                  _userServices.createUser({
                    "username": _nameTextController.text,
                    "email": _emailTextController.text,
                    "userId": user.uid,
                  })
                })
            .catchError((err) => {print('error is: ' + err.toString())});

        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Home()));
      }
    }
  }
}

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator();
  }
}
