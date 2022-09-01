import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:layang_layang_app/shared/theme.dart';

class CustomDropDown extends StatefulWidget {
  final String? title;
  final EdgeInsets? margin;
  final List<String>? list;
  final String? defautlSelected;
  final Function(String?)? onChange;
  final Icon? icon;
  const CustomDropDown(
      {Key? key,
      this.margin,
      required this.title,
      required this.list,
      this.defautlSelected,
      required this.onChange,
      required this.icon})
      : super(key: key);

  @override
  State<CustomDropDown> createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDown> {
  @override
  Widget build(BuildContext context) {
    List<String> list = widget.list!;
    String? selectedItem = widget.defautlSelected;
    Function(String?)? change = widget.onChange;
    return Container(
      margin: widget.margin,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DropdownButtonFormField<String>(
            decoration: InputDecoration(
              icon: widget.icon,
              labelText: widget.title,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(defaultRadius),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(defaultRadius),
                borderSide: BorderSide(color: kPrimaryColor),
              ),
            ),
            items: list
                .map(
                  (e) => DropdownMenuItem(
                    value: e,
                    child: Text(
                      e,
                    ),
                  ),
                )
                .toList(),
            value: selectedItem,
            onChanged: change,
          ),
        ],
      ),
    );
  }
}
