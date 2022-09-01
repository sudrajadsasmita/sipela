import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../shared/theme.dart';

class CustomDateBirth extends StatefulWidget {
  final TextEditingController? dateInput;
  final GestureTapCallback? onTap;

  const CustomDateBirth({Key? key, required this.dateInput, this.onTap})
      : super(key: key);

  @override
  State<CustomDateBirth> createState() => _CustomDateBirthState();
}

class _CustomDateBirthState extends State<CustomDateBirth> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextFormField(
        controller: widget.dateInput,
        decoration: InputDecoration(
          icon: Icon(Icons.calendar_today),
          labelText: "Masukkan tanggal lahir",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(defaultRadius),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(defaultRadius),
            borderSide: BorderSide(color: kPrimaryColor),
          ),
        ),
        readOnly: true,
        onTap: widget.onTap,
      ),
    );
  }
}
