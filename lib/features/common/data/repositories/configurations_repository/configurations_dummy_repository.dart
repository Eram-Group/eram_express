import 'package:eram_express_shared/data/models/country_model.dart';
import 'package:eram_express_shared/domain/entites/country_entity.dart';

import '../../../domain/repositories/configurations_repository.dart';

class ConfigurationsDummyRepository implements ConfigurationsRepository {
  @override
  Future<List<CountryEntity>> getCountries() async {
    await Future.delayed(const Duration(seconds: 2));
    return Future.value(
      [
        CountryEntity.fromModel(
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
        ),
        CountryEntity.fromModel(
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
        ),
        CountryEntity.fromModel(
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
        ),
        CountryEntity.fromModel(
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
        ),
        CountryEntity.fromModel(
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
        ),
        CountryEntity.fromModel(
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
        ),
        CountryEntity.fromModel(
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
        ),
      ],
    );
  }
}
