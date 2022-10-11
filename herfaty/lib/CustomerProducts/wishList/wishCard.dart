// ignore_for_file: prefer_const_constructors
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:herfaty/constants/color.dart';
import 'package:herfaty/models/Product1.dart';
import 'package:herfaty/models/cart_wishlistModel.dart';

class wishCard extends StatefulWidget {
  const wishCard({
    Key? key,
    required this.itemIndex,
    required this.product,
    required this.press,
  }) : super(key: key);

  final int itemIndex;
  final Product1 product;
  final void Function() press;

  @override
  State<wishCard> createState() => _wishCardState();
}

class _wishCardState extends State<wishCard> {
  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    String thisCustomerId = user!.uid;
    //
    Size size =
        MediaQuery.of(context).size; //to get the width and height of the app
    return Container(
      decoration: BoxDecoration(
        //color: const Color(0xFFFAF9F6),
        color: Colors.white,
        border: Border.all(color: kPrimaryLight),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.2),
            blurRadius: 5.0,
            spreadRadius: .05,
          ), //BoxShadow
        ],
      ),
      margin: const EdgeInsets.symmetric(
        horizontal: 20.0,
        vertical: 10.0,
      ),
      height: 180,
      child: InkWell(
        onTap: widget
            .press, // يعني ان المستخدم لما يضغط على الكارد تفتح معاه صفحة جديدة
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              //(small box inside the Big box)
              padding: const EdgeInsets.only(top: 10),
              height: 180,
              decoration: BoxDecoration(
                //color: const Color(0xFFFAF9F6),
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            //*************************This part contains product photo:
            Positioned(
              top: 0,
              left: 0,
              child: Container(
                height: 180,
                width: 180,
                decoration: BoxDecoration(
                  border: Border.all(width: 0.1, color: Colors.white),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                  ),
                  //color: Color(0xFFFAF9F6),
                  color: Colors.white,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                  ),
                  child: Image.network(
                    widget.product.image,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),

            //**********************This part contains product name, price and shop name
            Positioned(
              top: 8,
              right: 20,
              child: SizedBox(
                height: 136,
                //because our image is 200, so the siz of this box = width -200
                width: size.width - 200,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    //product name===========================================================
                    Text(
                      widget.product.name,
                      style: const TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w600,
                        fontFamily: "Tajawal",
                        color: Colors.black,
                      ),
                    ),

                    //سعر المنتج  ===========================================================
                    Text(
                      ' ${widget.product.price} ريال',
                      style: const TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w400,
                        fontFamily: "Tajawal",
                        color: Colors.orange,
                      ),
                    ),
                    //اسم المتجر  ===========================================================
                    Text(
                      widget.product.shopName,
                      style: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w400,
                        fontFamily: "Tajawal",
                        color: kPrimaryLight,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            //**********************This part contains wish list icon
            Positioned(
              //top: 10,
              left: 190,
              bottom: 8,
              child: IconButton(
                //padding: EdgeInsets.only(right: 1),
                icon: const Icon(
                  Icons.favorite,
                  color: Colors.red,
                  size: 32.0,
                ),
                onPressed: () async {
                  //delete the product from the wish list
                  String existedWishListDocId =
                      await getDocId(thisCustomerId, widget.product.productId);
                  FirebaseFirestore.instance
                      .collection('wishList')
                      .doc('${existedWishListDocId}')
                      .delete();
                },
              ),
            ),
            //**********************This part contains cart  icon
            Positioned(
              //top: 10,
              left: 235,
              bottom: 8,
              child: IconButton(
                icon: const Icon(
                  Icons.shopping_cart,
                  color: Color.fromARGB(157, 158, 158, 158),
                  size: 32.0,
                ),
                onPressed: () async {},
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<String> getDocId(String thisCustomerId, String thisproductId) async {
    String DocId = "";
    print("==================this is get docId method");
    final wishListDoc = await FirebaseFirestore.instance
        .collection('wishList')
        .where("productId", isEqualTo: thisproductId)
        .where("customerId", isEqualTo: thisCustomerId)
        .get();
    if (wishListDoc.size > 0) {
      var data = wishListDoc.docs.elementAt(0).data() as Map;
      DocId = data["docId"];
      print('wish list docId is ${DocId}============================');
    }
    return DocId;
  }
}
