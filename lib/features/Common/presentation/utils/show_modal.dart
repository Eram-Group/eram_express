import 'package:flutter/material.dart';

import '../views/modal_view.dart';

Future<T> showModalView<T>(
    {required BuildContext context,
    required Widget Function(BuildContext) builder,
    bool isScrollControlled = false,
    bool isDismissible = true}) async 
    {
  return await showModalBottomSheet(
    context: context,
    isDismissible: isDismissible,
    isScrollControlled: isScrollControlled,
    builder: (context) => ModalView(
      
      child: builder(context),
    ),
  );
}
