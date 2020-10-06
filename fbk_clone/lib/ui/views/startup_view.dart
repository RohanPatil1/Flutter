import 'package:fbk_clone/core/viewmodels/startup_view_model.dart';
import 'package:flutter/material.dart';

import 'base_view.dart';

//Change to ViewModelProvider<StartUpViewModel>.withConsumer if does not work
class StartUpView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseView<StartUpViewModel>(
      onModelReady: (model) => model.handleStartUpLogin(),
      builder: (context, model, child) {
        return Scaffold(
          body: Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.redAccent,
            ),
          ),
        );
      },
    );
  }
}
