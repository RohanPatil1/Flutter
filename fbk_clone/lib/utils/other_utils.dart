import 'package:flutter/material.dart';

import 'firebaseutils.dart';

class OtherUtils{

   FocusNode passwordFocusNode = FocusNode();
  Future<void> showAlert(BuildContext context,String error) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: Text("Error"),
            content: Container(
              child: Text(error),
            ),
            actions: [
              FlatButton(
                child: Text("Close Dialog"),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            ],
          );
        });
  }

   void   submitCreateAccForm(BuildContext context,String email,String password) async {

     String accountStatus = await FirebaseUtils()
         .createFbAccount(email, password);

     if (accountStatus != null) {
       OtherUtils().showAlert(context, accountStatus);
     } else {
       Navigator.pop(context);
     }
   }
   void submitLoginForm(BuildContext context,String email,String password) async {

     String accountStatus = await FirebaseUtils()
         .logInUser(email, password);

     if (accountStatus != null) {
       OtherUtils().showAlert(context, accountStatus);
     } else {
       Navigator.pop(context);
     }
   }
}