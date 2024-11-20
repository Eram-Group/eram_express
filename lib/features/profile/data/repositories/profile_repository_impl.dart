import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:either_dart/src/either.dart';
import 'package:eram_express/features/profile/data/models/contact_us_model.dart';
import 'package:eram_express/features/profile/data/models/terms_model.dart';
import 'package:eram_express_shared/core/api/api_error.dart';
import 'package:eram_express_shared/core/api/dio_api_client.dart';

import 'package:eram_express_shared/core/app_error.dart';

import '../../domain/repositories/profile_repository.dart';
import '../data_sources/profile_remote_data_source.dart';
import '../models/about_us_model.dart';

class ProfileRepositoryImpl extends ProfileRepository 
{
  final ProfileRemoteDataSource _profileRemoteDataSource;
  ProfileRepositoryImpl({
    required ProfileRemoteDataSource profileRemoteDataSource,
  }) : _profileRemoteDataSource = profileRemoteDataSource;

  @override
  Future<Either<ApiError, AboutUsModel>> getAboutUs() async 
  {
  final Response= _profileRemoteDataSource.getAboutUs();
 return await  Response.fold(
    (error)=>Left(error),
    (data)=>Right(data));
 
   
  }
    Future<Either<ApiError, TermsModel>> getterms() async
   {
    final Response = _profileRemoteDataSource.getterms();
    return await Response.fold((error) => Left(error), (data) => Right(data));
  }
  Future<Either<ApiError, ContactUsModel>> getContactUs() async{

         final Response = _profileRemoteDataSource.getContactUs();
    return await Response.fold((error) => Left(error), (data) => Right(data));
}
}
