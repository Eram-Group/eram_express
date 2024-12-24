import 'package:eram_express/features/profile/data/models/contact_us_model.dart';
import 'package:eram_express/features/profile/data/models/support_type_model.dart';
import 'package:eram_express/features/profile/data/models/terms_model.dart';

import '../../presentation/objacts/support_form.dart';

import '../data_sources/profile_remote_data_source.dart';
import '../models/about_us_model.dart';



abstract class ProfileRepository {
  Future<AboutUsModel> getAboutUs();
  Future<TermsModel> getTerms();
  Future<ContactUsModel> getContactUs();
  Future<List<SupportTypeModel>> getSupportType();
  Future<void> postSupportForm(SupportForm data);
}


class ProfileRepositoryImpl extends ProfileRepository {
  final ProfileRemoteDataSource _profileRemoteDataSource;

  ProfileRepositoryImpl({
  
    required ProfileRemoteDataSource profileRemoteDataSource,
  })  : _profileRemoteDataSource = profileRemoteDataSource;
        

@override
  Future<AboutUsModel> getAboutUs()  {
    return  _profileRemoteDataSource.getAboutUs();
 
  }
@override
  Future<TermsModel> getTerms() {
     return _profileRemoteDataSource.getTerms();
    
  }
@override
  Future<ContactUsModel> getContactUs() {
     return _profileRemoteDataSource.getContactUs();
   
  }
@override
  Future<List<SupportTypeModel>> getSupportType() {
     return  _profileRemoteDataSource.getSupportType();
 
  }
@override
  Future<void> postSupportForm(SupportForm data) 
  {
    return  _profileRemoteDataSource.postSupportForm(data); 
   
  }
}
