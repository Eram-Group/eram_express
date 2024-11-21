import 'dart:io';

import '../entities/support_type_entity.dart';

class SupportForm {
  final SupportTypeEntity? selectedReason;
  final String? detailReason;
  final File? picture;

  // Constructor
  SupportForm({
    required this.selectedReason,
    required this.detailReason,
    required this.picture,
  });
}
