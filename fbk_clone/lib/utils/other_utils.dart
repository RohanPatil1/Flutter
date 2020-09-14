import 'package:flutter/material.dart';

import 'firebaseutils.dart';

class OtherUtils{
   String registerEmail = "cam123raj@gmail.com";
    String registerPassword = "rohan123";
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

   void submitForm(BuildContext context) async {

     String accountStatus = await FirebaseUtils()
         .createFbAccount(OtherUtils().registerEmail, OtherUtils().registerPassword);

     if (accountStatus != null) {
       OtherUtils().showAlert(context, accountStatus);
     } else {
       Navigator.pop(context);
     }
   }
}