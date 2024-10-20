import 'package:either_dart/either.dart';
import 'package:eram_express_shared/data/configurations/models/country_model.dart';

import '../../../../../../core/api/api_error.dart';
import 'configurations_remote_data_source.dart';

class ConfigurationsMockRemoteDataSource
    implements ConfigurationsRemoteDataSource {
  @override
  Future<Either<ApiError, List<CountryModel>>> getCountries() async {
    await Future.delayed(const Duration(seconds: 2));
    return Right([
      CountryModel(
        code: 'SA',
        currency: 'SAR',
        flag:
            'https://eramex-prod-eramapps.s3.me-central-1.amazonaws.com/media/flags/SA.png',
        nameAr: 'المملكة العربية السعودية',
        nameEn: 'Saudi Arabia',
        phoneCode: '+966',
        numberLength: 9,
        numberFormat: '000 000 000',
      ),
      CountryModel(
        code: 'AE',
        currency: 'AED',
        flag:
            'https://eramex-prod-eramapps.s3.me-central-1.amazonaws.com/media/flags/AE.png',
        nameAr: 'الإمارات العربية المتحدة',
        nameEn: 'United Arab Emirates',
        phoneCode: '+971',
        numberLength: 9,
        numberFormat: '000 000 000',
      ),
      CountryModel(
        code: 'KW',
        currency: 'KWD',
        flag:
            'https://eramex-prod-eramapps.s3.me-central-1.amazonaws.com/media/flags/KW.png',
        nameAr: 'الكويت',
        nameEn: 'Kuwait',
        phoneCode: '+965',
        numberLength: 8,
        numberFormat: '0000 0000',
      ),
      CountryModel(
        code: 'QA',
        currency: 'QAR',
        flag:
            'https://eramex-prod-eramapps.s3.me-central-1.amazonaws.com/media/flags/QA.png',
        nameAr: 'قطر',
        nameEn: 'Qatar',
        phoneCode: '+974',
        numberLength: 8,
        numberFormat: '0000 0000',
      ),
      CountryModel(
        code: 'OM',
        currency: 'OMR',
        flag:
            'https://eramex-prod-eramapps.s3.me-central-1.amazonaws.com/media/flags/OM.svg',
        nameAr: 'عمان',
        nameEn: 'Oman',
        phoneCode: '+968',
        numberLength: 8,
        numberFormat: '0000 0000',
      ),
      CountryModel(
        code: 'BH',
        currency: 'BHD',
        flag:
            'https://eramex-prod-eramapps.s3.me-central-1.amazonaws.com/media/flags/BH.svg',
        nameAr: 'البحرين',
        nameEn: 'Bahrain',
        phoneCode: '+973',
        numberLength: 8,
        numberFormat: '0000 0000',
      ),
      CountryModel(
        code: 'EG',
        currency: 'EGP',
        flag:
            'https://eramex-prod-eramapps.s3.me-central-1.amazonaws.com/media/flags/EG.png',
        nameAr: 'مصر',
        nameEn: 'Egypt',
        phoneCode: '+20',
        numberLength: 10,
        numberFormat: '000 000 0000',
      ),
    ]);
  }
}
