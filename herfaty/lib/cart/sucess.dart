import 'package:herfaty/cart/cart.dart';
import 'package:herfaty/widgets/defaultButton.dart';
import 'package:herfaty/widgets/emptySection.dart';
import 'package:herfaty/widgets/subTitle.dart';
import 'package:flutter/material.dart';

class Success extends StatefulWidget {
  Success({Key? key}) : super(key: key);

  @override
  _SuccessState createState() => _SuccessState();
}

class _SuccessState extends State<Success> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          EmptySection(
            emptyImg: 'assets/images/success.gif',
            emptyMsg: 'عملية ناجحة',
          ),
          SubTitle(
            subTitleText: 'تمت عملية الدفع والطلب بنجاح',
          ),
          ElevatedButton(
            onPressed: () => finishOrder2(context),
            style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xff51908E),
                fixedSize: const Size(150, 50),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50))),
            child: Text("حسناً"),
          )
        ],
      ),
    );
  }

  finishOrder2(context) async {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => Cart(),
    ));
  }
}
