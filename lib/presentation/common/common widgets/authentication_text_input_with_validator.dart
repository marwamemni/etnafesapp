import 'package:agence_voyage/presentation/resources/color_manager.dart';
import 'package:agence_voyage/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';

Widget textInputWithValidation(BuildContext context, String title, String hint,
    TextEditingController controller, Stream<bool>? stream, bool obscureText) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: AppPadding.p12),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(
          height: AppSize.s10,
        ),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                  controller: controller,
                  obscureText: obscureText,
                  decoration: InputDecoration.collapsed(hintText: hint)),
            ),
            SizedBox(
              height: AppSize.s20,
              width: AppSize.s20,
              child: StreamBuilder<bool>(
                  stream: stream,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Stack(
                        children: [
                          Center(
                            child: CircleAvatar(
                              maxRadius: 7,
                              backgroundColor: ColorManager.white,
                            ),
                          ),
                          Icon(
                            (snapshot.data!)
                                ? Icons.check_circle_sharp
                                : Icons.cancel_sharp,
                            size: AppSize.s20,
                            color: (snapshot.data!)
                                ? ColorManager.vert
                                : ColorManager.error,
                          ),
                        ],
                      );
                    } else {
                      return const SizedBox();
                    }
                  }),
            )
          ],
        )
      ],
    ),
  );
}
