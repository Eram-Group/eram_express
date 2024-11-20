import 'package:either_dart/either.dart';
import 'package:eram_express/features/profile/data/models/contact_us_model.dart';
import 'package:eram_express/features/profile/data/models/terms_model.dart';
import 'package:eram_express_shared/core/api/api_error.dart';

import '../models/about_us_model.dart';

abstract class ProfileRemoteDataSource {
  Future<Either<ApiError, AboutUsModel>> getAboutUs();
  Future<Either<ApiError, TermsModel>> getterms();
  Future<Either<ApiError, ContactUsModel>> getContactUs();

  
}
