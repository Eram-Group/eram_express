import 'package:cached_network_image/cached_network_image.dart';
import 'package:eram_express/core/i18n/context_extension.dart';
import 'package:eram_express/features/common/presentation/widgets/clickable.dart';
import 'package:eram_express_shared/domain/entites/country_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

import '../../../../common/presentation/utils/show_modal.dart';

class SelectCountryModal extends StatelessWidget {
  final CountryEntity selectedCountry;
  final List<CountryEntity> countries;
  const SelectCountryModal({
    super.key,
    required this.selectedCountry,
    required this.countries,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 20),
                width: 60,
                height: 6,
                decoration: BoxDecoration(
                  color: const Color(0xFFDFE2EB),
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ],
          ),
          Text(
            context.tt('Select Country', 'اختر الدولة'),
            style: const TextStyle(
              fontFamily: 'Outfit',
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w600,
              fontSize: 18,
              height: 1.3,
              color: Color(0xFF191D31),
            ),
          ),
          const Gap(20),
          Expanded(
            child: SingleChildScrollView(
              child: SafeArea(
                child: Column(
                  children: [
                    for (final country in countries)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: _buildCountryOption(
                          context,
                          country,
                          country == selectedCountry,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCountryOption(
    BuildContext context,
    CountryEntity country,
    bool isSelected,
  ) {
    return Clickable(
      onTap: () => Navigator.of(context).pop(country),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        border: Border.all(
          color: isSelected ? const Color(0xFF3FAD79) : Colors.grey.shade200,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: CachedNetworkImageProvider(country.flag),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const Gap(14),
          Expanded(
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: context.tt(country.nameEn, country.nameAr),
                    style: const TextStyle(
                      fontFamily: 'Outfit',
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      height: 1.3,
                      color: Color(0xFF191D31),
                    ),
                  ),
                  const TextSpan(
                    text: '  ',
                  ),
                  TextSpan(
                    text: "(${country.phoneCode})",
                    style: TextStyle(
                      fontFamily: 'Outfit',
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      height: 1.3,
                      color: const Color(0xFF191D31).withOpacity(0.5),
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (isSelected) SvgPicture.asset('assets/icons/tick-circle.svg'),
        ],
      ),
    );
  }

  Future<CountryEntity?> show(BuildContext context) async =>
      await showModal<CountryEntity>(context, (context) => this);
}
