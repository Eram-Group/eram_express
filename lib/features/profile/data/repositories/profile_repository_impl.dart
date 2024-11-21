import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:either_dart/src/either.dart';
import 'package:eram_express/app/di.dart';
import 'package:eram_express/features/profile/data/models/contact_us_model.dart';
import 'package:eram_express/features/profile/data/models/support_type_model.dart';
import 'package:eram_express/features/profile/data/models/terms_model.dart';
import 'package:eram_express_shared/core/api/api_error.dart';
import 'package:eram_express_shared/core/api/dio_api_client.dart';

import 'package:eram_express_shared/core/app_error.dart';

import '../../../authentication/data/data_sources/tokens/local/tokens_local_data_source.dart';
import '../../domain/objacts/support_form.dart';
import '../../domain/repositories/profile_repository.dart';
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
    final Response = _profileRemoteDataSource.getAboutUs();
    return Response;
  }

  Future<Either<ApiError, TermsModel>> getterms() async {
    final Response = _profileRemoteDataSource.getterms();
    return Response;
  }

  Future<Either<ApiError, ContactUsModel>> getContactUs() async {
    final Response = _profileRemoteDataSource.getContactUs();
    return Response;
  }

  Future<Either<ApiError, List<SupportTypeModel>>> getSupportType() async {
    final Response = _profileRemoteDataSource.getSupportType();
    return Response;
  }

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
    final Response = _profileRemoteDataSource.postSupportForm(data, accessToken);
    return Response;
  }
}
