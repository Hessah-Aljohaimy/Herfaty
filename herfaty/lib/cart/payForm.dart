import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:herfaty/blocs/blocs.dart';
import 'package:herfaty/cart/cart.dart';
import 'package:herfaty/constants/color.dart';
import 'package:herfaty/models/cartModal.dart';
import 'package:herfaty/models/orderModel.dart';
import '../widgets/emptySection.dart';
import '../widgets/subTitle.dart';

class payForm extends StatefulWidget {
  List<CartModal> Items;
  List<CartModal> temp;
  dynamic app = DefaultAppBarPay(title: "الدفع");
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
    required temp,
  })  : this.temp = temp,
        this.Items = Items,
        this.location = location,
        this.shopName = shopName,
        this.totalPrice = totalPrice,
        this.shopOwnerId = shopOwnerId,
        super(key: key);

  @override
  State<payForm> createState() => _payFormState();
}

class _payFormState extends State<payForm> {
  bool checkDonePay = false;

/*
class payForm extends StatelessWidget {
  List<CartModal> Items;
  dynamic app = DefaultAppBarPay(title: "إكمال عملية الطلب");
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
        super(key: key);*/

  @override
  Widget build(BuildContext context) {
    print("class pay |||");
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    List<CartModal> pro = widget.Items;

    Map<String, num> products = Map.fromIterable(widget.Items,
        key: (e) => e.productId, value: (e) => e.quantity);

    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: widget.app,
          body: Container(
            height: double.infinity,
            decoration: BoxDecoration(
                image: DecorationImage(
              image: AssetImage('assets/images/cartBack1.png'),
              fit: BoxFit.cover,
            )),
            child: SingleChildScrollView(
              child: Container(
                height: 500,
                margin: EdgeInsets.only(top: 60.0, left: 8.0, right: 8.0),
                padding: EdgeInsets.all(1.0),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 255, 255, 255),
                  border: Border.all(color: Color(0xff51908E), width: 2),
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: BlocBuilder<PaymentBloc, PaymentState>(
                  builder: (context, state) {
                    CardFormEditController controller = CardFormEditController(
                      initialDetails: state.cardFieldInputDetails,
                    );
                    if (state.status == PaymentStatus.initial) {
                      try {
                        if (state.status != PaymentStatus.success) {
                          print("enter wrong");
                          //------------------------------------------------
                          CollectionReference reference =
                              FirebaseFirestore.instance.collection('Products');
                          reference.snapshots().listen((querySnapshot) {
                            querySnapshot.docChanges.forEach((change) async {
                              if (change.type == DocumentChangeType.modified &&
                                  state.status != PaymentStatus.success) {
                                for (var i = 0; i < querySnapshot.size; i++) {
                                  var data = querySnapshot.docs
                                      .elementAt(i)
                                      .data() as Map;

                                  String product = data["id"];

                                  for (var index = 0;
                                      index < pro.length;
                                      index++) {
                                    print(
                                        "-------------------happ in check out22222222 ${pro.length}");
                                    if (!checkDonePay) {
                                      if (product == pro[index].productId) {
                                        int updatedAvailabeAmount =
                                            data["avalibleAmount"];
                                        if (updatedAvailabeAmount !=
                                            pro[index].avalibleAmount) {
                                          print(
                                              "-------------------happ in check out2");
                                          FirebaseFirestore.instance
                                              .collection('cart')
                                              .doc(pro[index].docId)
                                              .update({
                                            "avalibleAmount":
                                                updatedAvailabeAmount
                                          });
                                          if (updatedAvailabeAmount == 0) {
                                            print(
                                                "-------------------happ in check out4");
                                            FirebaseFirestore.instance
                                                .collection('cart')
                                                .doc(pro[index].docId)
                                                .update({"quantity": 0});

                                            Navigator.of(context)
                                                .pushAndRemoveUntil(
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            Cart()),
                                                    (Route<dynamic> route) =>
                                                        false);
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                  content: Text(
                                                      'نفذت بعض المنتجات يرجى التحقق')),
                                            );
                                          } else if (updatedAvailabeAmount <
                                              pro[index].quantity) {
                                            print(
                                                "-------------------happ in check out3");

                                            if (state.status !=
                                                PaymentStatus.success) {
                                              FirebaseFirestore.instance
                                                  .collection('cart')
                                                  .doc(pro[index].docId)
                                                  .update({
                                                "quantity":
                                                    updatedAvailabeAmount
                                              });
                                              Navigator.of(context)
                                                  .pushAndRemoveUntil(
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              Cart()),
                                                      (Route<dynamic> route) =>
                                                          false);
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                const SnackBar(
                                                    content: Text(
                                                        ' قلت كميات بعض المنتجات يرجى التحقق')),
                                              );
                                            }
                                          }
                                        }
                                      }
                                    }
                                  }
                                }
                              }
                            });
                          });
                        }
                      } catch (e) {}

                      //---------------------------------------------

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
                              height: 50,
                            ),

