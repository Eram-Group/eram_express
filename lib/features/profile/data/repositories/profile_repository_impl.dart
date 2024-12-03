import 'package:either_dart/either.dart';
import 'package:either_dart/src/either.dart';
import 'package:eram_express/features/profile/data/models/contact_us_model.dart';
import 'package:eram_express/features/profile/data/models/support_type_model.dart';
import 'package:eram_express/features/profile/data/models/terms_model.dart';
import 'package:eram_express_shared/core/api/api_error.dart';
import '../../../authentication/data/data_sources/tokens/local/tokens_local_data_source.dart';
import '../../presentation/objacts/support_form.dart';
import 'profile_repository.dart';
import '../data_sources/profile_remote_data_source.dart';
import '../models/about_us_model.dart';

class ProfileRepositoryImpl extends ProfileRepository {
  final ProfileRemoteDataSource _profileRemoteDataSource;
  final TokensLocalDataSource _tokensLocalDataSource;
  ProfileRepositoryImpl({
    required final TokensLocalDataSource tokensLocalDataSource,
    required ProfileRemoteDataSource profileRemoteDataSource,
  })  : _profileRemoteDataSource = profileRemoteDataSource,
        _tokensLocalDataSource = tokensLocalDataSource;

@override
  Future<Either<ApiError, AboutUsModel>> getAboutUs() async {
    final response = _profileRemoteDataSource.getAboutUs();
    return response;
  }
@override
  Future<Either<ApiError, TermsModel>> getTerms() async {
    final response = _profileRemoteDataSource.getTerms();
    return response;
  }
@override
  Future<Either<ApiError, ContactUsModel>> getContactUs() async {
    final response = _profileRemoteDataSource.getContactUs();
    return response;
  }
@override
  Future<Either<ApiError, List<SupportTypeModel>>> getSupportType() async {
    final response = _profileRemoteDataSource.getSupportType();
    return response;
  }
@override
  Future<Either<ApiError, Null>> postSupportForm(SupportForm data) async {
    final accessToken = await _tokensLocalDataSource.accessToken;
    if (accessToken == null) {
      return Left(
        ApiError(
          errors: [
            ApiErrorDetail(code: 'code', detail: 'detail', attr: 'attr')
          ],
          type: '',
        ),
      );
    }
    final response = _profileRemoteDataSource.postSupportForm(data, accessToken);
    return response;
  }
}
