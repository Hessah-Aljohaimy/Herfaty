import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_place_picker/google_maps_place_picker.dart';
import 'package:herfaty/cart/checkOut.dart';
import 'package:herfaty/constants/color.dart';
import 'package:herfaty/models/cartModal.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import "package:collection/collection.dart";
import 'package:herfaty/cart/payForm.dart';
import '../pages/welcome.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';

class Cart extends StatefulWidget {
  bool sold = false;

  Cart({Key? key, sold}) : super(key: key);

  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  static final kInitialPosition = LatLng(-33.8567844, 151.213108);

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        appBar: DefaultAppBar(title: "سلتي"),
        body: Container(
          height: double.infinity,
          decoration: BoxDecoration(
              image: DecorationImage(
            image: AssetImage('assets/images/cartBack1.png'),
            fit: BoxFit.cover,
          )),
          child: StreamBuilder<List<CartModal>>(
              stream: readCart(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text("somting wrong \n ${snapshot.error}");
                } else if (!snapshot.hasData) {
                  return Text("No items on the cart yet");
                } else if (snapshot.hasData) {
                  final cItems = snapshot.data!.toList();

                  // check if available amount changed

                  for (int i = 0; i < cItems.length; i++) {
                    checkAmount(cItems[i].productId, cItems[i].docId,
                        cItems[i].avalibleAmount, cItems[i].quantity);
                  }

                  final groupedList = groupingItems(cItems);

                  Size size = MediaQuery.of(context).size;

                  //groupedList.forEach((k, v) => buildView(k, v, size));
                  List<Widget> list = <Widget>[];

                  for (var k in groupedList.keys) {
                    list.add(buildView(k, groupedList[k], size));
                  }

                  return SingleChildScrollView(
                      child: new Column(children: list));
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              }),
        ),
      ),
    );
  }

  Map<String, List<CartModal>> groupingItems(List<CartModal> cItems) {
    final groups = groupBy(cItems, (CartModal e) {
      return e.shopName; // .shopName
    });
    return groups;
  }

