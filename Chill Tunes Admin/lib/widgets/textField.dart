import 'package:flutter/material.dart';

class CustomInputField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final String? Function(String?)? validator;

  const CustomInputField(
      {Key? key,
      required this.hintText,
      required this.controller,
      required this.validator})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: () {},
      textCapitalization: TextCapitalization.sentences,

      style: TextStyle(fontFamily: "BeViteReg", color: Colors.white),

      controller: controller,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      // textCapitalization: isFirstLetterCaps ?? false
      //     ? TextCapitalization.sentences
      //     : TextCapitalization.none,
      autocorrect: false,
      // autovalidateMode: shouldAutoValidate ?? false
      //     ? AutovalidateMode.onUserInteraction
      //     : AutovalidateMode.disabled,
      decoration: InputDecoration(
        hintStyle: TextStyle(fontFamily: "BeViteReg", color: Colors.white),
        contentPadding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 10.0),
        //  labelText: labelText,
        hintText: hintText,
        labelStyle: TextStyle(fontFamily: "BeViteReg", color: Colors.white),
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
        errorStyle: TextStyle(
            fontFamily: "BeViteSB", fontSize: 12.0, color: Colors.red),
      ),
      validator: validator,
    );
  }
}
