import 'package:flutter/material.dart';
import 'package:flutter_application/constants/global_variables.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool suffix;
  // final bool? valid;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.suffix = false,
    // this.valid = false,
  });

  // @override
  // State<CustomTextField> createState() => _CustomTextFieldState();
// }

// class _CustomTextFieldState extends State<CustomTextField> {
  // @override
  // void dispose() {
  //   super.dispose();
  // }

  // checkIfValid() {
  //   if (widget.controller.text.isEmpty) {
  //     return false;
  //   }
  //   return true;
  // }

  checkForObscuredText() {
    if (suffix == false) {
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    // bool isObscure = true;

    return TextFormField(
      // obscureText: checkForObscuredText() && isObscure,
      obscureText: checkForObscuredText(),
      controller: controller,
      // controller: widget.controller,
      decoration: InputDecoration(
        hintText: hintText,
        // hintText: widget.hintText,
        labelText: hintText,
        // labelText: widget.hintText,
        floatingLabelStyle: const TextStyle(
            fontWeight: FontWeight.bold, fontSize: 18, color: Colors.black),
        // MaterialStateTextStyle.resolveWith(
        // (Set<MaterialState> state) {
        //   final Color color = Colors.black;
        // },
        // ),
        suffixIcon: suffix == true
            // suffixIcon: widget.suffix == true
            ? IconButton(
                icon: const Icon(Icons.visibility),
                // icon: isObscure
                //     ? Icon(Icons.visibility)
                //     : Icon(Icons.visibility_off),
                onPressed: () {
                  // setState(() {
                  // isObscure = !isObscure;
                  // });
                },
              )
            : null,
        // focusedBorder: const UnderlineInputBorder(
        //   borderSide: BorderSide(
        //     width: 4,
        //     color: GlobalVariables.formGreenColor,
        //     // color: widget.valid!
        //     //     ? GlobalVariables.formGreenColor
        //     //     : GlobalVariables.errorColor,
        //   ),
        // ),
        border: const UnderlineInputBorder(
          borderSide: BorderSide(
            width: 4,
            color: GlobalVariables.formGreenColor,
            // color: widget.valid!
            //     ? GlobalVariables.formGreenColor
            //     : GlobalVariables.errorColor,
          ),
        ),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            // width: 5,
            color: GlobalVariables.formGreyColor,
          ),
        ),
        // errorBorder: const UnderlineInputBorder(
        //   borderSide: BorderSide(
        //     width: 5,
        //     color: Colors.red,
        //   ),
        // ),
      ),
      validator: (val) {
        if (val == null || val.isEmpty) {
          return 'Enter your $hintText';
        }
        return null;
      },
    );
  }
}
