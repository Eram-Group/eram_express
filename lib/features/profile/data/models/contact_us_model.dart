class ContactUsModel {
  final String email;
  final String? phoneNumber;
  final String instagram;
  final String tiktok;
  final String website;
  final String twitter;
  final String facebook;

  ContactUsModel({
    required this.email,
    this.phoneNumber,
    required this.instagram,
    required this.tiktok,
    required this.website,
    required this.twitter,
    required this.facebook,
  });

  factory ContactUsModel.fromJson(Map<String, dynamic> json) {
    return ContactUsModel(
      email: json['email'] ?? '',
      phoneNumber: json['phone_number'],
      instagram: json['instagram'] ?? '',
      tiktok: json['tiktok'] ?? '',
      website: json['website'] ?? '',
      twitter: json['twitter'] ?? '',
      facebook: json['facebook'] ?? '',
    );
  }
}
