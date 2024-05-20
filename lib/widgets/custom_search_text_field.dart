import 'package:flutter/material.dart';

class CustomSearchTextField extends StatelessWidget {
  CustomSearchTextField(
      {super.key, this.hintText, required this.onPressed, this.icon});

  String? hintText;
  final Function() onPressed;
  Widget? icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        TextField(
          decoration: InputDecoration(
            hintText: hintText ?? '',
            border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
          ),
        ),
        IconButton(onPressed: onPressed, icon: icon ?? const Text('')),
      ],
    );
  }
}
