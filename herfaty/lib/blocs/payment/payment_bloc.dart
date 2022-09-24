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
        final paymentMethod = await Stripe.instance.createPaymentMethod( 
        PaymentMethodParams.card(paymentMethodData: PaymentMethodData(billingDetails: event.billingDetails),),

        );
   final paymentIntentResult = await _callPayEndpointMehodId(
    useStripeSdk:true,
    paymentMethodId:paymentMethod.id,
currency:'sr',
items:event.items,
   );

   if(paymentIntentResult['error'] !=null ){
    print('dddddddddddddddddddddddddddddddddd');
    emit(state.copyWith(status: PaymentStatus.failure));
   }




   if(paymentIntentResult['clientSecret'] != null && 
   paymentIntentResult['requiresAction'] == null  ){
    print('hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh');
    emit(state.copyWith(status: PaymentStatus.success));
   }


   if(paymentIntentResult['clientSecret'] !=null &&
    paymentIntentResult['requiresAction'] == true  ){

final String clientSecret=paymentIntentResult['clientSecret'];
add(PaymentConfirmIntent(clientSecret: clientSecret));

   }



  }
  

 void _onPaymentConfirmIntent(PaymentConfirmIntent event, Emitter<PaymentState> emit) async {

try {
  


final paymentIntent=await Stripe.instance.handleNextAction(event.clientSecret);


if(paymentIntent.status==PaymentIntentsStatus.RequiresConfirmation){

Map<String,dynamic> results=await _callPayEndpointIntentId(paymentIntentId: paymentIntent.id,);


if(results['error']  !=null){
  emit(state.copyWith(status: PaymentStatus.failure));
} else {
  emit(state.copyWith(status: PaymentStatus.success));
}


}



} catch (e) {
  print(e);
    emit(state.copyWith(status: PaymentStatus.failure));





}


 }

 
  Future<Map<String,dynamic>> _callPayEndpointIntentId({
    required String paymentIntentId,
 


  })  async {
final Url=Uri.parse('https://us-central1-herfaty-54792.cloudfunctions.net/StripePayEndpointIntentId');

final response=await http.post(
Url,
headers: {'Content-Type':'application/json'},
body: json.encode({

'paymentIntentId':paymentIntentId,


},),);
       return json.decode(response.body);
    }

Future<Map<String,dynamic>> _callPayEndpointMehodId({
 required bool useStripeSdk,
 required String paymentMethodId,
 required String currency,
 List<Map<String,dynamic>>? items,


  })  async {
final Url=Uri.parse('https://us-central1-herfaty-54792.cloudfunctions.net/StripePayEndpointMethodId');

final response=await http.post(
Url,
headers: {'Content-Type':'application/json'},
body: json.encode({

'useStripeSdk':useStripeSdk,
'paymentMethodId':paymentMethodId,
'currency':currency,
'items':items,

},),);
       return json.decode(response.body);
    }
}
