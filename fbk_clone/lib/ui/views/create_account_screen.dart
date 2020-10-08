import 'base_view.dart';
import 'file:///G:/MyGithub/Flutter/fbk_clone/lib/ui/shared/palette.dart';
import 'package:fbk_clone/core/viewmodels/create_account_view_model.dart';
import 'package:fbk_clone/ui/widgets/custom_input.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CreateAccountScreen extends StatelessWidget {
  final TextEditingController emailTextEditingController =
      TextEditingController();
  final TextEditingController passwordTextEditingController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BaseView<CreateAccViewModel>(
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0.0,
            backgroundColor: Colors.transparent,
            centerTitle: true,
            title: Text("www.facebook.com",
                style: TextStyle(color: Palette.facebookBlue, fontSize: 18.0)),
          ),
          body: Stack(
            children: [
              Positioned.fill(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.5,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            CustomInput(
                              hintText: "Phone number or email address",
                              textInputAction: TextInputAction.next,
                              controller: emailTextEditingController,
                            ),
                            CustomInput(
                              hintText: "Password",
                              controller: passwordTextEditingController,
                              // focusNode: OtherUtils().passwordFocusNode,
                              isPasswordField: true,
                            ),
                            InkWell(
                              onTap: () {
                                model.createFbAccount(
                                    email: emailTextEditingController.text,
                                    password:
                                        passwordTextEditingController.text);
                              },
                              child: Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 12.0, vertical: 18.0),
                                decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(5.0)),
                                child: Center(
                                    child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "Create New Facebook Account",
                                    style: GoogleFonts.roboto(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16.0),
                                  ),
                                )),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: MediaQuery.of(context).size.height * 0.62,
                left: MediaQuery.of(context).size.width * 0.4,
                // duration: Duration(milliseconds: 500),
                // curve: Curves.easeInOut,
                child: Container(
                  alignment: Alignment.center,
                  child: Image.asset(
                    "assets/fblogo.png",
                    color: Palette.facebookBlue,
                    scale: 8.0,
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
