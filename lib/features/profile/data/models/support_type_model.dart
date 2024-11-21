import 'package:eram_express/features/profile/domain/entities/support_type_entity.dart';
import 'package:eram_express_shared/core/utils/logger.dart';

class SupportTypeModel {
  final String value;
  final String label;

  SupportTypeModel({required this.value, required this.label});

  factory SupportTypeModel.fromJson(Map<String, dynamic> json) {
    return SupportTypeModel(
      value: json['value'],
      label: json['label'],
    );
  }

  SupportTypeEntity toEntity() {
    return SupportTypeEntity(value: this.value, label: this.label);
  }
}
