import 'package:flutter/material.dart';
import 'package:miniproject/style.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.label,
    required this.hint,
    required this.controller,
    this.obscureText,
    this.sufficIcon,
    this.readOnly,
    this.onChange,
  });

  final TextEditingController controller;
  final String label;
  final String hint;
  final bool? obscureText;
  final Widget? sufficIcon;
  final bool? readOnly;
  final ValueChanged? onChange;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Styles.labelTextField,
        ),
        SizedBox(
          height: 5,
        ),
        TextField(
            obscureText: obscureText ?? false,
            controller: controller,
            onChanged: onChange,
            readOnly: readOnly ?? false,
            decoration: InputDecoration(
                suffixIcon: sufficIcon,
                hintText: hint,
                border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                filled: true,
                fillColor: Color.fromARGB(15, 103, 99, 99)),
            style: TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.w400,
                height: 0))
      ],
    );
  }
}
