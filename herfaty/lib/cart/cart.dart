import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:herfaty/constants/color.dart';
import 'package:herfaty/models/cartModal.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class Cart extends StatefulWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    double total = 0;
    var items;

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
                items = cItems;
                Size size = MediaQuery.of(context).size;

                return Column(
                  children: [
                    Container(
                      height: 610,
                      child: Center(
                        child: ListView.builder(
                            itemCount: cItems.length,
                            itemBuilder: (context, index) {
                              total = (cItems[index].price *
                                      cItems[index].quantity) +
                                  total;
                              /*final httpsReference = FirebaseStorage.instance
                                  .refFromURL(cItems[index].image);
                                  httpsReference.getDownloadURL().then(url => { 
                                      targetImg.src = url; 
                                    }); */
                              print(total);
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
                                                " ${cItems[index].price.toString()}ر.س"),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                IconButton(
                                                    onPressed: () {
                                                      setState(() {
                                                        if (cItems[index]
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
                                                        } else {
                                                          //erro message no item less than 1
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
                      ),
                    ),
                    Material(
                        elevation: 0.0,
                        color: Colors.white,
                        child: Container(
                          height: 53,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(" المجموع : $total",
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    color: Color(0xFF808080),
                                    height: 2.8,
                                  )),
                              FloatingActionButton.extended(
                                elevation: 0,
                                onPressed: () {
                                  // Add your onPressed code here!
                                },
                                label: const Text('دفع'),
                                icon: const Icon(Icons.payment),
                                backgroundColor: Color(0xff5596A5),
                                extendedPadding: EdgeInsetsDirectional.all(50),
                                shape: RoundedRectangleBorder(),
                              ),
                            ],
                          ),
                        )),
                  ],
                );
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
  final user;
  user = FirebaseAuth.instance.currentUser;

  //final uid = user.uid;
  // final uid = user.getIdToken();

  return FirebaseFirestore.instance
      .collection('cart')
      //.where("customerId", isEqualTo: uid)
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
