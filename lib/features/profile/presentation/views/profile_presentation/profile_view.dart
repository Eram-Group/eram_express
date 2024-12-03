import 'package:eram_express/app/di.dart';
import 'package:eram_express/app/navigation.dart';
import 'package:eram_express/features/profile/presentation/views/contact_us_presentation/contact_view.dart';
import 'package:eram_express/features/profile/presentation/views/terms_presentation/terms_view.dart';
import 'package:eram_express_shared/core/iconsax_icons.dart';
import 'package:eram_express_shared/core/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../data/models/menu_option_model.dart';
import '../../modals/language_modal.dart';
import '../../widgets/list_title_card_widgets.dart';
import '../../widgets/profile_header_widgets.dart';
import '../about_us_presentation/about_us_view.dart';
import 'profile_view_model.dart';

class ProfileView extends StatelessWidget {
  static const String route = "/profile";
  ProfileView({super.key});
  List<MenuOptionModel> menuSettings = [
    MenuOptionModel(
      title: "Language",
      onTap: () {
        LanguageModal().show(NavigationService.globalContext);
      },
      icon: const Icon(Iconsax.global),
    ),
    MenuOptionModel(
        title: "Notification",
        onTap: () {
          // Navigate to the Notification screen or perform an action
        },
        icon: SvgIcon(
          asset: "Notification",
        ))
  ];
  List<MenuOptionModel> MenuAboutUs = [
    MenuOptionModel(
      title: "Terms&Condiotions",
      icon: const SvgIcon(
        asset: "terms",
      ),
      onTap: () {
        Navigator.of(NavigationService.globalContext)
            .pushNamed(TermsView.route);
      },
    ),
    MenuOptionModel(
      title: "Contact Us",
      icon: const SvgIcon(asset: "contact"),
      onTap: () {
        Navigator.of(NavigationService.globalContext)
            .pushNamed(ContactUsView.route);
      },
    ),
    MenuOptionModel(
      title: "About Us",
      icon: const SvgIcon(
        asset: "about",
      ),
      onTap: () {
        Navigator.of(NavigationService.globalContext)
            .pushNamed(AboutUsView.route);
      },
    ),
  ];
  List<MenuOptionModel> MenuOther = [
    MenuOptionModel(
      title: "Share",
      icon: const SvgIcon(
        asset: "Share",
      ),
      onTap: () {},
    ),
    MenuOptionModel(
      title: "Get The Latest Version",
      icon: SvgIcon(
        asset: "last_version",
      ),
      onTap: () {
        Navigator.of(NavigationService.globalContext)
            .pushNamed(TermsView.route);
      },
    ),
  ];
  ProfileViewModel profileViewModel = ProfileViewModel(
    customerservice: customerService,
    authenticationRepository: authenticationRepository,
  );

  @override
  Widget build(BuildContext context) {
    {
      return BlocProvider(
          create: (context) => profileViewModel,
          child: Scaffold(
              backgroundColor: Colors.white,
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Expanded(
                    flex: 1,
                    child: ProfileHeader(),
                  ),
                  Expanded(
                    flex: 3,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: ListView(
                        children: [
                          TypeSettingProfile(
                            typeSetting: "Settings",
                          ),
                          BuildItems(items: menuSettings),
                          TypeSettingProfile(
                            typeSetting: "About Us",
                          ),
                          BuildItems(items: MenuAboutUs),
                          TypeSettingProfile(
                            typeSetting: "Other",
                          ),
                          BuildItems(items: MenuOther),
                        ],
                      ),
                    ),
                  ),
                ],
              )));
    }
  }
}

class BuildItems extends StatelessWidget {
  final List<MenuOptionModel> items;
  BuildItems({required this.items});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: items
          .map((item) => listtitleCard(
                menuOption: item,
              ))
          .toList(),
    );
  }
}

class TypeSettingProfile extends StatelessWidget {
  String typeSetting;
  TypeSettingProfile({required this.typeSetting});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Text(
        typeSetting,
        style: TextStyle(
          color: Color(0xFF191D31),
          fontSize: 18,
          fontFamily: 'Outfit',
          fontWeight: FontWeight.w600,
          height: 0.08,
        ),
      ),
    );
  }
}

String iconsPath = 'assets/icons';

String iconAsset(String iconName) => '$iconsPath/$iconName.svg';

class SvgIcon extends StatelessWidget {
  final String? asset;
  final Color? color;
  final double size;
  final BoxFit fit;

  const SvgIcon({
    super.key,
    this.asset,
    this.color,
    this.size = 24,
    this.fit = BoxFit.contain,
  });

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      iconAsset(asset!),
      //colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
      width: Responsive.getResponsiveFontSize(context, fontSize: size),
      height: Responsive.getResponsiveFontSize(context, fontSize: size), //size,
      fit: fit,
    );
  }
}
