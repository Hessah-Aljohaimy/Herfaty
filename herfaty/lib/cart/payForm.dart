import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:geocoding/geocoding.dart';
import 'package:herfaty/blocs/blocs.dart';
import 'package:herfaty/cart/cart.dart';
import 'package:herfaty/cart/sucess.dart';
import 'package:herfaty/constants/color.dart';
import 'package:herfaty/models/cartModal.dart';
import 'package:herfaty/models/orderModel.dart';

import 'package:herfaty/.env';

import '../models/shopOwnerModel.dart';
import '../widgets/defaultButton.dart';
import '../widgets/emptySection.dart';
import '../widgets/subTitle.dart';
/*
class payForm extends StatefulWidget {
  List<CartModal> Items;
  payForm({Key? key, required Items})
      : this.Items = Items,
        super(key: key);

  @override
  State<payForm> createState() => _payFormState();
}*/

//class _payFormState extends State<payForm> {

class payForm extends StatelessWidget {
  List<CartModal> Items;
  dynamic app = const DefaultAppBarPay(title: "إكمال عملية الطلب");
  String location;
  String shopName;
  num totalPrice;
  String shopOwnerId;

  payForm({
    Key? key,
    required Items,
    required location,
    required shopName,
    required totalPrice,
    required shopOwnerId,
  })  : this.Items = Items,
        this.location = location,
        this.shopName = shopName,
        this.totalPrice = totalPrice,
        this.shopOwnerId = shopOwnerId,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;

    Map<String, num> products = Map.fromIterable(Items,
        key: (e) => e.productId, value: (e) => e.quantity);

    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: app,
          body: Container(
            height: 600,
            margin: EdgeInsets.only(top: 1.0, left: 8.0, right: 8.0),
            padding: EdgeInsets.all(1.0),
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Color(0xff51908E), width: 1),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                      color: Color(0xff51908E).withOpacity(0.9),
                      offset: Offset(1, 1))
                ]),
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
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'بيانات البطاقة',
                          style: TextStyle(
                            fontSize: 23.0,
                            fontWeight: FontWeight.w600,
                            color: Color(0xff51908E),
                            fontFamily: "Tajawal",
                          ),
                        ), // Text
                        SizedBox(
                          height: 30,
                        ),
                        const SizedBox(height: 20),
                        CardFormField(
                          controller: controller,
                        ), // CardFormField
                        const SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: () {
                            app = const AppBarWithout(title: " معالجة الطلب");
                            (controller.details.complete)
                                ? context.read<PaymentBloc>().add(
                                      const PaymentCreateIntent(
                                        billingDetails: BillingDetails(
                                            email: 'auoosh2000@gmail.com'),
                                        items: [
                                          {'id': 0},
                                          {'id': 1},
                                        ],
                                      ),
                                    )
                                : ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content:
                                            Text('the form is not complete')),
                                  );
                          },
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Color(0xff51908E)),
                            padding: MaterialStateProperty.all(
                                EdgeInsets.symmetric(
                                    horizontal: 45, vertical: 13)),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(27))),
                          ),
                          child: Text(
                            "ادفع",
                            style: TextStyle(
                                fontSize: 19,
                                fontFamily: "Tajawal",
                                fontWeight: FontWeight.bold),
                          ),
                        ), // ElevatedButton
                      ],
                    ),
                  );
                }

                if (state.status == PaymentStatus.success) {
                  app = const AppBarWithout(title: " تم الطلب");
                  final orderToBeAdded =
                      FirebaseFirestore.instance.collection('orders').doc();

                  DateTime now = new DateTime.now();
                  String date = "${now.year}-${now.month}-${now.day}";

                  orderModal order = orderModal(
                      customerId: user!.uid,
                      shopOwnerId: shopOwnerId,
                      docId: orderToBeAdded.id,
                      location: location,
                      total: totalPrice,
                      shopName: shopName,
                      notification: 'notPushed',
                      status: 'New order',
                      products: products,
                      orderDate: date);

                  createNewOrder(order);
                  deletFromCart();
                  updateProducts();
                  return Container(
                    height: 400,
                    color: Colors.white,
                    child: Column(
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
                          onPressed: () async => {
                            state.status = PaymentStatus.initial,
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (context) => const Cart()),
                                ModalRoute.withName('/home_screen_customer'))

                            //context.read<PaymentBloc>().add(PaymentStart()),
                          },
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

                  /*return Column(
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
              );*/
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
                          //context.read<PaymentBloc>().add(PaymentStart());

                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => Cart(),
                          ));
                        },
                        child: const Text('try again'),
                      )
                    ],
                  );
                } else {
                  app = const AppBarWithout(title: " معالجة الطلب");
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
        )); // Column
  }

  deletFromCart() async {
    final _db = FirebaseFirestore.instance;

    for (var i = 0; i < Items.length; i++) {
      await _db.collection("cart").doc(Items[i].docId).delete();
    }
  }

  updateProducts() async {
    final _db = FirebaseFirestore.instance;

    for (var i = 0; i < Items.length; i++) {
      if (Items[i].quantity < Items[i].avalibleAmount) {
        var updaterAmount = (Items[i].avalibleAmount) - (Items[i].quantity);
        FirebaseFirestore.instance
            .collection('Products')
            .doc(Items[i].productId.trim())
            .update({"avalibleAmount": updaterAmount});
      }
    }
  }
}

Future createNewOrder(orderModal cartItem) async {
  final docCartItem =
      FirebaseFirestore.instance.collection('orders').doc("${cartItem.docId}");
  final json = cartItem.toJson();
  await docCartItem.set(
    json,
    // SetOptions(merge: true)
  );
}

class DefaultAppBarPay extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  const DefaultAppBarPay({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(56.0);
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title, style: TextStyle(color: kPrimaryColor)),
      centerTitle: true,
      backgroundColor: Colors.white,
      elevation: 0,
      automaticallyImplyLeading: false,
      iconTheme: const IconThemeData(color: kPrimaryColor),
      leading: IconButton(
        padding: EdgeInsets.only(right: 20),
        icon: const Icon(
          Icons.arrow_back, //سهم العودة
          color: Color.fromARGB(255, 26, 96, 91),
          size: 22.0,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}

class AppBarWithout extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  const AppBarWithout({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(56.0);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title, style: TextStyle(color: kPrimaryColor)),
      centerTitle: true,
      backgroundColor: Colors.white,
      elevation: 0,
      automaticallyImplyLeading: false,
    );
  }
}
