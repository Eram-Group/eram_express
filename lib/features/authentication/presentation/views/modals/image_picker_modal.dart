import 'dart:io';

import 'package:eram_express_shared/core/i18n/context_extension.dart';
import 'package:eram_express_shared/presentation/utils/show_modal.dart';
import 'package:eram_express_shared/presentation/widgets/clickable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../app/iconsax_icons.dart';
import '../../widgets/custom_modal.dart';
import 'image_picker_view_model.dart';

class ImagePickerModal<ViewState> extends StatelessWidget {
  final void Function(File) onImagePicked;
  ImagePickerModal({
    super.key,
    required this.onImagePicked,
  });

  final ImagePickerModalViewModel viewModel = ImagePickerModalViewModel();

  Widget _buildOption(
    BuildContext context, {
    required Widget icon,
    required String title,
    Function()? onTap,
  }) {
    return Clickable(
      onTap: onTap,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey.shade200,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          icon,
          const Gap(10),
          Text(title),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ImagePickerModalViewModel, ImagePickerModalState>(
      bloc: viewModel,
      listener: viewModel.listener,
      child: CustomModal(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Select Image',
                style: TextStyle(
                  fontFamily: 'Outfit',
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                  height: 1.3,
                  color: Color(0xFF191D31),
                ),
              ),
              const Gap(20),
              _buildOption(
                context,
                icon: const Icon(
                  Iconsax.camera,
                  color: Color(0xFF194595),
                ),
                title: context.tt(
                  'Pick from Camera',
                  'التقط من الكاميرا',
                ),
                onTap: () => viewModel.optionOnClicked(
                  source: ImageSource.camera,
                  onImagePicked: onImagePicked,
                ),
              ),
              const Gap(20),
              _buildOption(
                context,
                icon: const Icon(
                  Iconsax.gallery,
                  color: Color(0xFF194595),
                ),
                title: context.tt(
                  'Pick from Gallery',
                  'اختر من المعرض',
                ),
                onTap: () => viewModel.optionOnClicked(
                  source: ImageSource.gallery,
                  onImagePicked: onImagePicked,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<File?> show(BuildContext context) async {
    return await showModal(context, (context) => this);
  }
}
