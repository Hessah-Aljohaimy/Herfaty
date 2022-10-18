// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:herfaty/MangeProduct.dart/EditProduct.dart';
import 'package:herfaty/models/AddProductToCart.dart';
import 'package:herfaty/models/Product1.dart';
import 'package:herfaty/constants/color.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:herfaty/widgets/ExpandedWidget.dart';

import 'OwnerProductsList.dart';

class OwnerProdectDetails extends StatefulWidget {
  final Product1 product;
  String detailsImage;

  OwnerProdectDetails(
      {super.key, required this.product, required this.detailsImage});

  @override
  State<OwnerProdectDetails> createState() => _OwnerProdectDetailsState();
}

class _OwnerProdectDetailsState extends State<OwnerProdectDetails> {
  int thisPageQuantity = 1;
  //Not Sure Getter-----------
  //OwnerProductsList get categoryName => OwnerProductsList(categoryName: null,);
  var categoryName = "";
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
                                ' الكمية: ${widget.product.availableAmount} ',
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
                //(أزرار التعديل والحذف)============================================================//
                //////////////////////////////////////////////////////////////////////////////////
                /////=============================================================================
                //////////////////////////////////////////////////////////////////////////////////
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  ////////////////////////////////////////////////////////////////////////////// Icons
                  children: [
                    ////////////////////////////////////////////////////////////////////////////// Buttons
                    Container(
                      // زر التعديل
                      child: ElevatedButton(
                        onPressed: () {
                          //هنا يكون كود تعديل المنتج
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EditProduct(
                                    '${widget.product.availableAmount}',
                                    categoryName,
                                    widget.product.description,
                                    widget.detailsImage,
                                    widget.product.name,
                                    widget.product.id,
                                    ' ${thisPageQuantity * widget.product.price}')),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          padding: const EdgeInsets.only(
                            right: 60,
                            left: 60,
                            top: 10,
                            bottom: 5,
                          ),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25.0)),
                        ),
                        child: const Text(
                          'تعديل',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontFamily: "Tajawal",
                            fontWeight: FontWeight.bold,
                            color: kPrimaryColor,
                          ),
                        ),
                      ),
                    ),
                    //...........................................................................................
                    Container(
                      //margin: EdgeInsets.only(top: 20.0),
                      // زر الحذف-----------------------------------------
                      child: ElevatedButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text("حذف منتج"),
                                  content:
                                      Text('سيتم حذف هذا المنتج من منتجاتك'),
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
                                        FirebaseFirestore.instance
                                            .collection('Products')
                                            .doc(widget.product.id)
                                            //.doc(getDocId())
                                            .delete();

                                        showDoneDeleteToast(context);

                                        Navigator.of(context).pop();
                                      },
                                    )
                                  ],
                                );
                              });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          padding: const EdgeInsets.only(
                            right: 60,
                            left: 60,
                            top: 10,
                            bottom: 5,
                          ),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25.0)),
                        ),
                        child: const Text(
                          'حـذف',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontFamily: "Tajawal",
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ),
                    //////////////////////////////////////////////////////////////////////////////////////
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
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

  Future<void> showDoneDeleteToast(BuildContext context) async {
    Fluttertoast.showToast(
      msg: "تم حذف المنتج بنجاح",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 3,
      backgroundColor: Color.fromARGB(255, 26, 96, 91),
      textColor: Colors.white,
      fontSize: 18.0,
    );
    /*await Future.delayed(const Duration(seconds: 1), () {
      // Navigator.of(context, rootNavigator: false).pop();
      //Navigator.pop(context, true);
      {
        Navigator.of(context).pop();
        Navigator.of(context).pop();
      }
    });*/
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

    Navigator.pop(context);
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
      centerTitle: true,
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