//test

  Column buildView(String k, cItems, size) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(right: 8.0, left: 8.0, top: 10, bottom: 8.0),

          decoration: BoxDecoration(
            color: Color.fromARGB(255, 255, 255, 255),
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(5.0), topLeft: Radius.circular(5.0)),
            border: Border.all(color: Color(0xff51908E), width: 1),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          //height: 500,
          child: Column(
            children: [
              ExpansionTile(
                initiallyExpanded: true,
                title: Text(
                  //k, //ضعي اسم المتجر ثم شيلي الكومنت
                  "متجر $k",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Color(0xff5596A5),
                      fontFamily: "Tajawal"),
                ),
                children: <Widget>[
                  Center(
                    child: Container(
                      //height: MediaQuery.of(context).size.height * 0.18,
                      child: ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: cItems.length,
                          itemBuilder: (context, index) {
                            @override
                            bool sold = false;
                            //new-----------------------------------------------

                            CollectionReference reference = FirebaseFirestore
                                .instance
                                .collection('Products');
                            reference.snapshots().listen((querySnapshot) {
                              querySnapshot.docChanges.forEach((change) {
                                if (change.type ==
                                    DocumentChangeType.modified) {
                                  for (var i = 0; i < querySnapshot.size; i++) {
                                    var data = querySnapshot.docs
                                        .elementAt(i)
                                        .data() as Map;

                                    String product = data["id"];

                                    if (product == cItems[index].productId) {
                                      print("-------------------happ");
                                      print(cItems[index].docId);
                                      int updatedAvailabeAmount =
                                          data["avalibleAmount"];
                                      if (updatedAvailabeAmount !=
                                          cItems[index].avalibleAmount) {
                                        FirebaseFirestore.instance
                                            .collection('cart')
                                            .doc(cItems[index].docId)
                                            .update({
                                          "avalibleAmount":
                                              updatedAvailabeAmount
                                        });
                                        if (updatedAvailabeAmount <
                                                cItems[index].quantity &&
                                            cItems[index].avalibleAmount != 0) {
                                          FirebaseFirestore.instance
                                              .collection('cart')
                                              .doc(cItems[index].docId)
                                              .update({
                                            "quantity": updatedAvailabeAmount
                                          });
                                          ShowDialogMethod(context,
                                              "لم يعد يتوفر من منتج ${cItems[index].name} في متجر ${cItems[index].shopName} إلا $updatedAvailabeAmount");
                                        }
                                        if (cItems[index].avalibleAmount == 0) {
                                          FirebaseFirestore.instance
                                              .collection('cart')
                                              .doc(cItems[index].docId)
                                              .update({"quantity": 0});
                                        }
                                        if (cItems[index].quantity == 0 &&
                                            updatedAvailabeAmount > 0) {
                                          FirebaseFirestore.instance
                                              .collection('cart')
                                              .doc(cItems[index].docId)
                                              .update({"quantity": 1});
                                        }
                                      }
                                    }
                                  }
                                }
                              });
                            });
                            //-------------------------------------------------------

                            return Container(
                              margin: EdgeInsets.only(
                                  top: 8.0, left: 8.0, right: 8.0),
                              padding: EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                  border: Border.all(color: Color(0xFFF1F1F1))),
                              child: Row(
                                children: [
                                  ProductImage(
                                    size: size,
                                    image: cItems[index].image,
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(cItems[index].name,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(fontSize: 16.0)),
                                          Text(
                                              " ${cItems[index].price.toString()}ريال "),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              IconButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      if (cItems[index]
                                                              .quantity ==
                                                          0) {
                                                        null;
                                                      } else if (cItems[index]
                                                              .quantity ==
                                                          1) {
                                                        ShowDialogMethod(
                                                            context,
                                                            "أقل عدد للمنتج هو واحد");
                                                      } else if (cItems[index]
                                                              .quantity >
                                                          1) {
                                                        var updaterAmount =
                                                            (cItems[index]
                                                                    .quantity) -
                                                                1;
                                                        FirebaseFirestore
                                                            .instance
                                                            .collection('cart')
                                                            .doc(cItems[index]
                                                                .docId)
                                                            .update({
                                                          "quantity":
                                                              updaterAmount
                                                        });
                                                      }
                                                    });
                                                  },
                                                  icon: Icon(
                                                    Icons.remove_circle_outline,
                                                    color: kPrimaryColor,
                                                  )),
                                              Container(
                                                  width: 44.0,
                                                  height: 44.0,
                                                  padding: EdgeInsets.only(
                                                      top: 22.0),
                                                  color: Color(0xFFF1F1F1),
                                                  child: TextField(
                                                    enabled: false,
                                                    textAlign: TextAlign.center,
                                                    decoration: InputDecoration(
                                                        border:
                                                            InputBorder.none,
                                                        hintText: cItems[index]
                                                            .quantity
                                                            .toString(),
                                                        hintStyle: TextStyle(
                                                            color: Color(
                                                                0xFF303030))),
                                                  )),
                                              IconButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      if (cItems[index]
                                                              .quantity ==
                                                          0) {
                                                        null;
                                                      } else if (cItems[index]
                                                              .quantity <
                                                          cItems[index]
                                                              .avalibleAmount) {
                                                        var updaterAmount =
                                                            (cItems[index]
                                                                    .quantity) +
                                                                1;
                                                        FirebaseFirestore
                                                            .instance
                                                            .collection('cart')
                                                            .doc(cItems[index]
                                                                .docId)
                                                            .update({
                                                          "quantity":
                                                              updaterAmount
                                                        });
                                                      } else {
                                                        ShowDialogMethod(
                                                            context,
                                                            "لا توجد كمية متاحة من المنتج أكثر من ذلك");
                                                      }
                                                    });
                                                  },
                                                  icon: Icon(
                                                    Icons.add_circle_outline,
                                                    color: kPrimaryColor,
                                                  )),
                                            ],
                                          ),
                                          if (cItems[index].quantity == 0)
                                            Center(
                                              child: Text(
                                                  "عذراَ لقد نفذ هذ المنتج",
                                                  style: TextStyle(
                                                    color: Colors.red,
                                                    fontSize: 14.0,
                                                    fontWeight: FontWeight.bold,
                                                  )),
                                            ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.white, // background
                                    ),
                                    onPressed: () {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: Text("حذف منتج"),
                                              content: Text(
                                                  'سيتم حذف هذا المنتج من سلتك'),
                                              actions: <Widget>[
                                                TextButton(
                                                  child: Text("تراجع"),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                ),
                                                TextButton(
                                                  child: Text("حذف",
                                                      style: TextStyle(
                                                        color: Colors.red,
                                                      )),
                                                  onPressed: () {
                                                    final docUser =
                                                        FirebaseFirestore
                                                            .instance
                                                            .collection('cart')
                                                            .doc(cItems[index]
                                                                .docId);
                                                    docUser.delete();

                                                    Navigator.of(context).pop();
                                                  },
                                                )
                                              ],
                                            );
                                          });
                                    },
                                    child: Row(children: [
                                      //Text('Delete'),
                                      Icon(
                                        Icons.delete,
                                        color: kPrimaryColor,
                                        semanticLabel: "Delete",
                                      )
                                    ]),
                                  ),
                                ],
                              ),
                            );
                          }),
                    ),
                  ),
                ],
              ),
              Material(
                  elevation: 1.0,
                  color: Colors.white,
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border(
                      bottom: BorderSide(color: Color(0xff51908E), width: 1),
                      top: BorderSide(color: Color(0xff51908E), width: 2),
                    )),
                    height: 45,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                            " المجموع : ${calculatTotal(cItems).toStringAsFixed(2)} ريال",
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              fontSize: 18.0,
                              color: Color(0xFF808080),
                              fontFamily: "Tajawal",
                              height: 2,
                            )),
                        SizedBox(
                          height: 50,
                          width: 150,
                          child: FloatingActionButton.extended(
                            heroTag: "btn ${Random().nextInt(500)}",
                            elevation: 2,
                            onPressed: () {
                              var list = cItems.toList();
                              for (int i = 0; i < list.length; i++)
                                if (list[i].quantity == 0) {
                                  list.removeAt(i);
                                }
                              //check out page
                              if (list.length != 0) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => checkOut(
                                          shopName: k,
                                          Items: list,
                                          totalPrice: calculatTotal(list))),
                                );
                              } else {
                                ShowDialogMethod(context, " لقد نفذت المنتجات");
                              }
                            },
                            label: Text(
                                'إتمام الطلب (${calculatItems(cItems)})',
                                style: TextStyle(
                                    fontSize: 15.0, fontFamily: "Tajawal")),
                            //icon: const Icon(Icons.payment),
                            backgroundColor: Color(0xff51908E),
                            extendedPadding: EdgeInsetsDirectional.all(50),
                            shape: RoundedRectangleBorder(),
                          ),
                        ),
                      ],
                    ),
                  )),
            ],
          ),
        ),
      ],
    );
  }

  int calculatItems(cItems) {
    var list = cItems.toList();
    for (int i = 0; i < list.length; i++)
      if (list[i].quantity == 0) {
        list.removeAt(i);
      }
    return list.length;
  }
}

class DefaultAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  const DefaultAppBar({
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
      iconTheme: IconThemeData(color: kPrimaryColor),
    );
  }
}

//Stream firestore
Stream<List<CartModal>> readCart() {
  // final uid = user.getIdToken();

  final user;
  user = FirebaseAuth.instance.currentUser;
  final uid = user.uid;
  return FirebaseFirestore.instance
      .collection('cart')
      .where("customerId", isEqualTo: uid)
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => CartModal.fromJson(doc.data())).toList());
}

class ProductImage extends StatelessWidget {
  const ProductImage({
    Key? key,
    required this.size,
    required this.image,
  }) : super(key: key);

  final Size size;
  final String image;
  @override
  Widget build(BuildContext context) {
    return Image.network(
      image,
      height: 110.0,
      width: 110.0,
      fit: BoxFit.cover,
    );
  }
}

num calculatTotal(var list) {
  num finalTotal = 0;
  for (int i = 0; i < list.length; i++) {
    finalTotal += (list[i].price * list[i].quantity);
  }
  return finalTotal;
}

Future<dynamic> ShowDialogMethod(BuildContext context, String textToBeShown) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("عفواً"),
        content: Text(textToBeShown),
        actions: <Widget>[
          TextButton(
            child: Text("حسنا"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          )
        ],
      );
    },
  );
}

Future<void> checkAmount(idP, idD, amount, quantity) async {
  var collection = FirebaseFirestore.instance.collection('Products');
  var docSnapshot = await collection.doc(idP).get();
  if (docSnapshot.exists) {
    Map<String, dynamic>? data = docSnapshot.data();
    var value = data?['avalibleAmount'];
    if (value != amount) {
      FirebaseFirestore.instance
          .collection('cart')
          .doc(idD)
          .update({"avalibleAmount": value});
      if (value < quantity && amount != 0) {
        FirebaseFirestore.instance
            .collection('cart')
            .doc(idD)
            .update({"quantity": value});
        //ShowDialogMethod(context,
        //"لم يعد يتوفر من منتج ${cItems[index].name} في متجر ${cItems[index].shopName} إلا $updatedAvailabeAmount");
      }
      if (amount == 0) {
        FirebaseFirestore.instance
            .collection('cart')
            .doc(idD)
            .update({"quantity": 0});
      }
      if (quantity == 0 && value > 0) {
        FirebaseFirestore.instance
            .collection('cart')
            .doc(idD)
            .update({"quantity": 1});
      }
    } // <-- The value you want to retrieve.
    //return value;
  }
}
