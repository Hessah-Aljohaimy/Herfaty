// ignore_for_file: prefer_const_constructors
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:herfaty/constants/color.dart';
import 'package:herfaty/models/Product1.dart';
import 'package:herfaty/models/cart_wishlistModel.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
  late FToast fToast;

  bool isFavourite = false;
  bool isAvailable = true;

  @override
  void initState() {
    fToast = FToast();
    fToast.init(context);
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    String thisCustomerId = user!.uid;
    setIsFavourite(thisCustomerId, widget.product.productId);
    if (widget.product.availableAmount == 0) {
      isAvailable = false;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    String thisCustomerId = user!.uid;
    //-----------------------------------------------------------------
    //===============================================Listen To AvailableAmount Changes From DB
    CollectionReference reference =
        FirebaseFirestore.instance.collection('Products');
    reference.snapshots().listen((querySnapshot) {
      querySnapshot.docChanges.forEach((change) async {
        if (change.type == DocumentChangeType.modified &&
            change.doc.id == widget.product.productId) {
          var data =
              querySnapshot.docs.elementAt(change.newIndex).data() as Map;
          String updatedDescription = data["dsscription"];
          int updatedAvailabeAmount = data["avalibleAmount"];
          num updatedPrice = data["price"];
          String updatedImage = data["image"];
          String updatedName = data["name"];
          //update
          String existedWishListDocId =
              await getWishListDocId(thisCustomerId, widget.product.productId);
          FirebaseFirestore.instance
              .collection('wishList')
              .doc('${existedWishListDocId}')
              .update({
            "description": updatedDescription,
            "avalibleAmount": updatedAvailabeAmount,
            "price": updatedPrice,
            "image": updatedImage,
            "name": updatedName
          });
          if (mounted) {
            setState(
              () {
                widget.product.availableAmount = updatedAvailabeAmount;
                widget.product.name = updatedName;
                widget.product.description = updatedDescription;
                widget.product.price = updatedPrice;
                widget.product.image = updatedImage;

                if (updatedAvailabeAmount == 0) {
                  setState(() {
                    isAvailable = false;
                  });
                } else if (updatedAvailabeAmount != 0) {
                  setState(() {
                    isAvailable = true;
                  });
                }
              },
            );
          }
        } else if (change.type == DocumentChangeType.removed) {
          //delete the product from the wish list, because it is no longer exists in the products list
          if (change.doc.id == widget.product.productId) {
            print(
                "Product with id ${widget.product.productId} has been deleted");

            String existedWishListDocId = await getWishListDocId(
                thisCustomerId, widget.product.productId);
            FirebaseFirestore.instance
                .collection('wishList')
                .doc('${existedWishListDocId}')
                .delete();

            // showToastMethod(
            //     context, "عذرًا، تم حذف بعض المنتجات من قبل المالك");
          }
        }
        // //remove toast after one second because sometimes it runs into an infinite loop
        // await Future.delayed(const Duration(seconds: 1), () {
        //   Fluttertoast.cancel();
        //   fToast.removeCustomToast();
        //   fToast.removeQueuedCustomToasts();
        // });
      });
    });
    //===================================================================================

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
                      ? Color.fromARGB(255, 206, 14, 0)
                      : Color.fromARGB(157, 158, 158, 158),
                  size: 32.0,
                ),
                onPressed: () async {
                  if (isFavourite == false) {
                    //المنتج غير موجود مسبقًا في قائمة المفضلة
                    final productToBeAdded =
                        FirebaseFirestore.instance.collection('wishList').doc();
                    cart_wishlistModel item = cart_wishlistModel(
                        name: widget.product.name,
                        detailsImage: widget.product.image,
                        docId: productToBeAdded.id,
                        productId: widget.product.productId,
                        customerId: user.uid,
                        description: widget.product.description,
                        shopName: widget.product.shopName,
                        shopOwnerId: widget.product.shopOwnerId,
                        quantity: 1,
                        availableAmount: widget.product.availableAmount,
                        price: widget.product.price);
                    createWishListItem(item);
                    setState(() {
                      isFavourite = !isFavourite;
                    });
                  } else {
                    //change state only if the card is called from productsList (because changing state in the wishList causes an error of changing the next card state also!, maybe because of the deletion of the item....)
                    //if the customer id is empty this means the card is called from productsList
                    if (widget.product.customerId == "") {
                      setState(() {
                        isFavourite = !isFavourite;
                      });
                    }
                    //delete the product from the wish list
                    String existedWishListDocId = await getWishListDocId(
                        thisCustomerId, widget.product.productId);
                    FirebaseFirestore.instance
                        .collection('wishList')
                        .doc('${existedWishListDocId}')
                        .delete();
                  }
                },
              ),
            ),
            //**********************This part if the available amount is zero
            Positioned(
                //top: 10,
                //left: 235,
                right: 60,
                bottom: 6,
                child: isAvailable
                    ? Text("")
                    : Container(
                        padding: EdgeInsets.only(top: 25),
                        child: Center(
                          child: Text(
                            '*غير متوفر',
                            style: const TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.w600,
                              //fontFamily: "Tajawal",
                              color: Colors.red,
                            ),
                          ),
                        ),
                      )),
          ],
        ),
      ),
    );
  }

  //==========================================================================================
  Future createWishListItem(cart_wishlistModel wishListItem) async {
    final docCartItem = FirebaseFirestore.instance
        .collection('wishList')
        .doc("${wishListItem.docId}");
    final json = wishListItem.toJson();
    await docCartItem.set(
      json,
    );
  }

  //==========================================================================================
  Future<void> setIsFavourite(
      String thisCustomerId, String thisproductId) async {
    String existedDocId = await getWishListDocId(thisCustomerId, thisproductId);
    if (existedDocId != "") {
      setState(() {
        isFavourite = true;
      });
    } else {
      setState(() {
        isFavourite = false;
      });
    }
  }

  //=======================================================================================
  Future<String> getWishListDocId(
      String thisCustomerId, String thisproductId) async {
    String DocId = "";
    final wishListDoc = await FirebaseFirestore.instance
        .collection('wishList')
        .where("productId", isEqualTo: thisproductId)
        .where("customerId", isEqualTo: thisCustomerId)
        .get();
    if (wishListDoc.size > 0) {
      var data = wishListDoc.docs.elementAt(0).data() as Map;
      DocId = data["docId"];
      print(
          '===product with id${thisproductId}is in the wishList with docId ${DocId}');
    }
    return DocId;
  }

//=============================================================================================
///////////////////////////////////////////////////////////////////////////////
  Future<void> showToastMethod(
      BuildContext context, String textToBeShown) async {
    Fluttertoast.showToast(
      msg: textToBeShown,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 3,
      backgroundColor: Color.fromARGB(255, 26, 96, 91),
      textColor: Colors.white,
      fontSize: 18.0,
    );
  }
}
