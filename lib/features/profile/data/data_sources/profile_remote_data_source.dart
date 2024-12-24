import 'package:eram_express/features/profile/data/models/contact_us_model.dart';
import 'package:eram_express/features/profile/data/models/support_type_model.dart';
import 'package:eram_express/features/profile/data/models/terms_model.dart';
import 'package:eram_express/features/profile/presentation/objacts/support_form.dart';
import '../models/about_us_model.dart';

abstract class ProfileRemoteDataSource {
  Future< AboutUsModel> getAboutUs();
  Future<TermsModel> getTerms();
  Future<ContactUsModel> getContactUs();
  Future< List<SupportTypeModel>> getSupportType();
  Future<void> postSupportForm(SupportForm data,) ;
   
  
}