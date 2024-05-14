import 'package:flutter/material.dart';
import 'package:hello/core/utils/entity.dart';
import 'package:hello/utils/constant_strings.dart';

class CustomBottomSheet<E extends Entity> {
  CustomBottomSheet({required this.models});
  final List<E> models;

  Future<E?> showBottomSheet(BuildContext context, {String? title}) async {
    return await showModalBottomSheet<E>(
      context: context,
      builder: (context) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: ConstantString.paddingS,
                  vertical: ConstantString.paddingM),
              child: Text(title ?? "Select"),
            ),
            ListView.separated(
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () {
                      Navigator.pop(context, models[index]);
                    },
                    title: Text(models[index].entityName ?? ''),
                  );
                },
                separatorBuilder: (context, index) => const Divider(
                      height: 2,
                    ),
                itemCount: models.length),
          ],
        );
      },
    );
  }
}
