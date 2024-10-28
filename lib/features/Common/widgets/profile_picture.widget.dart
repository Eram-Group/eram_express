import 'dart:io';

import 'package:eram_express/app/iconsax_icons.dart';
import 'package:eram_express_shared/presentation/widgets/clickable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfilePictureWidget extends StatelessWidget {
  final File? profilePicture; // Assuming profilePicture is a File
  final bool saveButtonLoading;
  final Function(BuildContext) onCameraClick; // Function to handle camera click

  const ProfilePictureWidget({
    Key? key,
    this.profilePicture,
    required this.saveButtonLoading,
    required this.onCameraClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: 89,
          height: 89,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: const Color(0xFFEEF1F8),
            image: profilePicture == null
                ? null
                : DecorationImage(
                    image: Image.file(profilePicture!).image,
                    fit: BoxFit.cover,
                  ),
          ),
          child: profilePicture != null
              ? null
              : Center(
                  child: SvgPicture.asset(
                    'assets/icons/user.svg',
                  ),
                ),
        ),
        Positioned(
          bottom: -10,
          right: -10,
          child: Clickable(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: saveButtonLoading
                  ? const Color.fromARGB(255, 105, 129, 176)
                  : const Color(0xFF194595),
              border: Border.all(
                color: Colors.white,
                width: 1.5,
              ),
            ),
            onTap: () => onCameraClick(context), // Use the passed function
            child: Center(
              child: Icon(
                Iconsax.camera,
                color: saveButtonLoading
                    ? Colors.white.withOpacity(0.5)
                    : Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
