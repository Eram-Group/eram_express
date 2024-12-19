import 'package:eram_express/features/profile/data/models/support_type_model.dart';
import 'package:eram_express/features/profile/data/models/terms_model.dart';
import 'package:eram_express_shared/core/api/network-service.dart';
import '../../../../app/api_keys.dart';
import '../../presentation/objacts/support_form.dart';
import '../models/about_us_model.dart';
import '../models/contact_us_model.dart';
import 'profile_remote_data_source.dart';

class ProfileApiRemoteDataSource implements ProfileRemoteDataSource {
  final NetworkService _networkService;
  ProfileApiRemoteDataSource({required NetworkService networkService})
      : _networkService = networkService;

  @override
  Future<AboutUsModel> getAboutUs() async {
    final response = await _networkService.get('$baseUrl/app/about-us/');
    return AboutUsModel.fromMap(response.data);
  }

  @override
  Future<TermsModel> getTerms() async {
    final response =
        await _networkService.get('$baseUrl/app/terms-and-conditions/');
    return TermsModel.fromMap(response.data);
  }

  @override
  Future<ContactUsModel> getContactUs() async {
    final response = await _networkService.get('$baseUrl/app/social-accounts/');
    return ContactUsModel.fromMap(response.data);
  }

  @override
  Future<List<SupportTypeModel>> getSupportType() async {
    final response =
        await _networkService.get('$baseUrl/communication/contact/types/');
    return (response.data as List)
        .map((item) => SupportTypeModel.fromMap(item))
        .toList();
  }

  @override
  Future<void> postSupportForm(SupportForm data) {
    return _networkService.post(
      '$baseUrl/communication/contact/',
      data: {
        "category": data.selectedReason!.value,
        "message": data.detailReason,
        "image": data.picture,
      },
    );
  }
}
