import 'package:eram_express/features/google_map/presentation/views/google_map_view_controller.dart';
import 'package:eram_express_shared/core/i18n/context_extension.dart';
import 'package:eram_express_shared/core/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchButton extends StatelessWidget {
  const SearchButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<GoogleMapViewController>().searchButtonClick();
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
        ),
        child: Container(
          width: Responsive.screenWidth,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(25),
            border: Border.all(color: Colors.transparent),
          ),
          child: Text(
            context.tt("Search here", "البحث هنا "),
            style: TextStyle(
              color: Colors.grey,
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }
}
