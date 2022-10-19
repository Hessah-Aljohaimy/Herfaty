// ignore_for_file: prefer_const_constructors
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:herfaty/constants/color.dart';
import 'package:herfaty/models/Product1.dart';
import 'package:herfaty/models/AddProductToCart.dart';

class productCard extends StatefulWidget {
  const productCard({
    Key? key,
    required this.itemIndex,
    required this.product,
    required this.press,
  }) : super(key: key);

  final int itemIndex;
  final Product1 product;
  final void Function() press;

  @override
  State<productCard> createState() => _productCardState();
}

class _productCardState extends State<productCard> {
  late bool isFavourite;

  @override
  void initState() {
    isFavourite = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    String thisCustomerId = user!.uid;
    //-----------------------------------------------------------------
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
              top: 20,
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
              bottom: 26,
              child: IconButton(
                icon: Icon(
                  Icons.favorite,
                  color: isFavourite
                      ? Colors.red
                      : Color.fromARGB(157, 158, 158, 158),
                  size: 32.0,
                ),
                onPressed: () async {
                  setState(() {
                    isFavourite = !isFavourite;
                  });
                  // اعتقد المفروض يكون من مودل برودكت ون

                  /**
                   * احتاج احتفظ باستمرار بالبرودكت اي دي عشان اقدر اضيفه واشيله من قائمة المفضلة
                  ولازم اشيك لما اعرض ال قائمة حقت المنتجات هل البرودكت في المفضلة حقت هذا الكستمر أو لا عشان القلب اللي ينعرض له يكون احمر (وبرضو لما يضغط عليه لازم ينشال من المفضلة)

                   */
                  if (isFavourite == true) {
                    final productToBeAdded =
                        FirebaseFirestore.instance.collection('wishList').doc();
                    CartAndWishListProduct item = CartAndWishListProduct(
                        name: widget.product.name,
                        detailsImage: widget.product.image,
                        docId: productToBeAdded.id,
                        productId: widget.product.id,
                        customerId: user.uid,
                        shopName: widget.product.shopName,
                        shopOwnerId: widget.product.shopOwnerId,
                        quantity: 1,
                        availableAmount: widget.product.availableAmount,
                        price: widget.product.price);
                    createWishListItem(item);
                  } else {
                    //delete the product from the wish list
                    String existedWishListDocId =
                        await getDocId(thisCustomerId, widget.product.id);
                    FirebaseFirestore.instance
                        .collection('wishList')
                        .doc('${existedWishListDocId}')
                        .delete();
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  //==========================================================================================
  Future createWishListItem(CartAndWishListProduct wishListItem) async {
    final docCartItem = FirebaseFirestore.instance
        .collection('wishList')
        .doc("${wishListItem.docId}");
    final json = wishListItem.toJson();
    await docCartItem.set(
      json,
    );
  }
}

//=======================================================================================
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
