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
    return Container(
      margin: EdgeInsets.only(top: 1.0, left: 8.0, right: 8.0),
      padding: EdgeInsets.all(1.0),
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xff51908E), width: 1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: BlocBuilder<PaymentBloc, PaymentState>(
        builder: (context, state) {
          CardFormEditController controller = CardFormEditController(
            initialDetails: state.cardFieldInputDetails,
          );
          if (state.status == PaymentStatus.initial) {
            return Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CardFormField(
                    controller: controller,
                  ), // CardFormField
                  const SizedBox(height: 10),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xff51908E),
                    ),
                    onPressed: () {
                      (controller.details.complete)
                          ? context.read<PaymentBloc>().add(
                                const PaymentCreateIntent(
                                  billingDetails: BillingDetails(
                                      email: 'auoosh2000@gmail.com'),
                                  items: [
                                    {'id': 0},
                                  ],
                                ),
                              )
                          : ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('لم تكمل تعبئة البيانات')),
                            );
                    },
                    child: const Text('دفع'),
                  ), // ElevatedButton
                ],
              ),
            );
          }

          if (state.status == PaymentStatus.success) {
            print('sssssssssssssssssssssssssssssssssss');
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('success'),
                const SizedBox(
                  height: 10,
                  width: double.infinity,
                ),
                ElevatedButton(
                  onPressed: () {
                    context.read<PaymentBloc>().add(PaymentStart());
                  },
                  child: const Text('success'),
                )
              ],
            );
          }
          if (state.status == PaymentStatus.failure) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('failure'),
                const SizedBox(
                  height: 10,
                  width: double.infinity,
                ),
                ElevatedButton(
                  onPressed: () {
                    context.read<PaymentBloc>().add(PaymentStart());
                  },
                  child: const Text('try again'),
                )
              ],
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    ); // Column
  }
}
