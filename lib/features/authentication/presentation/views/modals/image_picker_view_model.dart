import 'dart:io';

import 'package:either_dart/either.dart';
import 'package:eram_express_shared/core/app_error.dart';
import 'package:eram_express_shared/core/utils/logger.dart';
import 'package:eram_express_shared/presentation/views/modals/error_modal.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

typedef ImagePickerModalState = Either<AppError, File?>;

class ImagePickerModalViewModel extends Cubit<ImagePickerModalState> {
  ImagePickerModalViewModel() : super(const Right(null));

  Future<ImagePickerModalState> _validateImage(XFile? image) async {
    if (image == null) {
      return const Right(null);
    }

    final imageBytes = await image.readAsBytes();

    // Validate image size (1MB)
    if (imageBytes.lengthInBytes > 1024 * 1024) {
      return Left(
        AppError(
          title: 'Invalid image',
          message: 'Image size must be less than 1MB',
        ),
      );
    }

    return Right(File(image.path));
  }

  Future<File?> optionOnClicked({
    required ImageSource source,
    required void Function(File) onImagePicked,
  }) async {
    final image = await ImagePicker().pickImage(source: source);
    final validationResult = await _validateImage(image);

    emit(validationResult);

    if (validationResult.isRight && validationResult.right != null) {
      onImagePicked(validationResult.right!);
      return validationResult.right;
    }

    return null;
  }

  void listener(BuildContext context, ImagePickerModalState state) {
    Navigator.of(context).pop();
    if (state.isRight) {
      logger.debug('Image picked');
    } else {
      logger.debug('Image not picked');
      ErrorModal.fromAppError(state.left).show(context);
    }
  }
}
