import 'package:eram_express/features/booking/presentation/modals/accepet_order_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eram_express/common/custom-appbar.dart';
import 'package:eram_express_shared/core/i18n/context_extension.dart';
import '../../../home/presentation/widgets/empty_booking_view.dart';
import '../widgets/booking_request_card.dart';
import 'booking_request_view_controller.dart';
import 'booking_request_view_state.dart';
import 'offers_view.dart';

class AllBookingRequestViewArguments 
{
  final BookingRequestViewController cubit;
  const AllBookingRequestViewArguments({required this.cubit});
}

class AllBookingRequestView extends StatelessWidget {
  final AllBookingRequestViewArguments arguments;

  const AllBookingRequestView({super.key, required this.arguments});
  static const String route = '/AllRequests';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: context.tt("All Requests", "كل الطلبات")),
      body: SafeArea(
        child:
            BlocConsumer<BookingRequestViewController, BookingRequestViewState>(
                bloc: arguments.cubit,
                listener: (context, state)
                {
                  if (state is AcceptBookingRequest)
                   {
                        const AcceptOrderModal().show(context);
                   }
                },
                builder: (context, state) {
                  if (state is BookingRequestSuccessViewState) {
                    return Padding(
                        padding:const EdgeInsets.symmetric(horizontal: 24),
                        child: ListView.builder(
                          itemCount: state.bookingRequests.length,
                          itemBuilder: (context, index) {
                            return BookingRequestCard(
                              showMoreTap:(){
                                 Navigator.of(context).pushNamed(
                                  OffersView.route,
                                  arguments: OfferViewArguments(
                                      cubit: arguments.cubit,
                                      id: state.bookingRequests[index].id),
                                );
                              } ,
                              bookingRequest: state.bookingRequests[index],
                              onTap: (bidViewModel) {
                                arguments.cubit.acceptBidding(bidViewModel);
                              },
                            );
                          },
                        ));
                  } else if (state is BookingRequestErrorViewState) {
                    return const Center(child: Text("error"));
                  } else {
                    return EmptyBookingView();
                  }
                }),
      ),
    );
  }
}
