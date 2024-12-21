import 'dart:io';
import 'package:eram_express/features/profile/data/models/support_type_model.dart';
class SupportForm {
  final SupportTypeModel? selectedReason;
  final String? detailReason;
  final File? picture;

  // Constructor
  SupportForm({
    required this.selectedReason,
    required this.detailReason,
    required this.picture,
  });
}
