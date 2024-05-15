import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hello/config/route/route_lists.dart';
import 'package:hello/core/utils/entity.dart';
import 'package:hello/utils/constant_strings.dart';
import 'package:hello/widgets/custom_widgets.dart';

class CustomBottomSheet<E extends Entity> {
  CustomBottomSheet({required this.models});
  final List<E> models;

  Future<E?> showBottomSheet(BuildContext context, {String? title}) async {
    return await showModalBottomSheet<E>(
      isDismissible: true,
      context: context,
      builder: (context) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: ConstantString.paddingS,
                  vertical: ConstantString.paddingL),
              child: Text(title ?? "Select"),
            ),
            Container(
              height: 300,
              color: Colors.green.shade50,
              child: models.isEmpty
                  ? CustomWidgets.showNoDataWiget(
                      context: context,
                      onPressed: () {
                        Navigator.of(context)
                            .pushNamed(RouteLists.departmentCreatePage);
                      },
                    )
                  :
                  //  SingleChildScrollView(
                  //     child:
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
                      itemCount: models.length,
                      shrinkWrap: true),
              // ),
            ),
            Container(
              // height: 100,
              // color: Colors.red,
              child: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel')),
            )
          ],
        );
      },
    );
  }
}
