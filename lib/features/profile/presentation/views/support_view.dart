import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:eram_express/app/di.dart';
import 'package:eram_express/features/profile/data/models/support_type_model.dart';
import 'package:eram_express/features/profile/presentation/support_presentation/support_view_model.dart';
import 'package:eram_express/features/profile/presentation/widgets/customappbar.widgets.dart';
import 'package:eram_express_shared/core/app_colors.dart';
import 'package:eram_express_shared/core/i18n/context_extension.dart';
import 'package:eram_express_shared/core/utils/logger.dart';
import 'package:eram_express_shared/core/utils/responsive.dart';
import 'package:eram_express_shared/presentation/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../modals/failed_request_modal.dart';
import '../modals/success_request_modal.dart';
import '../support_presentation/support_view_state.dart';

class SupportView extends StatelessWidget {
  const SupportView({super.key});
  static const String route = "/support";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: context.tt("Support", "الدعم")),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 24).copyWith(bottom: 0),
        child: BlocProvider(
          create: (context) =>
              SupportViewModel(profileRepository: profileRepository)..getSupportTypes(),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  context.tt(
                      "Don’t hesitate to contact us whether you have a suggestion on our improvement, a complain to discuss or an issue to solve.",
                      "لا تتردد في التواصل معنا سواء كان لديك اقتراح لتحسين خدماتنا، شكوى ترغب في مناقشتها، أو مشكلة تحتاج إلى حل"),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize:
                        Responsive.getResponsiveFontSize(context, fontSize: 16),
                    fontFamily: 'outfit',
                    fontWeight: FontWeight.w500,
                    height: 24.6 /Responsive.getResponsiveFontSize(context, fontSize: 16),
                    letterSpacing: -0.32,
                    color:const Color(0xffA7A9B7),
                  ),
                ),
                _title(context.tt("Select reason", "اختار السبب"), context),
               _buildDropdown(context),
                _title(context.tt("Detail message", "تفاصيل الرسالة"), context),
                _description(),
                _buildSubmitButton(context)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

_title(String title, BuildContext context) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 20).copyWith(bottom: 10),
    child: Text(
      title,
      style: TextStyle(
        fontSize: Responsive.getResponsiveFontSize(context, fontSize: 16),
        fontFamily: 'outfit',
        fontWeight: FontWeight.w500,
        height: 15.6 / Responsive.getResponsiveFontSize(context, fontSize: 16),
        letterSpacing: -0.32,
        color: AppColor.blacktext,
      ),
    ),
  );
}

Widget _description() {
  return BlocBuilder<SupportViewModel, SupportViewState>(
    buildWhen: (previous, current) =>
        current is SupportFormLoad &&
        (previous is! SupportFormLoad ||
            previous.detailReason != current.detailReason),
    builder: (context, state) {
      return TextFormField(
        maxLines: 3,
        decoration: InputDecoration(
          hintText: context.tt('YOUR MESSAGE ', ' رسالتك '),
          hintStyle: TextStyle(
            color: const Color(0xffA7A9B7),
            fontSize: Responsive.getResponsiveFontSize(context, fontSize: 15),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: AppColor.bordercolor, // Default border color
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: AppColor.bordercolor, // Color when field is focused
              width: 2.0, // Width for focused border
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: AppColor.bordercolor, // Color when field is focused
              width: 2.0, // Width for focused border
            ),
          ),
        ),
        onChanged: (value) {
          logger.debug(value);
          context.read<SupportViewModel>().onDescreptionClicked(value);
        },
      );
    },
  );
}

Widget _buildSubmitButton(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 40),
    child: BlocConsumer<SupportViewModel, SupportViewState>(
      listener: (context, state) {
        if (state is SupportFormSucecessState) {
          SuccessfulRequestModal().show(context);
        } else if (state is SupportFormErrorState) {
          FailedOrderModal().show(context);
        }
      },
      builder: (context, state) {
        return CustomButton(
          enabled: context.read<SupportViewModel>().enabledbutton(),
          onTap: () {
            context.read<SupportViewModel>().onSubmitClicked(context);
          },
          child: Text(
            context.tt('Save', 'حفظ'),
            style: const TextStyle(
              color: Colors.white,
              fontFamily: 'Outfit',
              fontSize: 16,
              fontWeight: FontWeight.w600,
              height: 1.5,
            ),
          ),
        );
      },
    ),
  );
}

Widget _buildDropdown(BuildContext context) {
  return BlocBuilder<SupportViewModel, SupportViewState>(
      buildWhen: (previous, current) =>
          current is SupportFormLoad &&
          (previous is! SupportFormLoad ||
              previous.supportTypes != current.supportTypes ||
              previous.selectedReason != current.selectedReason),
      builder: (context, state) {
        if (state is SupportViewErrorState) {
          return Center(
            child: Text(
              state.errorMessage,
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'outfit',
                fontWeight: FontWeight.w400,
                color: AppColor.blacktext,
              ),
            ),
          );
        } else if (state is SupportFormLoad) {
          return _dropdown(context, state.supportTypes, state.selectedReason);
        }
        return Center(
          child: CircularProgressIndicator(
            color: AppColor.bordercolor,
            strokeWidth: 3,
          ),
        );
      });
}

Widget _dropdown(
  BuildContext context,
  List<SupportTypeModel> reasonList,
  SupportTypeModel? selectReason,
) {
  logger.debug("rebuild");
  return DropdownButtonHideUnderline(
    child: DropdownButton2<SupportTypeModel>(
      isExpanded: true,
      hint: Text(
        selectReason == null
            ? context.tt("Select", "اختار")
            : selectReason.label,
        style: TextStyle(
          fontSize: Responsive.getResponsiveFontSize(context, fontSize: 16),
          fontFamily: 'outfit',
          fontWeight: FontWeight.w400,
          height:
              15.6 / Responsive.getResponsiveFontSize(context, fontSize: 16),
          letterSpacing: -0.32,
          color: AppColor.blacktext,
        ),
      ),
      onChanged: (value) {
        context.read<SupportViewModel>().onSelectReasonClicked(value);
      },
      items: reasonList
          .map((item) => DropdownMenuItem<SupportTypeModel>(
                value: item,
                child: Text(
                  item.label,
                  style: TextStyle(
                    fontSize:
                        Responsive.getResponsiveFontSize(context, fontSize: 16),
                    fontFamily: 'outfit',
                    fontWeight: FontWeight.w400,
                    height: 15.6 /
                        Responsive.getResponsiveFontSize(context, fontSize: 16),
                    letterSpacing: -0.32,
                    color: AppColor.blacktext,
                  ),
                ),
              ))
          .toList(),
      buttonStyleData: ButtonStyleData(
        height: Responsive.screenHeight! * .06,
        padding: const EdgeInsets.only(left: 14, right: 14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: Colors.white,
        ),
        elevation: 2,
      ),
      iconStyleData: const IconStyleData(
        icon: Icon(
          Icons.arrow_forward_ios_outlined,
        ),
        iconSize: 14,
        iconEnabledColor: Colors.black,
      ),
      dropdownStyleData: DropdownStyleData(
        maxHeight: Responsive.screenHeight! * 0.25,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: Colors.white,
        ),
        offset: const Offset(0, -5),
        scrollbarTheme: ScrollbarThemeData(
          radius: const Radius.circular(20),
          thickness: MaterialStateProperty.all(6),
          thumbVisibility: MaterialStateProperty.all(true),
        ),
      ),
      menuItemStyleData: const MenuItemStyleData(
        height: 40,
        padding: EdgeInsets.only(left: 14, right: 14),
      ),
    ),
  );
}
