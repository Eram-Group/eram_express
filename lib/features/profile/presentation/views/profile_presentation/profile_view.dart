import 'package:eram_express/app/navigation.dart';
import 'package:eram_express/features/authentication/presentation/views/screens/login/login_view.dart';
import 'package:eram_express/features/profile/presentation/views/contact_us_presentation/contact_view.dart';
import 'package:eram_express/features/profile/presentation/views/terms_presentation/terms_view.dart';
import 'package:eram_express_shared/core/iconsax_icons.dart';
import 'package:eram_express_shared/core/utils/responsive.dart';
import 'package:eram_express_shared/presentation/widgets/svgIcon.dart';
import 'package:eram_express_shared/service_locator.dart';
import 'package:eram_express_shared/tokens/local/tokens_local_data_source.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../data/models/menu_option_model.dart';
import '../../modals/language_modal.dart';
import '../../widgets/list_title_card_widgets.dart';
import '../../widgets/profile_header_widgets.dart';
import '../about_us_presentation/about_us_view.dart';
import 'profile_view_model.dart';
import 'profile_view_state.dart';

class ProfileView extends StatelessWidget {
  static const String route = "/profile";
  ProfileView({super.key});

  List<MenuOptionModel> menuSettings = [
    MenuOptionModel(
      title: "Language",
      onTap: (context) {
        LanguageModal().show(NavigationService.globalContext);
      },
      icon: const Icon(Iconsax.global),
    ),
    MenuOptionModel(
        title: "Notification",
        onTap: (context) {},
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
      onTap: (context) {
        Navigator.of(NavigationService.globalContext)
            .pushNamed(TermsView.route);
      },
    ),
    MenuOptionModel(
      title: "Contact Us",
      icon: const SvgIcon(asset: "contact"),
      onTap: (context) {
        Navigator.of(NavigationService.globalContext)
            .pushNamed(ContactUsView.route);
      },
    ),
    MenuOptionModel(
      title: "About Us",
      icon: const SvgIcon(
        asset: "about",
      ),
      onTap: (context) {
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
      onTap: (context) {},
    ),
    MenuOptionModel(
      title: "Get The Latest Version",
      icon: const SvgIcon(
        asset: "last_version",
      ),
      onTap: (context) {
        Navigator.of(NavigationService.globalContext)
            .pushNamed(TermsView.route);
      },
    ),
    MenuOptionModel(
      title: "Log Out",
      icon: const SvgIcon(
        asset: "logout",
      ),
      onTap: (context) async {
        context.read<ProfileViewModel>().logout();
      },
    ),
  ];

  @override
  Widget build(BuildContext context) {
    {
      return BlocProvider<ProfileViewModel>(
          create: (context) => sl()..getCustomerData(),
          child: BlocListener<ProfileViewModel, ProfileViewState>(
            listener: (context, state) {
              if (state.isLogOut) {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  LoginView.route,
                  (Route<dynamic> route) => false,
                );
              }
            },
            child: Builder(builder: (context) {
              return Scaffold(
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
                  ));
            }),
          ));
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
        style: const TextStyle(
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
