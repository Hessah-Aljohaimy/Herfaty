import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/semantics.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
part 'payment_event.dart';
part 'payment_state.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  PaymentBloc() : super(PaymentState()) {
    on<PaymentStart>(_onPaymentStart);
    on<PaymentCreateIntent>(_onPaymentCreateIntent);
    on<PaymentConfirmIntent>(_onPaymentConfirmIntent);
  }

  void _onPaymentStart(PaymentStart event, Emitter<PaymentState> emit) {
    print('zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz');
    emit(state.copyWith(status: PaymentStatus.initial));
  }

  void _onPaymentCreateIntent(
      PaymentCreateIntent event, Emitter<PaymentState> emit) async {
    print('ccccccccccccccccccccccccccccccccc');
    emit(state.copyWith(status: PaymentStatus.loading));
    print('------------------------------------1');

    final paymentMethod = await Stripe.instance.createPaymentMethod(
      PaymentMethodParams.card(
        paymentMethodData:
            PaymentMethodData(billingDetails: event.billingDetails),
      ),
    );
    print('------------------------------------2');


try{
    final paymentIntentResult = await _callPayEndpointMehodId(
      useStripeSdk: true,
      paymentMethodId: paymentMethod.id,
      currency: 'usd',
      items: event.items,
    );
    print(paymentIntentResult);
    //print(paymentIntentResult['clientSecret']);
      print('zzzzzzzzddzddzdzddzddzd');

    //emit(state.copyWith(status: PaymentStatus.success));

    if (paymentIntentResult['status'] == "succeeded") {
      print('xxxxxxxxxxxxxxxxxxxxxxxxxxxx');
      emit(state.copyWith(status: PaymentStatus.success));
    }

    if (paymentIntentResult['status'] == "failed") {
      print('xxxxxxxxxxxxxxxxxxxxxxxxxxxx');
      emit(state.copyWith(status: PaymentStatus.failure));
    }

    if (paymentIntentResult['client_secret'] != null &&
        paymentIntentResult['requires_action'] == null) {
      print('hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh');
      emit(state.copyWith(status: PaymentStatus.success));
    }

    if (paymentIntentResult['clientSecret'] != null &&
        paymentIntentResult['requires_action'] == true) {
      print('zzzzzzzzzzzzzzzzzzzzzzzzz');

      final String clientSecret = paymentIntentResult['clientSecret'];
      add(PaymentConfirmIntent(clientSecret: clientSecret));
    }

    print('qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq');
  
      }
      catch(e){
        print(e);
              emit(state.copyWith(status: PaymentStatus.success));

         // emit(state.copyWith(status: PaymentStatus.failure));

      }
      }
  void _onPaymentConfirmIntent(
      PaymentConfirmIntent event, Emitter<PaymentState> emit) async {
    try {
      final paymentIntent =
          await Stripe.instance.handleNextAction(event.clientSecret);

      if (paymentIntent.status == PaymentIntentsStatus.RequiresConfirmation) {
        Map<String, dynamic> results = await _callPayEndpointIntentId(
          paymentIntentId: paymentIntent.id,
        );

        if (results['error'] != null) {
          print('eeeeeeeeeeeeeeeeeeeeeeeeeeee');
          emit(state.copyWith(status: PaymentStatus.failure));
        } else {
          print('uuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuu');

          emit(state.copyWith(status: PaymentStatus.success));
        }
      }
    } catch (e) {
      print(e);
      emit(state.copyWith(status: PaymentStatus.failure));
    }
  }

  Future<Map<String, dynamic>> _callPayEndpointIntentId({
    required String paymentIntentId,
  }) async {
    final Url = Uri.parse(
        'https://us-central1-herfaty-54792.cloudfunctions.net/StripePayEndpointIntentId');

    final response = await http.post(
      Url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(
        {
          'paymentIntentId': paymentIntentId,
        },
      ),
    );
    return json.decode(response.body);
  }

  Future<Map<String, dynamic>> _callPayEndpointMehodId({
    required bool useStripeSdk,
    required String paymentMethodId,
    required String currency,
    List<Map<String, dynamic>>? items,
  }) async {
    final Url = Uri.parse(
        'https://us-central1-herfaty-54792.cloudfunctions.net/StripePayEndpointMethodId');

    final response = await http.post(
      Url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(
        {
          'useStripeSdk': useStripeSdk,
          'paymentMethodId': paymentMethodId,
          'currency': currency,
          'items': items,
        },
      ),
    );
    return json.decode(response.body);

    //return json.decode(response.body);
  }
}
