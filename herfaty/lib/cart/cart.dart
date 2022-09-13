import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:herfaty/constants/color.dart';
import 'package:herfaty/models/cartModal.dart';

class Cart extends StatefulWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    double total = 0;
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
              } else if (snapshot.hasData) {
                final cItems = snapshot.data!.toList();
                double inittotal = 7;

                return Center(
                  child: ListView.builder(
                      itemCount: cItems.length,
                      itemBuilder: (context, index) {
                        total = inittotal + cItems[index].price;
                        return Container(
                          margin:
                              EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
                          padding: EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                              border: Border.all(color: Color(0xFFF1F1F1))),
                          child: Row(
                            children: [
                              Image(
                                image: AssetImage(cItems[index].image),
                                height: 110.0,
                                width: 110.0,
                                fit: BoxFit.cover,
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
                                          " ${cItems[index].price.toString()}ر.س"),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  if (cItems[index].quantity >
                                                      0) {
                                                    cItems[index].quantity--;
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
                                              padding:
                                                  EdgeInsets.only(top: 22.0),
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
                                                  // Max 5
                                                  if (cItems[index].quantity <=
                                                      4) {
                                                    cItems[index].quantity++;
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
                            ],
                          ),
                        );
                      }),
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }),

        bottomNavigationBar: Material(
            elevation: 0.0,
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(" المجموع : ${total}",
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Color(0xFF808080),
                      height: 2.0,
                    )),
                FloatingActionButton.extended(
                  onPressed: () {
                    // Add your onPressed code here!
                  },
                  label: const Text('دفع'),
                  icon: const Icon(Icons.payment),
                  backgroundColor: Color(0xff5596A5),
                  extendedPadding:
                      EdgeInsetsDirectional.only(start: 50.0, end: 50.0),
                  shape: RoundedRectangleBorder(),
                ),
              ],
            )),

/*
        body: Center(
          child: ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
                  padding: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                      border: Border.all(color: Color(0xFFF1F1F1))),
                  child: Row(
                    children: [
                      Image(
                        image: AssetImage(cartItems[index].image),
                        height: 110.0,
                        width: 110.0,
                        fit: BoxFit.cover,
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(cartItems[index].name,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(fontSize: 16.0)),
                              Text("\$ ${cartItems[index].price.toString()}"),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        setState(() {
                                          if (cartItems[index].quantity > 0) {
                                            cartItems[index].quantity--;
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
                                            hintText: cartItems[index]
                                                .quantity
                                                .toString(),
                                            hintStyle: TextStyle(
                                                color: Color(0xFF303030))),
                                      )),
                                  IconButton(
                                      onPressed: () {
                                        setState(() {
                                          // Max 5
                                          if (cartItems[index].quantity <= 4) {
                                            cartItems[index].quantity++;
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
                    ],
                  ),
                );
              }),
        ),*/

        /*body: Column(
          children: const [
            //AppBarc(),
            Bodyc(),
          ],
        ),*/
      ),
    );
  }
}

/*
class AppBarc extends StatelessWidget {
  const AppBarc({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text("سلتي", style: TextStyle(color: kPrimaryColor)),
      centerTitle: true,
      backgroundColor: Colors.white,
      elevation: 0.0,
      automaticallyImplyLeading: false,
      iconTheme: IconThemeData(color: kPrimaryColor),
    );
  }
}*/

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
Stream<List<CartModal>> readCart() =>
    FirebaseFirestore.instance.collection('cart').snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => CartModal.fromJson(doc.data())).toList());
