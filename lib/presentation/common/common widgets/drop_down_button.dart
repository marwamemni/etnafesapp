import 'package:agence_voyage/presentation/resources/color_manager.dart';
import 'package:agence_voyage/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';

Widget getDropDownButton<Obj>(String title, Stream<List<Obj>>? stream,
    void Function(Obj?)? onChanged, Obj? value, BuildContext context,
    [String hint = '']) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: AppPadding.p12),
    child: Row(
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(
          width: AppSize.s25,
        ),
        Expanded(
          child: Flex(direction: Axis.vertical, children: [
            Container(
              height: AppSize.s27,
              decoration: BoxDecoration(
                  color: ColorManager.white,
                  borderRadius: BorderRadius.circular(AppSize.s10)),
              child: Padding(
                padding: const EdgeInsets.only(left: AppPadding.p20),
                child: StreamBuilder<List<Obj>>(
                    stream: stream,
                    builder: (context, snapshot) {
                      return DropdownButton<Obj>(
                        iconEnabledColor: ColorManager.grey,
                        style: Theme.of(context).textTheme.titleSmall,
                        underline: const SizedBox(),
                        iconSize: AppSize.s30,
                        disabledHint: Container(
                          color: ColorManager.white,
                          child: Text(
                            hint,
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                        ),
                        isExpanded: true,

                        hint: Container(
                          color: ColorManager.white,
                          child: Text(
                            hint,
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                        ),
                        value:
                            value, // this place should not have a controller but a variable
                        onChanged: onChanged,
                        items: snapshot.hasData
                            ? snapshot.data!
                                .map<DropdownMenuItem<Obj>>((Obj val) =>
                                    DropdownMenuItem<Obj>(
                                        value:
                                            val, // add this property an pass the _value to it
                                        child: Text(
                                          val.toString(),
                                        )))
                                .toList()
                            : null,
                      );
                    }),
              ),
            ),
          ]),
        ),
      ],
    ),
  );
}
