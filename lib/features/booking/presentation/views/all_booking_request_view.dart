import 'package:eram_express/features/booking/presentation/modals/accepet_order_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; // BlocConsumer requires this package.
import 'package:eram_express/common/custom-appbar.dart';
import 'package:eram_express/features/home/presentation/modals/successful-request-modal.dart';
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

  const AllBookingRequestView({Key? key, required this.arguments}): super(key: key);
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
                  if (state is AcceptbookingRequest)
                   {
                        const AcceptOrderModal().show(context);
                   }
                },
                builder: (context, state) {
                  if (state is BookingRequestSuccessViewState) {
                    return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24),
                        child: ListView.builder(
                          itemCount: state.bookingRequests.length,
                          itemBuilder: (context, index) {
                            return BookingRequestCard(
                              shomMoreTap:(){
                                 Navigator.of(context).pushNamed(
                                  OffersView.route,
                                  arguments: OfferViewArguments(
                                      cubit: arguments.cubit,
                                      id: state.bookingRequests[index].id),
                                );
                              } ,
                              bookingRequest: state.bookingRequests[index],
                              onTap: (BidViewModel) {
                                arguments.cubit.acceptBidding(BidViewModel);
                              },
                            );
                          },
                        ));
                  } else if (state is BookingRequesErrorViewState) {
                    return Center(child: Text("Erro"));
                  } else {
                    return EmptyBookingView();
                  }
                }),
      ),
    );
  }
}
