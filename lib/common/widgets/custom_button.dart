import 'package:flutter/material.dart';
import 'package:flutter_application/constants/global_variables.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const CustomButton({
    Key? key,
    required this.text,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ButtonStyle(
        backgroundColor:
            MaterialStateProperty.all<Color>(GlobalVariables.formGreenColor),
        // backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
        minimumSize: MaterialStateProperty.all(const Size(double.infinity, 50)),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0),
          ),
        ),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.black87,
          fontWeight: FontWeight.bold,
          fontSize: 16,
          // color: color == null ? Colors.white : Colors.black,
        ),
      ),
    );
  }
}
