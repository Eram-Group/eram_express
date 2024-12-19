import 'package:flutter/material.dart';


 abstract class NavigationService 
{
   static final navigatorKey = GlobalKey<NavigatorState>();
   static BuildContext get globalContext=> navigatorKey.currentContext!; // لما نعمل ميرج هتروح مع التصليحات بتاعتها
}
