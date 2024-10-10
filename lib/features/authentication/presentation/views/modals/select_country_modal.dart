import 'package:eram_express_shared/domain/entites/country_entity.dart';
import 'package:flutter/material.dart';

class SelectCountryModal extends StatelessWidget {
  final List<CountryEntity> countries;
  const SelectCountryModal({
    super.key,
    required this.countries,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: countries.length,
      itemBuilder: (context, index) {
        final country = countries[index];
        return ListTile(
          title: Text(country.nameEn),
          onTap: () => Navigator.of(context).pop(country),
        );
      },
    );
  }
}
