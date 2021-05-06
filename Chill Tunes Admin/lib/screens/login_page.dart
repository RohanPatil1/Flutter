import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:niravanaz_admin/screens/upload_page.dart';
import 'package:niravanaz_admin/widgets/textField.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            child: Image.asset(
              "assets/images/bg.jpg",
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.6),
                    borderRadius: BorderRadius.circular(16.0)),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      child: Column(
                        children: [
                          Icon(
                            Icons.person,
                            color: Colors.white,
                            size: 60,
                          ),
                          Text(
                            'Admin Login',
                            style: TextStyle(
                                fontFamily: "BeViteLight",
                                fontSize: 18.0,
                                color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          /// Email

                          Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 2.0, vertical: 2.0),
                                  child: Text(
                                    "Email",
                                    style: TextStyle(
                                        color: Colors.white.withOpacity(0.89),
                                        fontSize: 17.0,
                                        fontFamily: 'BeViteReg'),
                                  ),
                                ),
                                CustomInputField(
                                  hintText: 'mike@mail.com',
                                  controller: _emailController,
                                  validator: (value) {
                                    if (value!.trim().length < 1)
                                      return 'Please enter email';
                                    if (!isValidEmail(value))
                                      return 'Please enter valid Email';
                                    return null;
                                  },
                                ),
                              ],
                            ),
                          ),

                          SizedBox(height: 20),

                          /// Password
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 2.0, vertical: 2.0),
                                child: Text(
                                  "Password",
                                  style: TextStyle(
                                      color: Colors.white.withOpacity(0.89),
                                      fontSize: 17.0,
                                      fontFamily: 'BeViteReg'),
                                ),
                              ),
                              PasswordField(
                                controller: _passwordController,
                                onSubmitted: () {},
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Back Button
                        SizedBox(width: 10),
                        // Next Button
                        ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.resolveWith<Color>(
                              (Set<MaterialState> states) {
                                if (states.contains(MaterialState.pressed))
                                  return Colors.pink;
                                return Colors
                                    .pink; // Use the component's default.
                              },
                            ),
                          ),
                          onPressed: () async {
                            print('Starting login');
                            if (_formKey.currentState!.validate()) {
                              try {
                                await FirebaseAuth.instance
                                    .signInWithEmailAndPassword(
                                        email: _emailController.text,
                                        password: _passwordController.text)
                                    .then((value) {
                                  Navigator.push(context, MaterialPageRoute(
                                    builder: (context) {
                                      return UploadPage();
                                    },
                                  ));
                                  return value;
                                });
                              } on FirebaseAuthException catch (e) {
                                if (e.code == 'weak-password') {
                                  print('The password provided is too weak.');
                                } else if (e.code == 'email-already-in-use') {
                                  print(
                                      'The account already exists for that email.');
                                }
                              } catch (e) {
                                print(e);
                              }
                            }
                            print('Finished login');
                          },
                          child: Text(
                            'Sign in',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: "BeViteReg",
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  bool isValidEmail(String email) {
    final String p =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    final RegExp regExp = RegExp(p);

    return regExp.hasMatch(email);
  }
}

class PasswordField extends StatefulWidget {
  final TextEditingController controller;

  final Function onSubmitted;

  PasswordField({required this.controller, required this.onSubmitted});

  @override
  _PasswordFieldState createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool isShowPass = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        TextFormField(
          controller: widget.controller,
          obscureText: !isShowPass,
          style: TextStyle(color: Colors.white),
          // onFieldSubmitted: widget.onSubmitted ?? (value) {},
          // textInputAction: (widget.isNext ?? false)
          //     ? TextInputAction.next
          //     : TextInputAction.done,
          decoration: InputDecoration(
              contentPadding:
                  EdgeInsets.symmetric(vertical: 12.0, horizontal: 10.0),
              hintStyle:
                  TextStyle(fontFamily: "BeViteReg", color: Colors.white),
              labelStyle:
                  TextStyle(fontFamily: "BeViteReg", color: Colors.white),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 1),
                borderRadius: BorderRadius.all(Radius.circular(6)),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 1),
                borderRadius: BorderRadius.all(Radius.circular(6)),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 1),
                borderRadius: BorderRadius.all(Radius.circular(6)),
              ),
              hintText: "******",
              suffixIcon: IconButton(
                icon: Icon(
                  isShowPass ? Icons.visibility_off : Icons.visibility,
                  color: Colors.white,
                ),
                onPressed: () {
                  setState(() {
                    isShowPass = !isShowPass;
                  });
                },
              )),

          validator: (value) {
            if (value!.trim().isEmpty) return 'Please enter password';

            // if (!validateStructure(value) && value
            //     .trim()
            //     .isNotEmpty) {
            //   return 'Invalid password';
            // }
            if (value.trim().isEmpty) {
              return 'Invalid password';
            }

            return null;
          },
        )
      ],
    );
  }

  bool validateStructure(String value) {
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regExp = new RegExp(pattern);
    return regExp.hasMatch(value);
  }
}
