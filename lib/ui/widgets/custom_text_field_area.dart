import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:layang_layang_app/shared/theme.dart';

class CustomTextFieldArea extends StatefulWidget {
  final String? hint, title;
  final EdgeInsets? margin;
  final Icon? icon;
  final TextEditingController? controller;
  final Function(String?)? onChange;

  const CustomTextFieldArea({
    Key? key,
    this.hint = "",
    required this.title,
    this.margin = EdgeInsets.zero,
    this.icon,
    required this.controller,
    this.onChange,
  }) : super(key: key);

  @override
  State<CustomTextFieldArea> createState() => _CustomTextFieldAreaState();
}

class _CustomTextFieldAreaState extends State<CustomTextFieldArea> {
  @override
  Widget build(BuildContext context) {
    Function(String?)? change = widget.onChange;

    return Container(
      margin: widget.margin,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            cursorColor: kBlackColor,
            minLines: 6,
            maxLines: null,
            controller: widget.controller,
            onChanged: change,
            keyboardType: TextInputType.multiline,
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
