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
  const Cart({Key? key}) : super(key: key);

  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  static final kInitialPosition = LatLng(-33.8567844, 151.213108);

  @override
  Widget build(BuildContext context) {
    double total = 0;
    double finaltotal;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        appBar: DefaultAppBar(title: "سلتي"),

        //test

        body: StreamBuilder<List<CartModal>>(
            stream: readCart(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text("somting wrong \n ${snapshot.error}");
              } else if (!snapshot.hasData) {
                return Text("No items on the cart yet");
              } else if (snapshot.hasData) {
                final cItems = snapshot.data!.toList();

                final groupedList = groupingItems(cItems);

                Size size = MediaQuery.of(context).size;

                //groupedList.forEach((k, v) => buildView(k, v, size));
                List<Widget> list = <Widget>[];

                for (var k in groupedList.keys) {
                  list.add(buildView(k, groupedList[k], size));
                }

                return SingleChildScrollView(child: new Column(children: list));

                //return Text("data");

                //print(cItems);

                /*return Column(
                  children: [
                    Container(
                      height: 610,
                      child: Center(
                        child: ListView.builder(
                            itemCount: cItems.length,
                            itemBuilder: (context, index) {
                              /*final httpsReference = FirebaseStorage.instance
                                  .refFromURL(cItems[index].image);
                                  httpsReference.getDownloadURL().then(url => { 
                                      targetImg.src = url; 
                                    }); */

                              return Container(
                                margin: EdgeInsets.only(
                                    top: 8.0, left: 8.0, right: 8.0),
                                padding: EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                    border:
                                        Border.all(color: Color(0xFFF1F1F1))),
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
                                                style:
                                                    TextStyle(fontSize: 16.0)),
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
                                                              .collection(
                                                                  'cart')
                                                              .doc(cItems[index]
                                                                  .docId)
                                                              .update({
                                                            "quantity":
                                                                updaterAmount
                                                          });
                                                          total = (cItems[index]
                                                                      .price *
                                                                  cItems[index]
                                                                      .quantity) +
                                                              total;
                                                        }
                                                      });
                                                    },
                                                    icon: Icon(
                                                      Icons
                                                          .remove_circle_outline,
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
                                                      textAlign:
                                                          TextAlign.center,
                                                      decoration: InputDecoration(
                                                          border:
                                                              InputBorder.none,
                                                          hintText:
                                                              cItems[index]
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
                                                                .quantity <
                                                            cItems[index]
                                                                .avalibleAmount) {
                                                          var updaterAmount =
                                                              (cItems[index]
                                                                      .quantity) +
                                                                  1;
                                                          FirebaseFirestore
                                                              .instance
                                                              .collection(
                                                                  'cart')
                                                              .doc(cItems[index]
                                                                  .docId)
                                                              .update({
                                                            "quantity":
                                                                updaterAmount
                                                          });
                                                          total = (cItems[index]
                                                                      .price *
                                                                  cItems[index]
                                                                      .quantity) +
                                                              total;
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
                                                      Navigator.of(context)
                                                          .pop();
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
                                                              .collection(
                                                                  'cart')
                                                              .doc(cItems[index]
                                                                  .docId);
                                                      docUser.delete();
                                                      total = total -
                                                          (cItems[index].price *
                                                              cItems[index]
                                                                  .quantity);
                                                      Navigator.of(context)
                                                          .pop();
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
                    Material(
                        elevation: 0.0,
                        color: Colors.white,
                        child: Container(
                          height: 59,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(" المجموع : ${calculatTotal(cItems)} ريال",
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    color: Color(0xFF808080),
                                    height: 2.8,
                                  )),
                              SizedBox(
                                height: 59,
                                child: FloatingActionButton.extended(
                                  elevation: 0,
                                  onPressed: () {
                                    // Add your onPressed code here!
                                  },
                                  label: const Text('دفع',
                                      style: TextStyle(
                                        fontSize: 20.0,
                                      )),
                                  icon: const Icon(Icons.payment),
                                  backgroundColor: Color(0xff5596A5),
                                  extendedPadding:
                                      EdgeInsetsDirectional.all(50),
                                  shape: RoundedRectangleBorder(),
                                ),
                              ),
                            ],
                          ),
                        )),
                  ],
                );*/
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }),

        /*body: Column(
          children: const [
            //AppBarc(),
            Bodyc(),
          ],
        ),*/
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
          margin: EdgeInsets.only(top: 20.0),
          decoration: BoxDecoration(
            //color: Colors.white,
            border: Border.all(color: Color(0xff51908E), width: 1),
            //borderRadius: BorderRadius.circular(10),
            /*boxShadow: [
                BoxShadow(
                    color: Color(0xff51908E).withOpacity(0.9),
                    offset: Offset(1, 1))
              ]*/
          ),
          //height: 500,
          child: ExpansionTile(
            title: Text(
              //k, //ضعي اسم المتجر ثم شيلي الكومنت
              "متجر $k",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Color(0xff5596A5)),
            ),
            children: <Widget>[
              Center(
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: cItems.length,
                    itemBuilder: (context, index) {
                      /*final httpsReference = FirebaseStorage.instance
                                  .refFromURL(cItems[index].image);
                                  httpsReference.getDownloadURL().then(url => { 
                                      targetImg.src = url; 
                                    }); */

                      return Container(
                        margin:
                            EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
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
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                                if (cItems[index].quantity ==
                                                    1) {
                                                  ShowDialogMethod(context,
                                                      "أقل عدد للمنتج هو واحد");
                                                } else if (cItems[index]
                                                        .quantity >
                                                    1) {
                                                  var updaterAmount =
                                                      (cItems[index].quantity) -
                                                          1;
                                                  FirebaseFirestore.instance
                                                      .collection('cart')
                                                      .doc(cItems[index].docId)
                                                      .update({
                                                    "quantity": updaterAmount
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
                                            padding: EdgeInsets.only(top: 22.0),
                                            color: Color(0xFFF1F1F1),
                                            child: TextField(
                                              enabled: false,
                                              textAlign: TextAlign.center,
                                              decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                  hintText: cItems[index]
                                                      .quantity
                                                      .toString(),
                                                  hintStyle: TextStyle(
                                                      color:
                                                          Color(0xFF303030))),
                                            )),
                                        IconButton(
                                            onPressed: () {
                                              setState(() {
                                                if (cItems[index].quantity <
                                                    cItems[index]
                                                        .avalibleAmount) {
                                                  var updaterAmount =
                                                      (cItems[index].quantity) +
                                                          1;
                                                  FirebaseFirestore.instance
                                                      .collection('cart')
                                                      .doc(cItems[index].docId)
                                                      .update({
                                                    "quantity": updaterAmount
                                                  });
                                                } else {
                                                  ShowDialogMethod(context,
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
                                        content:
                                            Text('سيتم حذف هذا المنتج من سلتك'),
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
                                              final docUser = FirebaseFirestore
                                                  .instance
                                                  .collection('cart')
                                                  .doc(cItems[index].docId);
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
            ],
          ),
        ),
        Material(
            elevation: 0.0,
            color: Colors.white,
            child: Container(
              height: 45,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(" المجموع : ${calculatTotal(cItems)} ريال",
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Color(0xFF808080),
                        height: 2,
                      )),
                  SizedBox(
                    height: 45,
                    child: FloatingActionButton.extended(
                      heroTag: "btn ${Random().nextInt(500)}",
                      elevation: 0,
                      onPressed: () {
                        //check out page
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => checkOut(
                                  shopName: k,
                                  Items: cItems.toList(),
                                  totalPrice: calculatTotal(cItems))),
                        );

                        // pay form page
                        /*
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => payForm()
                         ) );

                         */

                        //LOCATION PAGE
                        /*Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PlacePicker(
                              apiKey:
                                  "AIzaSyAwT-rSNhTijJZ2Op4IWMddDdLF0Dcq8-o", // Put YOUR OWN KEY here.
                              onPlacePicked: (result) {
                                print("------------------------------");
                                print(result.formattedAddress);
                                print("------------------------------");
                                Navigator.of(context).pop();
                              },
                              initialPosition: kInitialPosition,
                              useCurrentLocation: true,
                            ),
                          ),
                        );*/
                      },
                      label: const Text('إتمام الطلب',
                          style: TextStyle(
                            fontSize: 18.0,
                          )),
                      icon: const Icon(Icons.payment),
                      backgroundColor: Color(0xff5596A5),
                      extendedPadding: EdgeInsetsDirectional.all(50),
                      shape: RoundedRectangleBorder(),
                    ),
                  ),
                ],
              ),
            )),
        Container(
          height: 2,
          color: Color(0xff5596A5),
        )
      ],
    );
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
      title: Text(title, style: TextStyle(color: kPrimaryColor)),
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
        title: Text("خطأ"),
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
