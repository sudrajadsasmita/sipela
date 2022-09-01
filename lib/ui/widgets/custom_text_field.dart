import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:layang_layang_app/shared/theme.dart';

class CustomTextField extends StatefulWidget {
  final String? hint, title;
  final EdgeInsets? margin;
  final bool? obscure;
  final bool isEmail;
  final Icon? icon;
  final TextEditingController? controller;
  final Function(String?)? onChange;

  const CustomTextField({
    Key? key,
    this.hint = "",
    required this.title,
    this.margin = EdgeInsets.zero,
    this.obscure = false,
    this.isEmail = false,
    this.icon,
    required this.controller,
    this.onChange,
  }) : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    Function(String?)? change = widget.onChange;
    return Container(
      margin: widget.margin,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: widget.controller,
            cursorColor: kBlackColor,
            onChanged: change,
            obscureText: widget.obscure!,
            decoration: InputDecoration(
              icon: widget.icon,
              labelText: widget.title,
              hintText: widget.hint!,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(defaultRadius),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(defaultRadius),
                borderSide: BorderSide(color: kPrimaryColor),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
