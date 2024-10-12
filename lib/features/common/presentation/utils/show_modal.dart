import 'package:flutter/material.dart';

Future<T?> showModal<T>(BuildContext context, WidgetBuilder builder) async {
  return await showModalBottomSheet<T>(
    context: context,
    builder: builder,
    elevation: 0,
    backgroundColor: Colors.transparent,
  );
}
