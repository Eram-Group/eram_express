import 'package:either_dart/src/either.dart';
import 'package:eram_express/features/profile/data/models/terms_model.dart';
import 'package:eram_express_shared/core/api/api_error.dart';
import 'package:eram_express_shared/core/api/dio_api_client.dart';

import '../models/about_us_model.dart';
import 'profile_api_endpoints.dart';
import 'profile_remote_data_source.dart';

class ProfileApiRemoteDataSource implements ProfileRemoteDataSource {
  final DioApiClient _dioClient;
  ProfileApiRemoteDataSource({required DioApiClient dioClient})
      : _dioClient = dioClient;

  @override
  Future<Either<ApiError, AboutUsModel>> getAboutUs() {
    return _dioClient.request(aboutUsEndpoint.prepare());
  }

  Future<Either<ApiError, TermsModel>> getterms() {
    return _dioClient.request(termsEndpoint.prepare());
  }
}
