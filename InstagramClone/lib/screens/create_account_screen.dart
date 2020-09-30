import 'dart:async';

import 'package:flutter/material.dart';
import 'package:luffyvio/widgets/custom_appbar.dart';

class CreateAccScreen extends StatelessWidget {
  String username;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();
  final context;

  CreateAccScreen(this.context);

  submitUsername() {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();

      SnackBar snackBar = SnackBar(content: Text("Welcome, " + username));
      scaffoldKey.currentState.showSnackBar(snackBar);

      Timer(Duration(seconds: 3), () {
        Navigator.pop(context, username);
      });
    }
  }

  @override
  Widget build(BuildContext parentContext) {
    return Scaffold(
      key: scaffoldKey,
      appBar: CustomAppbar(context,"Settings", hasBackBtn: true),
      body: ListView(
        children: [
          Container(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Setup a username",
                    style: TextStyle(fontSize: 26.0),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(12.0),
                  child: Form(
                    key: formKey,
                    autovalidate: true,
                    child: TextFormField(
                      validator: (value) {
                        if (value.trim().length < 5 || value.isEmpty) {
                          return "Invalid Username";
                        }
                        return null;
                      },
                      onSaved: (value) => username = value,
                      decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.red),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.blueAccent),
                          ),
                          labelText: "Username",
                          hintText: "must be atleast 5 characters",
                          border: OutlineInputBorder()),
                    ),
                  ),
                ),
                RaisedButton.icon(
                    onPressed: submitUsername,
                    icon: Icon(Icons.graphic_eq_outlined),
                    label: Text("Submit"))
              ],
            ),
          )
        ],
      ),
    );
  }
}
