
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

 
}
