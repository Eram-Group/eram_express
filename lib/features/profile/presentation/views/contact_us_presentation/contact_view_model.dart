import 'package:eram_express/features/profile/presentation/views/support_view.dart';
import 'package:eram_express_shared/core/i18n/context_extension.dart';
import 'package:eram_express_shared/core/utils/responsive.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../data/models/contact_us_model.dart';
import '../../../data/models/contact_us_local_model.dart';
import '../../../data/repositories/profile_repository_impl.dart';
import '../profile_presentation/profile_view.dart';
import 'contact_view_state.dart';

class ContactViewModel extends Cubit<ContactViewState> {
  final ProfileRepository _profileRepository;

  ContactViewModel({required ProfileRepository profileRepository})
      : _profileRepository = profileRepository,
        super(ContactViewLoadingState());

  Future<void> getContactUs() async {
    emit(ContactViewLoadingState());
    try{
    final result = await _profileRepository.getContactUs();
      emit(ContactViewLoadedState(result));
    }
    catch(e)
    {
       emit(ContactViewErrorState(errormesseg: "Error in Loading data"));
    }

  }
}

class ContactUsItems {
  final BuildContext context;
  ContactUsItems(this.context);

  List<ContactUsViewModel> generateAllItems(ContactUsModel contantusmodel) {
    return [
      getCallUs(contantusmodel.phoneNumber ?? ''),
      getEmail(contantusmodel.email),
      getWebsite(contantusmodel.website),
      getInstagram(contantusmodel.instagram),
      getFacebook(contantusmodel.facebook),
      getTiktok(contantusmodel.tiktok),
    ];
  }

  List<ContactUsViewModel> generateContactItems(ContactUsModel contantusmodel) {
    return [
      getCallUs(contantusmodel.phoneNumber ?? ''),
      getEmail(contantusmodel.email),
    ];
  }

  List<ContactUsViewModel> generateSupportItems() {
    return [
      getMessageUs(),
    ];
  }

  List<ContactUsViewModel> generateSocialMediaItems(
      ContactUsModel contantusmodel) {
    return [
      getInstagram(contantusmodel.instagram),
      getFacebook(contantusmodel.facebook),
      getTiktok(contantusmodel.tiktok),
    ];
  }

  // دالة getMessageUs
  ContactUsViewModel getMessageUs() {
    return ContactUsViewModel(
      title: context.tt('Support', "الدعم"),
      subtitle: context.tt(
          'Don’t hesitate to contact us ', "لا تتردد في الاتصال بنا"),
      onTap: () {
        Navigator.of(context).pushNamed(SupportView.route);
      },
      iconSvg: SvgIcon(
        asset: 'support',
        size: Responsive.getResponsiveFontSize(context, fontSize: 50),
      ),
    );
  }

  // دالة getCallUs
  ContactUsViewModel getCallUs(String? phoneNumber) {
    return ContactUsViewModel(
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

  // دالة getEmail
  ContactUsViewModel getEmail(String email) {
    return ContactUsViewModel(
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

  // دالة getWebsite
  ContactUsViewModel getWebsite(String website) {
    return ContactUsViewModel(
      title: context.tt("website", 'موقعنا'),
      onTap: () {},
      iconSvg: SvgIcon(
        asset: 'new_website',
        size: Responsive.getResponsiveFontSize(context, fontSize: 50),
      ),
    );
  }

  // دالة getInstagram
  ContactUsViewModel getInstagram(String instagram) {
    return ContactUsViewModel(
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

  // دالة getFacebook
  ContactUsViewModel getFacebook(String facebook) {
    return ContactUsViewModel(
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

  // دالة getTiktok
  ContactUsViewModel getTiktok(String tiktok) {
    return ContactUsViewModel(
      title: context.tt('Tiktok', "تيك توك"),
      onTap: () async {},
      iconSvg: SvgIcon(
        asset: 'call_us',
        size: Responsive.getResponsiveFontSize(context, fontSize: 50),
      ),
    );
  }
}