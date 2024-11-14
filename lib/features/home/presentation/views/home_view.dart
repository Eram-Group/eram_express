import 'package:eram_express/core/app_colors.dart';
import 'package:eram_express/features/booking/domain/usecases/accept_bidding_usecase.dart';
import 'package:eram_express/features/booking/domain/usecases/create_booking_request_usecase.dart';
import 'package:eram_express/features/booking/domain/usecases/get_biddings_usecase.dart';
import 'package:eram_express_shared/core/i18n/context_extension.dart';
import 'package:eram_express_shared/core/utils/logger.dart';
import 'package:eram_express_shared/core/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import '../../../../app/di.dart';
import '../../../Common/presentation/widgets/SvgIcon.dart';
import '../../../Common/presentation/widgets/customButton.dart';

import '../../../booking/domain/usecases/get_booking_request_usecase.dart';
import '../../../booking/presentation/temp_offers_view.dart';
import '../../../booking/presentation/views/booking_request_view_controller.dart';
import '../../../booking/presentation/views/booking_request_view_state.dart';
import '../../../booking/presentation/widgets/booking_request_card.dart';
import 'ShippingFormCubit.dart';
import 'ShippingFormState.dart';

class HomeView extends StatelessWidget {
  static const String route = '/home';
  final HomeViewController viewModel = HomeViewController(
      homerepo: HomeRepository,
      createBookingRequestUsecase:
          CreateBookingRequestUsecase(bookingRepository: bookingRepository));

