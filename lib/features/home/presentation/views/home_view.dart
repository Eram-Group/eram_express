import 'package:eram_express/core/app_colors.dart';
import 'package:eram_express_shared/core/i18n/context_extension.dart';
import 'package:eram_express_shared/core/utils/logger.dart';
import 'package:eram_express_shared/core/utils/responsive.dart';
import 'package:eram_express_shared/presentation/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:logger/logger.dart';
import '../../../../app/di.dart';
import '../../../../core/app_text_style.dart';
import '../../../Common/presentation/widgets/SvgIcon.dart';
import '../../../booking/presentation/views/all_booking_request_view.dart';
import '../../../booking/presentation/views/offers_view.dart';
import '../../../booking/presentation/views/booking_request_view_controller.dart';
import '../../../booking/presentation/views/booking_request_view_state.dart';
import '../../../booking/presentation/widgets/booking_request_card.dart';
import '../../data/models/cargo-categoriesModel.dart';
import '../../data/models/cargo-subcategoryModel.dart';
import '../../data/models/picking_locationModel.dart';
import '../modals/failed-request-modal.dart';
import '../modals/successful-request-modal.dart';

import '../widgets/empty_booking_view.dart';
import '../widgets/selection-card.dart';
import 'home_view_controller.dart';
import 'home_view_state.dart';

class HomeView extends StatelessWidget {
  static const String route = '/home';
  final HomeViewController homeViewModel = HomeViewController(
      homeRepo: homeRepository,
      bookingRepository: bookingRepository);

  final BookingRequestViewController bookingRequestViewModel =
      BookingRequestViewController(
          bookingRepository: bookingRepository,
      );

  HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
            child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Column(
              children: [
                Stack(
                  children: [
                    _buildHeader(context),
                    _builddataContainer(context),
                  ],
                ),
                BlocListener<HomeViewController, HomeViewState>(
                  bloc: homeViewModel,
                  listener: (context, state) {
                    if (state is RequestCreateSuccess) {
                      const SuccessfulRequestModal().show(context);
                      bookingRequestViewModel.listBookingRequest();
                    }
                    if (state is RequestCreateError) {
                      const FailedOrderModal().show(context);
                    }
                  },
                  child: _buildBookingRequest(),
                ),
              ],
            ),
          ),
        )));
  }

