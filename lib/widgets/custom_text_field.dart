import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  CustomTextField(
      {super.key,
      required this.controller,
      this.hintText,
      this.onChanged,
      this.onTap,
      this.validator,
      this.initialValue,
      this.onSaved,
      this.prefix,
      this.prefixIcon,
      this.suffix,
      this.labelText,
      this.obscureText,
      this.suffixIcon});
  TextEditingController controller;
  String? hintText;
  void Function(String)? onChanged;
  void Function()? onTap;
  String? Function(String?)? validator;
  String? initialValue;
  void Function(String?)? onSaved;
  Widget? prefix;
  Widget? prefixIcon;
  Widget? suffix;
  Widget? suffixIcon;
  bool? obscureText;
  String? labelText;
  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: (widget.obscureText) ?? false,
      controller: widget.controller,
      decoration: InputDecoration(
        labelText: widget.labelText,
        prefix: widget.prefix,
        prefixIcon: widget.prefixIcon,
        border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(5))),
        hintText: widget.hintText,
        suffixIcon: widget.suffixIcon,
        suffix: widget.suffix,
      ),
      onChanged: widget.onChanged,
      initialValue: widget.initialValue,
      onTap: widget.onTap,
      validator: widget.validator,
      onSaved: widget.onSaved,
    );
  }
}
