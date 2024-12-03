import 'dart:io';
import 'package:eram_express/features/profile/data/models/support_type_model.dart';
import 'package:eram_express/features/profile/data/models/terms_model.dart';
import 'package:eram_express_shared/core/api/dio_api_client.dart';
import '../../presentation/objacts/support_form.dart';
import '../models/about_us_model.dart';
import '../models/contact_us_model.dart';
import 'profile_api_endpoints.dart';
import 'profile_remote_data_source.dart';

class ProfileApiRemoteDataSource implements ProfileRemoteDataSource {
  final DioApiClient _dioClient;
  ProfileApiRemoteDataSource({required DioApiClient dioClient})
      : _dioClient = dioClient;

@override
  Future<AboutUsModel> getAboutUs() {
    return _dioClient.request(aboutUsEndpoint.prepare());
  }
@override
  Future< TermsModel> getTerms() {
    return _dioClient.request(termsEndpoint.prepare());
  }
@override
  Future<ContactUsModel> getContactUs() {
    return _dioClient.request(contactUsEndpoint.prepare());
  }
@override
  Future<List<SupportTypeModel>> getSupportType() {
    return _dioClient.request(supportEndpoint.prepare());
  }
@override
  Future<void> postSupportForm(
      SupportForm data, String accessToken) {
    return _dioClient.request(contactEndpoint.prepare(body: {
      "category": data.selectedReason!.value,
      "message": data.detailReason,
      "image": data.picture,
    }, headers: {
      HttpHeaders.authorizationHeader: 'Bearer $accessToken',
    }));
  }
}
