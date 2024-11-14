import 'package:eram_express/core/app_colors.dart';
import 'package:eram_express/features/booking/domain/usecases/accept_bidding_usecase.dart';
import 'package:eram_express/features/booking/domain/usecases/create_booking_request_usecase.dart';
import 'package:eram_express_shared/core/i18n/context_extension.dart';
import 'package:eram_express_shared/core/utils/logger.dart';
import 'package:eram_express_shared/core/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import '../../../../app/di.dart';
import '../../../Common/presentation/widgets/customButton.dart';
import '../../../booking/domain/usecases/get_booking_request_usecase.dart';
import '../../../booking/presentation/views/offers_view.dart';
import '../../../booking/presentation/views/booking_request_view_controller.dart';
import '../../../booking/presentation/views/booking_request_view_state.dart';
import '../../../booking/presentation/widgets/booking_request_card.dart';
import '../widgets/selection-card.dart';
import 'home_view_controller.dart';
import 'home_view_state.dart';

class HomeView extends StatelessWidget {
  static const String route = '/home';
  final HomeViewController homeViewModel = HomeViewController(
      homerepo: HomeRepository,
      createBookingRequestUsecase:
          CreateBookingRequestUsecase(bookingRepository: bookingRepository));

  final BookingRequestViewController bookingRequestViewModel =BookingRequestViewController(
          bookingRepository: bookingRepository,
          acceptBiddingUsecase:AcceptBiddingUsecase(bookingRepository: bookingRepository),
          getBookingRequestUsecase:GetBookingRequestUsecase(bookingRepository: bookingRepository));

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
                    if (state is RequestCreateSuccess) 
                    {
                      bookingRequestViewModel.listBookingRequest();
                    }
                    if( state is RequestCreateError)
                    {
                        
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
                    homeViewModel.createRequestlbuttonclick();
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
            bloc: homeViewModel,
            builder: (context, state) {
              return SelectionCard(
                onTap: () => homeViewModel.PickClicked(context),
                selectedValue: state.pickup?.address ?? " ",
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
            bloc: homeViewModel,
            builder: (context, state) {
              return SelectionCard(
                onTap: () => homeViewModel.destinationClicked(context),
            
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
      bloc: homeViewModel,
      builder: (context, state) {
        return SelectionCard(
          onTap: () => homeViewModel.cargoCategoryOnClicked(context),
          selectedValue: context.tt(
              state.loadType?.nameEn ?? " ", state.loadType?.nameAr ?? " "),
        
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
      bloc: homeViewModel,
      builder: (context, state) {
        return SelectionCard(
          onTap: () => homeViewModel.cargosubCategoryOnClicked(context),
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
      bloc: homeViewModel,
      builder: (context, state) {
        return SelectionCard(
          onTap: () => homeViewModel.PickdateOnClicked(context),
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
      bloc: homeViewModel,
      builder: (context, state) {
        return SelectionCard(
          onTap: () => homeViewModel.GoodsOnClicked(context),
          
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

  Widget _buildBookingRequest() {
    return BlocBuilder<BookingRequestViewController, BookingRequestViewState>(
      bloc: bookingRequestViewModel,
      buildWhen: (previous, current) {
        return !(current is AcceptbookingRequest);  //build any state else  this state
      },
      builder: (context, state) {
        if (state is BookingRequestSuccessViewState) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: state.bookingRequests
                  .map((item) => BookingRequestCard(
                        bookingRequest: item,
                        onTap: () {
                          Navigator.of(context).pushNamed(OffersView.route,
                              arguments: OfferViewArguments(
                                  cubit: bookingRequestViewModel, id: item.id));
                        },
                      ))
                  .toList(),
            ),
          );
        } else if (state is BookingRequesErrorViewState) {
          return const  Text("Error in loading Booking request ");
        }
        return const SizedBox.shrink();
      },
    );
  }
}
