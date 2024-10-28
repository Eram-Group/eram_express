import 'package:either_dart/either.dart';
import 'package:eram_express/features/profile/data/models/terms_model.dart';
import 'package:eram_express_shared/core/api/api_error.dart';

import '../../data/models/about_us_model.dart';

abstract class ProfileRepository
{
  Future<Either<ApiError, AboutUsModel>> getAboutUs();
  Future<Either<ApiError, TermsModel>> getterms();
}