  final BookingRequestViewController bookingRequestViewModel =
      BookingRequestViewController(
          bookingRepository: bookingRepository,
          acceptBiddingUsecase:
              AcceptBiddingUsecase(bookingRepository: bookingRepository),
          //getBiddingsUsecase:GetBiddingsUsecase(bookingRepository: bookingRepository),
          getBookingRequestUsecase:
              GetBookingRequestUsecase(bookingRepository: bookingRepository));

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
                  bloc: viewModel,
                  listener: (context, state) {
                    if (state is RequestCreateSuccess) {
                      logger.debug(state.runtimeType.toString());
                      bookingRequestViewModel.listBookingRequest();
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
    logger.debug("rebuilddddddd");
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 130)
          .copyWith(bottom: 0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Color(0x1C000000), // Hex value for #0000001C
                offset: Offset(0, 4), // Equivalent to "0px 4px"
                blurRadius: 24, // Equivalent to "24px"
                spreadRadius: 0, // Equivalent to "0px"
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
                const Gap(8),
                CustomButton(
                  onPressed: () {
                    viewModel.createRequestlbuttonclick();
                  },
                  text: "Check Rates",
                  backgroundColor: AppColor.primaryColor,
                  TextColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),
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
          child: BlocBuilder<HomeViewController, HomeViewState>(
            bloc: viewModel,
            builder: (context, state) {
              return _buildSelected(
                onTap: () => viewModel.PickClicked(context),
                selectedValue: state.pickup?.address ?? " ",
                context: context,
                label: state.pickup?.address ?? "Pick up",
                iconName: 'Pick_Up',
                filled: state.filled
                    ? state.pickup?.address == null
                        ? true
                        : false
                    : state.filled,
              );
            },
          ),
        ),
        const Gap(7),
        Expanded(
          child: BlocBuilder<HomeViewController, HomeViewState>(
            bloc: viewModel,
            builder: (context, state) {
              return _buildSelected(
                onTap: () => viewModel.destinationClicked(context),
                context: context,
                selectedValue: state.destination?.address ?? " ",
                label: state.destination?.address ?? "Destination",
                iconName: 'destination',
                filled: state.filled
                    ? state.destination?.address == null
                        ? true
                        : false
                    : state.filled,
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildLoadTypeField(BuildContext context) {
    return BlocBuilder<HomeViewController, HomeViewState>(
      bloc: viewModel,
      builder: (context, state) {
        return _buildSelected(
          onTap: () => viewModel.cargoCategoryOnClicked(context),
          selectedValue: context.tt(
              state.loadType?.nameEn ?? " ", state.loadType?.nameAr ?? " "),
          context: context,
          label: context.tt(state.loadType?.nameEn ?? "Select the load type",
              state.loadType?.nameAr ?? "اختر نوع الحمولة"),
          iconName: 'arrow-down',
          filled: state.filled
              ? context.tt(state.loadType?.nameEn ?? " ",
                          state.loadType?.nameAr ?? " ") ==
                      " "
                  ? true
                  : false
              : state.filled,
        );
      },
    );
  }

  Widget _buildTruckSizeField(BuildContext context) {
    return BlocBuilder<HomeViewController, HomeViewState>(
      bloc: viewModel,
      builder: (context, state) {
        return _buildSelected(
          onTap: () => viewModel.cargosubCategoryOnClicked(context),
          context: context,
          selectedValue: context.tt(
              state.truckSize?.nameEn ?? " ", state.truckSize?.nameAr ?? " "),
          label: context.tt(
              state.truckSize?.nameEn ?? "Choose the size of the truck",
              state.truckSize?.nameAr ?? "اختر حجم حمولتك"),
          iconName: 'sizeTrack',
          filled: state.filled
              ? context.tt(state.loadType?.nameEn ?? " ",
                          state.loadType?.nameAr ?? " ") ==
                      " "
                  ? true
                  : false
              : state.filled,
        );
      },
    );
  }

  Widget _buildDateField(BuildContext context) {
    return BlocBuilder<HomeViewController, HomeViewState>(
      bloc: viewModel,
      builder: (context, state) {
        return _buildSelected(
          onTap: () => viewModel.PickdateOnClicked(context),
          context: context,
          selectedValue: context.tt(
            state.pickupDate ?? " ",
            state.pickupDate ?? " ",
          ),
          label: context.tt(
            state.pickupDate ?? "pick up date",
            state.pickupDate ?? "اختر التاريخ",
          ),
          iconName: 'calendar',
          filled: state.filled
              ? context.tt(
                        state.pickupDate ?? " ",
                        state.pickupDate ?? " ",
                      ) ==
                      " "
                  ? true
                  : false
              : state.filled,
        );
      },
    );
  }

  Widget _buildGoodsField(BuildContext context) {
    return BlocBuilder<HomeViewController, HomeViewState>(
      bloc: viewModel,
      builder: (context, state) {
        return _buildSelected(
          onTap: () => viewModel.GoodsOnClicked(context),
          context: context,
          selectedValue: context.tt(
            state.selectGoodsString ?? " ",
            state.selectGoodsString ?? " ",
          ),
          label: context.tt(
            state.selectGoodsString ?? "Select Goods",
            state.selectGoodsString ?? "اختر نوع البضائع",
          ),
          iconName: 'calendar',
          filled: state.filled
              ? context.tt(
                        state.pickupDate ?? " ",
                        state.pickupDate ?? " ",
                      ) ==
                      " "
                  ? true
                  : false
              : state.filled,
        );
      },
    );
  }

  Widget _buildSelected({
    required Future<void> Function() onTap,
    required BuildContext context,
    required String label,
    required String iconName,
    required String? selectedValue,
    required bool filled,
  }) {
    Color textColor = selectedValue != null && selectedValue != " "
        ? Colors.black
        : AppColor.ligthText;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
              onTap: () async {
                await onTap();
              },
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: filled ? Colors.red : AppColor.bordercolor,
                    )),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          label,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: textColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            height: 25.2 / 20,
                          ),
                        ),
                      ),
                      SvgIcon(
                        asset: iconName,
                        size: 20,
                      ),
                    ],
                  ),
                ),
              )),
          filled
              ? Text(context.tt(
                  " * this field required",
                  "الخانة مطلوبة",
                ))
              : const SizedBox.shrink()
        ],
      ),
    );
  }

  Widget _buildBookingRequest() {
    return BlocBuilder<BookingRequestViewController, BookingRequestViewState>(
      bloc: bookingRequestViewModel,
      buildWhen: (previous, current) {
        // إضافة print للتأكد من أن buildWhen يتم استدعاؤه
        print("BuildWhen called");
        print("Previous: $previous");
        print("Current: $current");
        return previous != current;
      },
      builder: (context, state) {
      logger.debug("rebuild bokkkkkkkk");
        if (state is BookingRequestViewSuccessState) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: state.bookingRequests
                  .map((item) => BookingRequestCard(
                        bookingRequest: item,
                        onTap: () {
                          /*
                          bookingRequestViewModel.setbiddingState(
                              item.bids, context);
                              */
                          Navigator.of(context).pushNamed(OffersView.route,
                              arguments: OfferViewArguments(bids: item.bids ,cubit: bookingRequestViewModel ));
                        },
                      ))
                  .toList(),
            ),
          );
        } else if (state is BookingRequestViewErrorState) {
          return Text("Error in loading");
        }
        return SizedBox.shrink();
      },
    );
  }
}
