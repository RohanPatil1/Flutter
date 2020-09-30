import 'package:flutter/material.dart';

circularProgress() {
  return Container(
    alignment: Alignment.center,
    padding: EdgeInsets.all(14.0),
    child: CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation(Colors.green),
    ),
  );
}

linearProgress() {
  return Container(
    alignment: Alignment.center,
    padding: EdgeInsets.all(14.0),
    child: LinearProgressIndicator(
      valueColor: AlwaysStoppedAnimation(Colors.green),
    ),
  );
}
