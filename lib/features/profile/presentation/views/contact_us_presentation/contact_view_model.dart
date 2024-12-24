import 'package:eram_express/features/profile/presentation/views/support_presentation/support_view.dart';
import 'package:eram_express_shared/core/i18n/context_extension.dart';
import 'package:eram_express_shared/core/utils/responsive.dart';
import 'package:eram_express_shared/presentation/widgets/svgIcon.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../data/models/contact_us_local_model.dart';
import '../../../data/models/contact_us_model.dart';
import '../../../data/repositories/profile_repository_impl.dart';

import 'contact_view_state.dart';

class ContactViewModel extends Cubit<ContactViewState> {
  final ProfileRepository _profileRepository;

  ContactViewModel({required ProfileRepository profileRepository})
      : _profileRepository = profileRepository,
        super( ContactViewState(status: ContactUsStatus.initial));

  Future<void> getContactUs() async {
    emit(state.copyWith(status: ContactUsStatus.loading));
    try {
      final result = await _profileRepository.getContactUs();
      emit(state.copyWith(
          status: ContactUsStatus.loaded, contactUsModel: result));
    } catch (e) {
      emit(state.copyWith(
          status: ContactUsStatus.error,
          errorMessage: "Fail to load contact Us"));
    }
  }
}

class ContactUsItems {
  final BuildContext context;
  ContactUsItems(this.context);

  List<ContactUsLocalModel> generateAllItems(ContactUsModel contactUsModel) {
    return [
      getCallUs(contactUsModel.phoneNumber ?? ''),
      getEmail(contactUsModel.email),
      getWebsite(contactUsModel.website),
      getInstagram(contactUsModel.instagram),
      getFacebook(contactUsModel.facebook),
      getTiktok(contactUsModel.tiktok),
    ];
  }

  List<ContactUsLocalModel> generateContactItems(
      ContactUsModel contactUsModel) {
    return [
      getCallUs(contactUsModel.phoneNumber ?? ''),
      getEmail(contactUsModel.email),
    ];
  }

  List<ContactUsLocalModel> generateSupportItems() {
    return [
      getMessageUs(),
    ];
  }

  List<ContactUsLocalModel> generateSocialMediaItems(
      ContactUsModel contactUsModel) {
    return [
      getInstagram(contactUsModel.instagram),
      getFacebook(contactUsModel.facebook),
      getTiktok(contactUsModel.tiktok),
    ];
  }

  ContactUsLocalModel getMessageUs() {
    return ContactUsLocalModel(
      title: context.tt('Support', "الدعم"),
      subtitle: context.tt(
          'Don’t hesitate to contact Us ', "لا تتردد في الاتصال بنا"),
      onTap: () {
        Navigator.of(context).pushNamed(SupportView.route);
      },
      iconSvg: SvgIcon(
        asset: 'support',
        size: Responsive.getResponsiveFontSize(context, fontSize: 50),
      ),
    );
  }

  ContactUsLocalModel getCallUs(String? phoneNumber) {
    return ContactUsLocalModel(
      title: context.tt('Call Us', "اتصل بنا"),
      onTap: () async {
        launchUrl(
          Uri(
            scheme: 'tel',
            path: phoneNumber,
          ),
        );
      },
      subtitle: context.tt("Our team is on the line\n Mon-Fri 9-17",
          "فريقنا متاح عبر الخط\nمن الإثنين إلى الجمعة • 9-17)"),
      iconSvg: SvgIcon(
        asset: 'call_us',
        size: Responsive.getResponsiveFontSize(context, fontSize: 50),
      ),
    );
  }

  ContactUsLocalModel getEmail(String email) {
    return ContactUsLocalModel(
      title: context.tt("Email", 'ايميل'),
      onTap: () async {
        launchUrl(
          Uri(
            scheme: 'mailto',
            path: email,
          ),
        );
      },
      subtitle: email,
      iconSvg: SvgIcon(
        asset: 'email',
        size: Responsive.getResponsiveFontSize(context, fontSize: 50),
      ),
    );
  }

  ContactUsLocalModel getWebsite(String website) {
    return ContactUsLocalModel(
      title: context.tt("website", 'موقعنا'),
      onTap: () {},
      iconSvg: SvgIcon(
        asset: 'new_website',
        size: Responsive.getResponsiveFontSize(context, fontSize: 50),
      ),
    );
  }

  ContactUsLocalModel getInstagram(String instagram) {
    return ContactUsLocalModel(
      title: context.tt("Instagram", 'انستغرام'),
      onTap: () async {
        launchUrl(Uri.parse(instagram));
      },
      iconSvg: SvgIcon(
        asset: 'instagram',
        size: Responsive.getResponsiveFontSize(context, fontSize: 50),
      ),
    );
  }

  ContactUsLocalModel getFacebook(String facebook) {
    return ContactUsLocalModel(
      title: context.tt("Facebook", 'فيس بوك'),
      onTap: () async {
        launchUrl(Uri.parse(facebook));
      },
      iconSvg: SvgIcon(
        asset: 'facebook',
        size: Responsive.getResponsiveFontSize(context, fontSize: 50),
      ),
    );
  }

  ContactUsLocalModel getTiktok(String tiktok) {
    return ContactUsLocalModel(
      title: context.tt('Tiktok', "تيك توك"),
      onTap: () async {},
      iconSvg: SvgIcon(
        asset: 'call_Us',
        size: Responsive.getResponsiveFontSize(context, fontSize: 50),
      ),
    );
  }
}
