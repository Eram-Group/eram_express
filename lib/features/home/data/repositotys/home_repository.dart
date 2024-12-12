import 'dart:async';
import 'package:eram_express/features/home/data/models/home-Model.dart';


abstract class HomeRepository 
{
  Future<HomeModel>getHome();
}
