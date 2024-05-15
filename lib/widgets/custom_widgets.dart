import 'package:flutter/material.dart';
import 'package:hello/utils/constant_strings.dart';

class CustomWidgets {
  static showSnackBar({required BuildContext context, required String title}) {
    SnackBar snackBar = SnackBar(content: Text(title));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static Widget showNoDataWiget(
      {required BuildContext context, required VoidCallback onPressed}) {
    return Center(
      child: InkWell(
        onTap: () => onPressed,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: const Icon(
                Icons.note_add,
                size: 100,
              ),
              onPressed: onPressed,
            ),
            // (Icons.note_add, size: 100),
            const SizedBox(height: 20),
            const Text('No Data Found!')
          ],
        ),
      ),
    );
  }

  static Widget showNoItemWidget(
      {required BuildContext context, String? message}) {
    return Center(
      child: SizedBox(
        // width: MediaQuery.of(context).size.width / 0.8,
        child: Text(message ?? 'No Items'),
      ),
    );
  }

  static TextFormField textFormField(
      {String? errorMessage,
      // required dynamic value,
      bool isNeglect = false,
      String? initialValue,
      required void Function(String?)? onSave,
      String? hintText,
      TextInputType? textInputType}) {
    return TextFormField(
      decoration: InputDecoration(
          border: const OutlineInputBorder(),
          errorStyle:
              TextStyle(color: Colors.red[800], fontStyle: FontStyle.italic),
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.green, fontSize: 20)),
      keyboardType: textInputType,
      initialValue: initialValue,
      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      validator: (newValue) {
        if (isNeglect == true) {
          return null;
        }
        if (newValue != null && newValue.isNotEmpty) {
          return null;
        } else {
          return errorMessage ?? 'Require this field!';
        }
      },
      onSaved: onSave,
    );
  }

  static Widget persistentFooterButton(
      {required String title,
      required void Function() onPressed,
      EdgeInsetsGeometry? padding}) {
    return Padding(
      padding: padding ?? const EdgeInsets.all(ConstantString.paddingM),
      child: persistentFooterButton(
          title: title,
          onPressed: onPressed,
          padding: padding ?? const EdgeInsets.all(ConstantString.paddingL)),
    );
  }

  static Widget showDialogBox(
      {required BuildContext context,
      required String content,
      required void Function()? onPressed,
      required String confirmText}) {
    // showDialog(context: context, builder: builder)
    return AlertDialog(
      title: const Text('are you sure?'),
      content: Text(content),
      actions: [
        ElevatedButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel')),
        ElevatedButton(onPressed: onPressed, child: Text(confirmText))
      ],
    );
  }
}
