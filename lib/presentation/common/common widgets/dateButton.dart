// ignore_for_file: file_names

import 'package:agence_voyage/presentation/resources/color_manager.dart';
import 'package:agence_voyage/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';

Expanded getDateButton(
    BuildContext context, String title, void Function(DateTime) onDateChanged,
    {DateTime? initialDate}) {
  return Expanded(
    child: GestureDetector(
      onTap: (() {
        showDialog(
            context: context,
            builder: (context) {
              return DatePickerDialog(
                initialDate: initialDate ?? DateTime.now(),
                firstDate: DateTime(2001),
                lastDate: DateTime(2025),
              );
            }).then((date) {
          onDateChanged(date);
          initialDate = date;
        });
      }),
      child: Container(
        height: AppSize.s40,
        decoration: BoxDecoration(
            color: ColorManager.white,
            borderRadius: BorderRadius.circular(AppSize.s25),
            border: Border.all(color: ColorManager.grey, width: AppSize.s0_5)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const Icon(
              Icons.date_range,
              size: 17,
            )
          ],
        ),
      ),
    ),
  );
}
