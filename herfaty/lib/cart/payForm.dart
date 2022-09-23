import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:herfaty/blocs/blocs.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class payForm extends StatefulWidget {
  const payForm({super.key});

  @override
  State<payForm> createState() => _payFormState();
}

class _payFormState extends State<payForm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('paaaaaaaay')),
      body: BlocBuilder<PaymentBloc, PaymentState>(
        builder: (context, state) {
 CardFormEditController   controller= CardFormEditController(

initialDetails: state.cardFieldInputDetails,

 );
if(state.status == PaymentStatus.initial){

          return Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  ' Card Form ',
                  style: Theme.of(context).textTheme.headline1,
                ), // Text
                const SizedBox(height: 20),
                CardFormField(
                  controller:controller,
                ), // CardFormField
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                          
                          (controller.details.complete)?
                          context.read<PaymentBloc>().add(
const PaymentCreateIntent(
  billingDetails:  BillingDetails(email:'auoosh2000@gmail.com'),


 items: [
  {'id':0},

  ],),


                          ):
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: 
                            Text('the form is not complete')
                            ),


                          );


                  },
                  child: const Text(' Pay'),
                ), // ElevatedButton
              ],
            ),
          ); }


if(state.status==PaymentStatus.success){
print('sssssssssssssssssssssssssssssssssss');
return Column(
  
  mainAxisAlignment: MainAxisAlignment.center,
children: [

const Text('success'),
const SizedBox(height: 10,
width: double.infinity,),


ElevatedButton(
  onPressed: (){

    context.read<PaymentBloc>().add(PaymentStart());
  }


, child:const Text('success'),)

],

      );




}
if(state.status==PaymentStatus.failure){


  return Column(
  mainAxisAlignment: MainAxisAlignment.center,
children: [

const Text('failure'),
const SizedBox(height: 10,
width: double.infinity,),


ElevatedButton(
  onPressed: (){

    context.read<PaymentBloc>().add(PaymentStart());
  }


, child:const Text('try again'),)

],

      );


}


          else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    ); // Column
  }
}
