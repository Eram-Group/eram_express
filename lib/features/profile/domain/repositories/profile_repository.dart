import 'package:either_dart/either.dart';
import 'package:eram_express/features/profile/data/models/contact_us_model.dart';
import 'package:eram_express/features/profile/data/models/terms_model.dart';
import 'package:eram_express_shared/core/api/api_error.dart';

import '../../data/models/about_us_model.dart';
import '../../data/models/support_type_model.dart';

abstract class ProfileRepository 
{
  Future<Either<ApiError, AboutUsModel>> getAboutUs();
  Future<Either<ApiError, TermsModel>> getterms();
  Future<Either<ApiError, ContactUsModel>> getContactUs();
  Future<Either<ApiError, List<SupportTypeModel>>> getSupportType();
}
