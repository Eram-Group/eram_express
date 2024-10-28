import 'package:eram_express/app/app.dart';
import 'package:eram_express/app/di.dart';
import 'package:eram_express/features/customer/domain/entities/customer_entity.dart';
import 'package:eram_express_shared/core/i18n/context_extension.dart';
import 'package:eram_express_shared/core/utils/logger.dart';
import 'package:eram_express_shared/presentation/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../../app/navigation.dart';
import '../../../Common/widgets/custom_text_field.dart';
import 'edit_profile_view_model.dart';
import 'edit_profile_view_state.dart';
import 'profile_presentation/profile_view_model.dart';

class EditProfileViewArguments {
  final CustomerEntity currentCustomer;

  const EditProfileViewArguments({
    required this.currentCustomer,
  });
}

class EditProfileView extends StatelessWidget {
  static const String route = "/Editprofile";
  final EditProfileViewArguments arguments;
  final EditProfileViewModel viewmodel =
      EditProfileViewModel(customerService: customerService);
  EditProfileView(this.arguments, {super.key}) {
    viewmodel.setInitialValues(arguments);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Edit Profile",
          style: TextStyle(
            fontSize: 20,
          ),
        ),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16)
            .copyWith(bottom: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTitleField(
              context.tt('full name', 'الاسم بالكامل'),
            ),
            BlocBuilder<EditProfileViewModel, EditProfileViewState>(
                bloc: viewmodel,
                builder: (context, state) {
                  return CustomTextField(
                    hintText:
                        context.tt('Enter your full name', 'ادخل اسمك الكامل'),
                    onChanged: (string) {
                      viewmodel.onFullNameChanged(string);
                    },
                    initialValue: state.fullName,
                  );
                }),
            _buildTitleField(context.tt('Phone Number', 'رقم التليفون')),
            BlocBuilder<EditProfileViewModel, EditProfileViewState>(
                bloc: viewmodel,
                builder: (context, state) {
                  return CustomTextField(
                    onChanged: (string) {},
                    initialValue: state.phoneNumber!,
                    isEnabled: false,
                  );
                }),
            const Spacer(),
            BlocBuilder<EditProfileViewModel, EditProfileViewState>(
                bloc: viewmodel,
                builder: (context, state) {
                  return CustomButton(
                    loading: state.saving,
                    onTap: () {
                      logger.debug(viewmodel.state.fullName!);

                      viewmodel.saveButtonOnClicked(context);
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
                })
          ],
        ),
      ),
    );
  }
}

/*
Widget _buildFullNameField(BuildContext context, String title) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title,
        style: const TextStyle(
          color: Color(0xFF191D31),
          fontFamily: 'Outfit',
          fontSize: 12,
          fontWeight: FontWeight.w500,
          height: 1.3,
        ),
      ),
      Gap(3),
      /*
      BlocBuilder<CompleteProfileViewModel, CompleteProfileViewState>(
        bloc: viewModel,
        builder:
         (context, state) {
         */
      CustomTextField(
        hintText: NavigationService.globalContext
            .tt('Enter your full name', 'ادخل اسمك الكامل'),
        onChanged: (string) {},
      ),
    ],
  );
}
*/
Widget _buildTitleField(String title) {
  return Text(
    title,
    style: const TextStyle(
      color: Color(0xFF191D31),
      fontFamily: 'Outfit',
      fontSize: 12,
      fontWeight: FontWeight.w500,
      height: 1.3,
    ),
  );
}

/*
class ImageView extends StatelessWidget {
  final String? imageFile;
  const ImageView({this.imageFile});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => ImagePickerCubit(),
        child: BlocBuilder<ImagePickerCubit, ImagePickerState>(
            builder: (context, state) {
          if (state is ImagePickerLoaded) {
            return Stack(children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: FileImage(File(state.imagePath)),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: _buildIconCamera(context),
              )
            ]);
          } else if (state is ImagePickerError) {
            return Text(state.errormessege,
                style: TextStyle(color: Colors.red));
          } else {
            return Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.red,
                      width: 1.5,
                    ),
                    color: Colors.red,
                  ),
                  width: 100,
                  height: 100,
                  child: Icon(
                    Icons.person,
                    size: 100 / 2,
                    color: Colors.black,
                  ),
                ),
                Positioned(
                  bottom: -10,
                  right: -10,
                  child: _buildIconCamera(context),
                )
              ],
            );
          }
        }));
  }
}

Widget _buildField({
  required BuildContext context,
  required String label,
  String? hintText,
  required String initialValue,
  void Function(String)? onChanged,
}) {
  return Padding(
    padding: customPadding(context, vertical: 10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.titleSmall,
        ),
        const SizedBox(height: 8),
        Container(
          decoration: ShapeDecoration(shape: roundedRectangleBorder()),
          child: TextFormField(
            decoration: InputDecoration(
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                borderSide: BorderSide.none,
              ),
              hintStyle: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(color: Colors.black, fontSize: 15),
              hintText: hintText,
              //suffix:
            ),
            initialValue: initialValue,
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  fontWeight: FontWeight.w400,
                ),
            onChanged: onChanged,
          ),
        ),
      ],
    ),
  );
}
/*
Widget _buildIconCamera(BuildContext context) {
  return GestureDetector(
    onTap: () {
      print("helllllllllllllllllllllllllllllllllllll");
      //context.read<ImagePickerCubit>().pickImageFromCamera();
      CustomBottomSheet.show(context);
    },
    child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white, width: 1.5),
          color: AppColor.primaryColor,
        ),
        child: Padding(
          padding: customPadding(context, all: 8),
          child: Center(child: Image.asset("assets/camera.png")),
        )),
  );
}

class CustomBottomSheet extends StatelessWidget {
  CustomBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: EdgeInsets.only(top: 10),
        child: Column(
          children: [
            Text(
              "Choose Profile Photo",
              style: TextStyle(fontSize: 17),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: ListTile(
                    title: Text("Camera"),
                    leading: Icon(Icons.camera),
                    onTap: () {
                      Navigator.of(context).pop(); // Close the bottom sheet
                      context.read<ImagePickerCubit>().pickImageFromCamera();
                    },
                  ),
                ),
                Expanded(
                  child: ListTile(
                    title: Text("Gallery"),
                    leading: Icon(Icons.photo_library),
                    onTap: () {
                      Navigator.of(context).pop(); // Close the bottom sheet
                      context.read<ImagePickerCubit>().pickImageFromGallaty();
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  static Future<void> show(BuildContext context) async {
    return await showModalBottomSheet<void>(
      backgroundColor: Colors.white,
      context: context,
      isScrollControlled: true,
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.5,
        maxWidth: MediaQuery.of(context).size.width,
      ),
      builder: (context) => CustomBottomSheet(),
    );
  }
}
*/
*/