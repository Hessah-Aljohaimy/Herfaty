// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:herfaty/models/AddProductToCart.dart';
import 'package:herfaty/models/Product1.dart';
import 'package:herfaty/constants/color.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:herfaty/widgets/ExpandedWidget.dart';

class CustomerProdectDetails extends StatefulWidget {
  final Product1 product;
  String detailsImage;

  CustomerProdectDetails(
      {super.key, required this.product, required this.detailsImage});

  @override
  State<CustomerProdectDetails> createState() => _CustomerProdectDetailsState();
}

class _CustomerProdectDetailsState extends State<CustomerProdectDetails> {
  int thisPageQuantity = 1;
  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    String thisCustomerId = user!.uid;
    //////////////////////////////////////////////////////////////////////////////////////////
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: productDetailsAppBar(context),
      //..............................................................................................................
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            height: size.height,
            child: Column(
              //crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  //to make the container covers the full width of the screen
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20 * 1.5,
                  ),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(50),
                      bottomRight: Radius.circular(50),
                    ),
                  ),
                  //==child of the container
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // image=====================================================================
                      Center(
                        child: ProductImage(
                          size: size,
                          image: widget.detailsImage,
                        ),
                      ),
                      Column(
                        //For Column:
                        // mainAxisAlignment = Vertical Axis
                        // crossAxisAlignment = Horizontal Axis
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Text(
                              widget.product.name,
                              style: const TextStyle(
                                fontSize: 26.0,
                                fontWeight: FontWeight.w500,
                                fontFamily: "Tajawal",
                                color: Color.fromARGB(255, 0, 0, 0),
                              ),
                            ),
                          ),
                          // price======================================================================
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                ' ${thisPageQuantity * widget.product.price} ريال',
                                style: const TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "Tajawal",
                                  color: Colors.orange,
                                ),
                              ),
                              Text(
                                ' الكمية: ${widget.product.quantity} / ${thisPageQuantity} ',
                                style: const TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: "Tajawal",
                                  color: Color.fromARGB(255, 86, 86, 86),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      //this sizebox is to add a space after the price
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
                //product description======================================================================
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 30,
                  ),
                  child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: ExpandedWidget(
                        text: widget.product.description,
                      )),
                ),
                // const Spacer(),
                //(أضافة إلى السلة)============================================================//
                //////////////////////////////////////////////////////////////////////////////////
                /////=============================================================================
                //////////////////////////////////////////////////////////////////////////////////
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ////////////////////////////////////////////////////////////////////////////////
                    ///
                    Row(
                      //mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.remove_circle_outline,
                            color: Colors.white,
                            size: 26,
                          ),
                          onPressed: () {
                            setState(
                              () {
                                if (thisPageQuantity > 1) {
                                  thisPageQuantity = thisPageQuantity - 1;
                                } else {
                                  ShowDialogMethod(
                                      context, "أقل عدد للمنتج هو واحد");
                                }
                              },
                            );
                          },
                        ),
                        Container(
                          width: 28.0,
                          height: 47.0,
                          padding: EdgeInsets.only(top: 22.0),
                          color: kPrimaryColor,
                          child: TextField(
                            enabled: false,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: '${thisPageQuantity}',
                                hintStyle: const TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 24,
                                    color: Color.fromARGB(255, 255, 255, 255))),
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.add_circle_outline,
                            color: Colors.white,
                            size: 26,
                          ),
                          onPressed: () async {
                            //get the existed quantity of the item if it is already exists in the cart
                            int existedQuantity =
                                await getQuantity(thisCustomerId);
                            setState(
                              () {
                                /*if existed quantity is not zero, المنتج موجود سابقًا*/
                                if (existedQuantity != 0) {
                                  int totalQuantity =
                                      thisPageQuantity + existedQuantity;
                                  //-----------------------------------
                                  if (totalQuantity < widget.product.quantity) {
                                    thisPageQuantity = thisPageQuantity + 1;
                                  } else {
                                    ShowDialogMethod(context,
                                        "توجد كمية مضافة مسبقًا من هذا المنتج في السلة! لا توجد كمية متاحة أكثر من ذلك");
                                  }
                                }

                                //==================================================
                                //else: item does not exists in the cart
                                else {
                                  if (thisPageQuantity <
                                      widget.product.quantity) {
                                    thisPageQuantity = thisPageQuantity + 1;
                                  } else {
                                    ShowDialogMethod(context,
                                        "لا توجد كمية متاحة من المنتج أكثر من ذلك");
                                  }
                                }
                              },
                            );
                          },
                        ),
                      ],
                    ),
                    Container(
                      //margin: EdgeInsets.only(top: 20.0),
                      // زر اللإضافة للسلة-----------------------------------------
                      child: ElevatedButton(
                        onPressed: () async {
                          //get the existed quantity of the item if it is already exists in the cart
                          int existedQuantity =
                              await getQuantity(thisCustomerId);

                          /*if existed quantity is not zero, this means the document already exists in the cart,
                          and I need only to update its quantity. المنتج موجود سابقًا*/
                          if (existedQuantity != 0) {
                            int totalQuantity =
                                thisPageQuantity + existedQuantity;
                            print(
                                "==========Add button says: item exists in the cart");
                            if (totalQuantity <= widget.product.quantity) {
                              //get the docId of the existed item, so that its quantity can be updated
                              String existedDocId =
                                  await getDocId(thisCustomerId);
                              FirebaseFirestore.instance
                                  .collection('cart')
                                  .doc('${existedDocId}')
                                  .update({
                                "quantity": thisPageQuantity + existedQuantity
                              });
                              await showDoneToast(context);
                            } else {
                              ShowDialogMethod(context,
                                  "توجد كمية مضافة مسبقًا من هذا المنتج في السلة! لا توجد كمية متاحة أكثر من ذلك");
                            }
                          } else {
                            final productToBeAdded = FirebaseFirestore.instance
                                .collection('cart')
                                .doc();
                            AddProductToCart item = AddProductToCart(
                                name: widget.product.name,
                                detailsImage: widget.detailsImage,
                                docId: productToBeAdded.id,
                                productId: widget.product.id,
                                customerId: user.uid,
                                shopName: widget.product.shopName,
                                shopOwnerId: widget.product.shopOwnerId,
                                quantity: existedQuantity + thisPageQuantity,
                                //quantity: updatedQuantity,
                                availableAmount: widget.product.quantity,
                                price: widget.product.price);
                            createCartItem(item);
                            await showDoneToast(context);
                          }

                          /*
                          item.availableAmount = item.availableAmount - 1;
                          String idToBeUpdated = item.productId;
                          //update available amount of the product in the product collection
                          final updateAvailableAmount = FirebaseFirestore
                              .instance
                              .collection('Products')
                              .doc("${idToBeUpdated}");
                          updateAvailableAmount.update({'avalibleAmount': 20});*/
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          padding: const EdgeInsets.only(
                            right: 26,
                            left: 26,
                            top: 10,
                            bottom: 5,
                          ),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25.0)),
                        ),
                        child: const Text(
                          'أضف إلى السلة',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontFamily: "Tajawal",
                            fontWeight: FontWeight.w900,
                            color: kPrimaryColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Future updateProductAvailableAmount(AddProductToCart cartItem) async {
  //   final docCartItem = FirebaseFirestore.instance
  //       .collection('Products')
  //       .doc("${cartItem.productId}")
  //       .update({'avalibleAmount': cartItem.availableAmount});
  // }
//==========================================================================================
  Future createCartItem(AddProductToCart cartItem) async {
    final docCartItem =
        FirebaseFirestore.instance.collection('cart').doc("${cartItem.docId}");
    final json = cartItem.toJson();
    await docCartItem.set(
      json,
      // SetOptions(merge: true)
    );
  }

//========================================================================================
  Future<int> getQuantity(String thisCustomerId) async {
    int existedQuantity = 0;
    print("==================this is get quantity method");
    final cartDoc = await FirebaseFirestore.instance
        .collection('cart')
        .where("productId", isEqualTo: widget.product.id)
        .where("customerId", isEqualTo: thisCustomerId)
        .get();
    if (cartDoc.size > 0) {
      var data = cartDoc.docs.elementAt(0).data() as Map;
      existedQuantity = data["quantity"];
      print(
          'Existed quantity is ${existedQuantity}============================');
    }

    return existedQuantity;
  }

//=======================================================================================
  Future<String> getDocId(String thisCustomerId) async {
    String existedDocId = "";
    print("==================this is get docId method");
    final cartDoc = await FirebaseFirestore.instance
        .collection('cart')
        .where("productId", isEqualTo: widget.product.id)
        .where("customerId", isEqualTo: thisCustomerId)
        .get();
    if (cartDoc.size > 0) {
      var data = cartDoc.docs.elementAt(0).data() as Map;
      existedDocId = data["docId"];
      print('Existed docId is ${existedDocId}============================');
    }
    return existedDocId;
  }

  //===============================================================================
///////////////////////////////////////////////////////////////////////////////////
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

///////////////////////////////////////////////////////////////////////////////
  Future<void> showDoneToast(BuildContext context) async {
    Fluttertoast.showToast(
      msg: "تمت إضافة المنتج للسلة بنجاح",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 3,
      backgroundColor: Color.fromARGB(255, 26, 96, 91),
      textColor: Colors.white,
      fontSize: 18.0,
    );
    await Future.delayed(const Duration(seconds: 1), () {
      Navigator.pop(context);
    });
  }

/////////////////////////////////////////////////////////////////////////////
  AppBar productDetailsAppBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      leading: IconButton(
        padding: const EdgeInsets.only(right: 20),
        icon: const Icon(
          Icons.arrow_back, //سهم العودة
          color: Color.fromARGB(255, 26, 96, 91),
          size: 22.0,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      centerTitle: false,
      title: const Text(
        "",
        style: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.w600,
          color: Color.fromARGB(255, 26, 96, 91),
        ),
      ),
    );
  }
}

//////////////////////////////////////////////////////////////////////////////
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
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      height: size.width * 0.7,
      color: const Color.fromARGB(255, 255, 255, 255),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            height: size.width * 0.7,
            width: size.width * 0.7,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: Colors.white,
            ),
          ),
          Image.network(
            image,
            height: size.width * 0.8,
            width: size.width * 0.8,
            fit: BoxFit.cover,
          ),
        ],
      ),
    );
  }
}
