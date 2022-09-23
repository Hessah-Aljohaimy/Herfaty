import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/semantics.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart';

part 'payment_event.dart';
part 'payment_state.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  PaymentBloc() : super(const PaymentState()) {
    on<PaymentStart>(_onPaymentStart);
        on<PaymentCreateIntent>(_onPaymentCreateIntent);

    on<PaymentConfirmIntent>(_onPaymentConfirmIntent);

  }
  

  void _onPaymentStart(PaymentStart event, Emitter<PaymentState> emit) {

    emit(state.copyWith(status: PaymentStatus.initial));
  }

  void _onPaymentCreateIntent(PaymentCreateIntent event, Emitter<PaymentState> emit) async {
        emit(state.copyWith(status: PaymentStatus.loading));
        final PaymentMethod = await Stripe.instance.createPaymentMethod( 
        PaymentMethodParams.card(paymentMethodData: PaymentMethodData(billingDetails: event.billingDetails),),

        );
   final paymentIntentResult = _callPayEndpointMehodId(
    useStripeSdk:true,
    PaymentMethodId:PaymentMethod.id,
currency:'usd',
items:event.items,
   );
  }
  

 void _onPaymentConfirmIntent(PaymentConfirmIntent event, Emitter<PaymentState> emit) {}

  Future<Map<String,dynamic>> _callPayEndpointMehodId({
 required bool useStripeSdk,
 required String PaymentMethodId,
 required String currency,
 List<Map<String,dynamic>>?items,


  })  async {
final Url=Uri.parse('https://us-central1-herfaty-54792.cloudfunctions.net/StripePayEndpointMethodId');


final response = await htt


  }



}
