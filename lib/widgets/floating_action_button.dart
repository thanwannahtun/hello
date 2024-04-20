import 'package:flutter/material.dart';
import 'package:hello/utils/theme.dart';

class CustomFloatingActionButton extends StatelessWidget {
  CustomFloatingActionButton(
      {super.key,
      required this.text,
      required this.onPressed,
      this.icon,
      this.hasIcon = false});
  final String text;
  final VoidCallback? onPressed;
  IconData? icon;
  bool? hasIcon;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
      fillColor: AppTheme.lightTheme.floatingActionButtonTheme.backgroundColor,
      splashColor: Colors.green,
      onPressed: onPressed,
      shape: const StadiumBorder(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          hasIcon == true ? iconButton(iconData: icon) : const Text(''),
          const SizedBox(
            width: 5.0,
          ),
          Text(text),
        ],
      ),
    );
  }

  Row iconButton({required IconData? iconData}) {
    return Row(
      children: [
        Icon(iconData),
        const SizedBox(
          width: 2.0,
        )
      ],
    );
  }
}
