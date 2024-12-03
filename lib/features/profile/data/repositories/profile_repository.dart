import 'package:either_dart/either.dart';
import 'package:eram_express/features/profile/data/models/contact_us_model.dart';
import 'package:eram_express/features/profile/data/models/terms_model.dart';
import 'package:eram_express_shared/core/api/api_error.dart';

import '../models/about_us_model.dart';
import '../models/support_type_model.dart';
import '../../presentation/objacts/support_form.dart';

abstract class ProfileRepository 
{
  Future<Either<ApiError, AboutUsModel>> getAboutUs();
  Future<Either<ApiError, TermsModel>> getTerms();
  Future<Either<ApiError, ContactUsModel>> getContactUs();
  Future<Either<ApiError, List<SupportTypeModel>>> getSupportType();
  Future<Either<ApiError, Null>> postSupportForm(SupportForm data);
}

