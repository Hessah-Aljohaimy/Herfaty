import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

class checkOut extends StatelessWidget {
  const checkOut({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          ' Card Form ',
          style: Theme.of(context).textTheme.headline1,
        ), // Text
        const SizedBox(height: 20),
        CardFormField(
          controller: CardFormEditController(),
        ), // CardFormField
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: () {},
          child: const Text(' Pay'),
        ), // ElevatedButton
      ],
    ); // Column
  }
}
