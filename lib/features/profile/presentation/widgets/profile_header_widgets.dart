import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../authentication/presentation/views/screens/complete_profile/complete_profile_view.dart';
import '../views/profile_presentation/profile_view_model.dart';
import '../views/profile_presentation/profile_view_state.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileViewModel, ProfileViewState>(
      builder: (context, state) {
        return LayoutBuilder(
          builder: (context, constraints) {
            return Stack(
              children: [
                Positioned.fill(
                  child: SvgPicture.asset(
                    "assets/icons/profile_view.svg",
                    fit: BoxFit.fill,
                  ),
                ),
                Positioned(
                  top: 70,
                  left: 20,
                  child: Text(
                    "My Profile",
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                  ),
                ),
                Positioned(
                  bottom: 20,
                  left: 20,
                  right: 10,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleProfilePictureWidget(
                        size: 55,
                        profilePictureUrl: state.currentCustomer!.image,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  state.currentCustomer!.fullName.isEmpty
                                      ? " anonymous"
                                      : state.currentCustomer!.fullName,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(color: Colors.white),
                                ),
                                Text(
                                  state.currentCustomer!.phoneNumber,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(color: Colors.white),
                                ),
                              ],
                            ),
                            GestureDetector(
                              onTap: () => context
                                  .read<ProfileViewModel>()
                                  .EditProfileClickable(context),
                              child: Container(
                                height: 38,
                                width: 100,
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(.15),
                                  border: Border.all(
                                    width: 1,
                                    color: Colors.white.withOpacity(0.15),
                                  ),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Center(
                                  child: Text(
                                    "Edit Profile",
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelLarge!
                                        .copyWith(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
