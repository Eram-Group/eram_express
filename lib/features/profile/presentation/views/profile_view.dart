import 'package:eram_express/features/profile/data/models/class_option_Model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../widgets/list_title_card_widgets.dart';
import '../widgets/profile_header_widgets.dart';

class ProfileView extends StatelessWidget {
  static const String route = "/profile";
  ProfileView({super.key});
  List<MenuOptionModel> menuSettings = [
    MenuOptionModel(
      title: "Language",
      /*
    onTap: () {
      // Navigate to the Language screen or perform an action
    },

        icon: SvgIcon(
          asset: "language",
          */
    ),
    MenuOptionModel(
      title: "Notification",
      /*
    onTap: () {
      // Navigate to the Notification screen or perform an action
    },
    
        icon: SvgIcon(
          asset: "Notification",
        )),
        */
    )
  ];
  List<MenuOptionModel> MenuAboutUs = [
    MenuOptionModel(
      title: "Privacy Policy",
      /*
    onTap: () {
      // Navigate to the Language screen or perform an action
    },
  
      icon: SvgIcon(
        asset: "Privacy_policy",
      ), 
      */ // Replace with your actual SVG asset
    ),
    MenuOptionModel(
      title: "Contact Us",
      /*
    onTap: () {
      // Navigate to the Notification screen or perform an action
    },
    
      icon: SvgIcon(
        asset: "Contact_us",
      ),
      */
    ),
    MenuOptionModel(
      title: "Contact Us",
      /*
    onTap: () {
      // Navigate to the Notification screen or perform an action
    },
    
      icon: SvgIcon(
        asset: "Contact_us",
      ),
      */
    )
  ];
  List<MenuOptionModel> MenuOther = [
    MenuOptionModel(
      title: "Share",
      /*
    onTap: () {
      // Navigate to the Language screen or perform an action
    },


      icon: SvgIcon(
        asset: "Share",
      ),
       */
    ),
    MenuOptionModel(
      title: "Get The Latest Version",
      /*
    onTap: () {
      // Navigate to the Notification screen or perform an action
    },
    *
      icon: svgIcon(
        asset: "last_version",
      ),
    ),
    */
    )
  ];

  @override
  Widget build(BuildContext context) {
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
              padding: EdgeInsets.symmetric(horizontal: 20),
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
      ),
    );
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
