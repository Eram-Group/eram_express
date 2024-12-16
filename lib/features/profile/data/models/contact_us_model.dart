import 'dart:convert';

import 'package:flutter/widgets.dart';

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

  ContactUsModel copyWith({
    String? email,
    ValueGetter<String?>? phoneNumber,
    String? instagram,
    String? tiktok,
    String? website,
    String? twitter,
    String? facebook,
  }) {
    return ContactUsModel(
      email: email ?? this.email,
      phoneNumber: phoneNumber != null ? phoneNumber() : this.phoneNumber,
      instagram: instagram ?? this.instagram,
      tiktok: tiktok ?? this.tiktok,
      website: website ?? this.website,
      twitter: twitter ?? this.twitter,
      facebook: facebook ?? this.facebook,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'phoneNumber': phoneNumber,
      'instagram': instagram,
      'tiktok': tiktok,
      'website': website,
      'twitter': twitter,
      'facebook': facebook,
    };
  }

  factory ContactUsModel.fromMap(Map<String, dynamic> map) {
    return ContactUsModel(
      email: map['email'] ?? '',
      phoneNumber: map['phoneNumber'],
      instagram: map['instagram'] ?? '',
      tiktok: map['tiktok'] ?? '',
      website: map['website'] ?? '',
      twitter: map['twitter'] ?? '',
      facebook: map['facebook'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ContactUsModel.fromJson(String source) => ContactUsModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ContactUsModel(email: $email, phoneNumber: $phoneNumber, instagram: $instagram, tiktok: $tiktok, website: $website, twitter: $twitter, facebook: $facebook)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is ContactUsModel &&
      other.email == email &&
      other.phoneNumber == phoneNumber &&
      other.instagram == instagram &&
      other.tiktok == tiktok &&
      other.website == website &&
      other.twitter == twitter &&
      other.facebook == facebook;
  }

  @override
  int get hashCode {
    return email.hashCode ^
      phoneNumber.hashCode ^
      instagram.hashCode ^
      tiktok.hashCode ^
      website.hashCode ^
      twitter.hashCode ^
      facebook.hashCode;
  }
}