/*
لما نعمل merge 
هستخدم 
profile viewmodel
*/

  Widget _buildHeader(BuildContext context) {
    return Container(
        width: Responsive.screenWidth,
        height: Responsive.screenHeight! * .32,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/image/homePic.jpg'),
            fit: BoxFit.fill,
          ),
        ),
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 25,
                  child: Image.asset("assets/image/Image.jpg"),
                ),
                const SizedBox(
                  width: 15,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Ahmed Adel",
                      style: TextStyle(
                        fontFamily: 'Outfit',
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      context.tt("Have a nice day !", 'يوم سعيد'),
                      style: TextStyle(
                        fontFamily: 'Outfit',
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                )
              ],
            )));
  }

  Widget _builddataContainer(BuildContext context) {
    logger.debug(" rebuild data Conatiner");
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 110)
          .copyWith(bottom: 0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: const[
               BoxShadow(
                color: Color(0x1C000000),
                offset: Offset(0, 4), 
                blurRadius: 24, 
                spreadRadius: 0, 
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  context.tt("Ship your goods with us", "اشحن بضائعك معنا"),
                  style: const TextStyle(
                    fontFamily: 'Outfit',
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Gap(16),
                _buildLocationRow(context),
                _buildLoadTypeField(context),
                _buildTruckSizeField(context),
                _buildDateField(context),
                _buildGoodsField(context),
                const Gap(8),
                _buildCustomButton(),
                const Gap(8),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLocationRow(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: BlocSelector<HomeViewController, HomeViewState,
                PickingLocationModel?>(
          bloc: homeViewModel,
          selector: (state) => state.pickup, // تحديد الخاصية المطلوبة فقط
          builder: (context, pickup) {
            return SelectionCard(
              onTap: () => homeViewModel.PickClicked(context),
              selectedValue: pickup?.address ?? " ", // استخدام الخاصية المحددة
              label: pickup?.address ?? "Pick up",
              iconName: 'Pick_Up',
            );
          },
        )),
        const Gap(7),
        Expanded(
            child: BlocSelector<HomeViewController, HomeViewState,
                PickingLocationModel?>(
          bloc: homeViewModel,
          selector: (state) => state.destination,
          builder: (context, destination) {
            return SelectionCard(
              onTap: () => homeViewModel.destinationClicked(context),
              selectedValue: destination?.address ?? " ",
              label: destination?.address ?? "Destination",
              iconName: 'destination',
            );
          },
        )),
      ],
    );
  }

  Widget _buildLoadTypeField(BuildContext context) {
    return BlocSelector<HomeViewController, HomeViewState,
        CargoCategoryModel?>(
      bloc: homeViewModel,
      selector: (state) => state.loadType,
      builder: (context, loadType) {
        logger.debug("enter in loaded");
        return SelectionCard(
          onTap: () => homeViewModel.cargoCategoryOnClicked(context),
          selectedValue:
              context.tt(loadType?.nameEn ?? " ", loadType?.nameAr ?? " "),
          label: context.tt(loadType?.nameEn ?? "Select the load type",
              loadType?.nameAr ?? "اختر نوع الحمولة"),
          iconName: 'arrow-down',
        );
      },
    );
  }

  Widget _buildTruckSizeField(BuildContext context) {
    return BlocSelector<HomeViewController, HomeViewState,
        CargoSubCategoryModel?>(
      bloc: homeViewModel,
      selector: (state) => state.truckSize,
      builder: (context, truckSize) {
        logger.debug("message in truck");
        return SelectionCard(
          onTap: () => homeViewModel.cargosubCategoryOnClicked(context),
          selectedValue:
              context.tt(truckSize?.nameEn ?? " ", truckSize?.nameAr ?? " "),
          label: context.tt(truckSize?.nameEn ?? "Choose the size of the truck",
              truckSize?.nameAr ?? "اختر حجم حمولتك"),
          iconName: 'sizeTrack',
        );
      },
    );
  }

  Widget _buildDateField(BuildContext context) {
    return BlocSelector<HomeViewController, HomeViewState, String?>(
      bloc: homeViewModel,
      selector: (state) => state.pickupDate, // تحديد الخاصية المطلوبة فقط
      builder: (context, pickupDate) {
        return SelectionCard(
          onTap: () => homeViewModel.pickdateOnClicked(context),
          selectedValue: context.tt(
            pickupDate ?? " ",
            pickupDate ?? " ",
          ),
          label: context.tt(
            pickupDate ?? "Pick up date",
            pickupDate ?? "اختر التاريخ",
          ),
          iconName: 'calendar',
        );
      },
    );
  }

  Widget _buildGoodsField(BuildContext context) {
    return BlocSelector<HomeViewController, HomeViewState, String?>(
      bloc: homeViewModel,
      selector: (state) =>
          state.selectGoodsString, // تحديد الخاصية المطلوبة فقط
      builder: (context, selectGoodsString) {
        return SelectionCard(
          onTap: () => homeViewModel.goodsOnClicked(context),
          selectedValue: context.tt(
            selectGoodsString ?? " ",
            selectGoodsString ?? " ",
          ),
          label: context.tt(
            selectGoodsString ?? "Select Goods",
            selectGoodsString ?? "اختر نوع البضائع",
          ),
          iconName: 'calendar',
        );
      },
    );
  }

  Widget _buildBookingRequest() {
    return BlocBuilder<BookingRequestViewController, BookingRequestViewState>(
      bloc: bookingRequestViewModel,
      buildWhen: (previous, current) {
        logger.debug(previous.toString());
        logger.debug(current.toString());
        return !(current is AcceptbookingRequest);
      },
      builder: (context, state) {
        logger.debug("rebuild booking Requests Cards");
        if (state is BookingRequestSuccessViewState) {
          return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            context.tt("Your Request", "طلباتك"),
                            style: TextStyle(
                              fontSize: Responsive.getResponsiveFontSize(
                                  context,
                                  fontSize: 18),
                              height: 21 /
                                  Responsive.getResponsiveFontSize(context,
                                      fontSize: 18),
                              color: AppColor.secondaryColor,
                              fontFamily: 'outfit',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            height: 22,
                            width: 22,
                            decoration: const BoxDecoration(
                                color: AppColor.secondaryColor,
                                shape: BoxShape.circle),
                            child: Center(
                              child: Text(
                                state.bookingRequests.length.toString(),
                                style: TextStyle(
                                  fontSize: Responsive.getResponsiveFontSize(
                                      context,
                                      fontSize: 14),
                                  height: 21 /
                                      Responsive.getResponsiveFontSize(context,
                                          fontSize: 14),
                                  color: Colors.white,
                                  fontFamily: 'outfit',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context)
                              .pushNamed(AllBookingRequestView.route,
                                  arguments: AllBookingRequestViewArguments(
                                    cubit: bookingRequestViewModel,
                                  ));
                        },
                        child: Text(
                          context.tt("Show more", "عرض المزيد"),
                          style: TextStyle(
                            fontSize: Responsive.getResponsiveFontSize(context,
                                fontSize: 17),
                            height: 25 /
                                Responsive.getResponsiveFontSize(context,
                                    fontSize: 17),
                            color: AppColor.blacktext,
                            fontFamily: 'outfit',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      )
                    ],
                  ),
                  const Gap(10),
                  ...state.bookingRequests.map((item) => BookingRequestCard(
                    
                        key: ValueKey(item.id),
                        bookingRequest: item,
                        shomMoreTap: () {
                          Navigator.of(context).pushNamed(
                            OffersView.route,
                            arguments: OfferViewArguments(
                                cubit: bookingRequestViewModel, id: item.id),
                          );
                        },
                        onTap: (BidViewModel) {
                          bookingRequestViewModel.acceptBidding(BidViewModel);
                        },
                      ))
                ],
              ));
        } else if (state is BookingRequesErrorViewState) {
          return const Text("Error in loading Booking request ");
        } else if (state is BookingRequestEmptyViewState) {
          return EmptyBookingView();
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildCustomButton() {
    return BlocBuilder<HomeViewController, HomeViewState>(
      bloc: homeViewModel,
      builder: (context, state) {
        return CustomButton(
          enabled: homeViewModel.enabledSumbitButton(),
          onTap: () {
            homeViewModel.createRequestlbuttonclick();
          },

          child: Text(
            context.tt("Create Booking", "انشاء حجز"),
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                height: 20.8 / 20,
                fontSize:Responsive.getResponsiveFontSize(context, fontSize: 18)),
          ),

          //TextColor: Colors.white,
          //padding: const EdgeInsets.symmetric(vertical: 15),
        );
      },
    );
  }
}

/*
  Widget _buildSuccessBooking(List<BookingRequestViewModel> bookingRequests) {
    final PageController _pageController = PageController(
      viewportFraction: 0.9, // يترك مساحة للبطاقات الأخرى
    );

    return BlocProvider(
      create: (context) => PageCubit(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          IntrinsicHeight(
            // استخدم IntrinsicHeight هنا
            child: PageView.builder(
              controller: _pageController,
              itemCount: bookingRequests.length,
              pageSnapping: true,
              onPageChanged: (index) {},
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 8),
                  child: BookingRequestCard(
                    key: ValueKey(bookingRequests[index].id),
                    cubit: con,
                    bookingRequest: bookingRequests[index], 
                    onTap: () {
                      Navigator.of(context).pushNamed(
                        OffersView.route,
                        arguments: OfferViewArguments(
                            cubit: bookingRequestViewModel,
                            id: bookingRequests[index].id),
                      );
                    },
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 16),
          SmoothPageIndicator(
            controller: _pageController,
            count: bookingRequests.length,
            effect: ExpandingDotsEffect(
              activeDotColor: Colors.blue,
              dotColor: Colors.grey,
              dotHeight: 10,
              dotWidth: 10,
              expansionFactor: 3,
            ),
          ),
        ],
      ),
    );
  }
}
*

class PageCubit extends Cubit<int> {
  PageCubit() : super(0); // Initial page index is 0

  void updatePage(int page) => emit(page); // Update current page index
}
*/