                            CardFormField(
                              controller: controller,
                            ), // CardFormField
                            const SizedBox(height: 10),
                            ElevatedButton(
                              onPressed: () async {
                                checkDonePay = true;
                                if (controller.details.complete) {
                                  print("-----------------comp-");
                                  setState(() {
                                    pro = [];
                                  });

                                  print("--------------hero1-${pro.length}");

                                  context.read<PaymentBloc>().add(
                                        const PaymentCreateIntent(
                                          billingDetails: BillingDetails(
                                              email: 'auoosh2000@gmail.com'),
                                          items: [
                                            {'id': 0},
                                            {'id': 1},
                                          ],
                                        ),
                                      );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content:
                                            Text('اكمل تعبئه بيانات الدفع')),
                                  );
                                }
                                print("-------------------تم الدفع");
                              },
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    Color(0xff51908E)),
                                padding: MaterialStateProperty.all(
                                    EdgeInsets.symmetric(
                                        horizontal: 80, vertical: 10)),
                                shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(5))),
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
                      deletFromCart();

                      pro = [];
                      print("--------------hero2-${pro.length}");

                      updateProducts();

                      final orderToBeAdded =
                          FirebaseFirestore.instance.collection('orders').doc();

                      DateTime now = new DateTime.now();
                      String date = "${now.year}-${now.month}-${now.day}";

                      orderModal order = orderModal(
                          customerId: user!.uid,
                          shopOwnerId: widget.shopOwnerId,
                          docId: orderToBeAdded.id,
                          location: widget.location,
                          total: widget.totalPrice,
                          shopName: widget.shopName,
                          notification: 'notPushed',
                          status: 'طلب جديد',
                          products: products,
                          orderDate: date,
                          points: 10);

                      createNewOrder(order);
//print('zzzzzzzvvvevevevvevevevvevv');

                      return Container(
                        height: 500,
                        margin:
                            EdgeInsets.only(top: 60.0, left: 8.0, right: 8.0),
                        padding: EdgeInsets.all(1.0),
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
                              onPressed: () => {
                                state.status = PaymentStatus.initial,

                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                        builder: (context) => Cart()),
                                    ModalRoute.withName(
                                        '/home_screen_customer'))

                                //context.read<PaymentBloc>().add(PaymentStart()),
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xff51908E),
                                  fixedSize: const Size(150, 50),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50))),
                              child: Text(
                                "حسناً",
                                style: TextStyle(
                                    fontSize: 19,
                                    fontFamily: "Tajawal",
                                    fontWeight: FontWeight.bold),
                              ),
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
                      return Container(
                        height: 500,
                        margin:
                            EdgeInsets.only(top: 60.0, left: 8.0, right: 8.0),
                        padding: EdgeInsets.all(1.0),
                        color: Colors.white,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            EmptySection(
                              emptyImg: 'assets/icons/close.png',
                              emptyMsg: '',
                            ),
                            SubTitle(
                              subTitleText: 'فشلت عملية الدفع والطلب ',
                            ),
                            ElevatedButton(
                              onPressed: () async => {
                                state.status = PaymentStatus.initial,

                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                        builder: (context) => Cart()),
                                    ModalRoute.withName(
                                        '/home_screen_customer'))

                                //context.read<PaymentBloc>().add(PaymentStart()),
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xff51908E),
                                  fixedSize: const Size(150, 50),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50))),
                              child: Text(
                                "حسناً",
                                style: TextStyle(
                                    fontSize: 19,
                                    fontFamily: "Tajawal",
                                    fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        ),
                      );
                    } else {
                      Timer(Duration(seconds: 0), () {
                        // <-- Delay here
                        setState(() {
                          widget.app = AppBarWithout(
                              title: "الدفع"); // <-- Code run after delay
                        });
                      });
                      return const Center(child: CircularProgressIndicator());
                    }
                  },
                ),
              ),
            ),
          ),
        )); // Column
  }

  deletFromCart() async {
    print("-------------enter");
    final _db = FirebaseFirestore.instance;

    for (var i = 0; i < widget.temp.length; i++) {
      await _db.collection("cart").doc(widget.temp[i].docId).delete();
    }
    print("-------------enter1");
  }

  updateProducts() async {
    print("-------------start update");
    final _db = FirebaseFirestore.instance;

    for (var i = 0; i < widget.temp.length; i++) {
      if (widget.temp[i].quantity <= widget.temp[i].avalibleAmount) {
        var updaterAmount =
            (widget.temp[i].avalibleAmount) - (widget.temp[i].quantity);
        FirebaseFirestore.instance
            .collection('Products')
            .doc(widget.temp[i].productId.trim())
            .update({"avalibleAmount": updaterAmount});
      }
    }
    print("-------------finish update");
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
      title: Text(title,
          style: TextStyle(color: kPrimaryColor, fontFamily: "Tajawal")),
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
      title: Text(title,
          style: TextStyle(color: kPrimaryColor, fontFamily: "Tajawal")),
      centerTitle: true,
      backgroundColor: Colors.white,
      elevation: 0,
      automaticallyImplyLeading: false,
    );
  }
}
