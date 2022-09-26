import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:herfaty/CustomerProducts/AddProductToCart.dart';
import 'package:herfaty/CustomerProducts/Product1.dart';
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
  int updatedQuantity = 1;
  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    //////////////////////////////////////////////////////////////////////////////////////////

    //////////////////////////////////////////////////////////////////////////////////////
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
                          Text(
                            widget.product.name,
                            style: const TextStyle(
                              fontSize: 26.0,
                              fontWeight: FontWeight.w600,
                              color: Color.fromARGB(255, 0, 0, 0),
                            ),
                          ),
                          // price======================================================================
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                ' ${updatedQuantity * widget.product.price} ريال',
                                style: const TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.orange,
                                ),
                              ),
                              Text(
                                ' الكمية: ${widget.product.quantity} / ${updatedQuantity} ',
                                style: const TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w600,
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
                  child: Expanded(
                    child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child:
                            ExpandedWidget(text: widget.product.description)),
                  ),
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
                            onPressed: () {
                              setState(
                                () {
                                  if (updatedQuantity > 1) {
                                    updatedQuantity = updatedQuantity - 1;
                                    FirebaseFirestore.instance
                                        .collection('cart')
                                        .doc('${widget.product.id}')
                                        .update({"quantity": updatedQuantity});
                                  } else {
                                    ShowDialogMethod(
                                        context, "أقل عدد للمنتج هو واحد");
                                  }
                                },
                              );
                            },
                            icon: Icon(
                              Icons.remove_circle_outline,
                              color: Colors.white,
                              size: 26,
                            )),
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
                                hintText: '${updatedQuantity}',
                                hintStyle: const TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 24,
                                    color: Color.fromARGB(255, 255, 255, 255))),
                          ),
                        ),
                        IconButton(
                            onPressed: () {
                              setState(
                                () {
                                  if (updatedQuantity <
                                      widget.product.quantity) {
                                    updatedQuantity = updatedQuantity + 1;
                                    FirebaseFirestore.instance
                                        .collection('cart')
                                        .doc('${widget.product.id}')
                                        .update({"quantity": updatedQuantity});
                                  } else {
                                    ShowDialogMethod(context,
                                        "لا توجد كمية متاحة من المنتج أكثر من ذلك");
                                  }
                                },
                              );
                            },
                            icon: Icon(
                              Icons.add_circle_outline,
                              color: Colors.white,
                              size: 26,
                            )),
                      ],
                    ),
                    Container(
                      // زر اللإضافة للسلة-----------------------------------------
                      child: ElevatedButton(
                        onPressed: () async {
                          AddProductToCart item = AddProductToCart(
                              name: widget.product.name,
                              detailsImage: widget.detailsImage,
                              productId: widget.product.id,
                              customerId: user!.uid,
                              //هنا نحط ال ايدي حق الكستمر اللي يستعمل المتجر
                              quantity: updatedQuantity,
                              availableAmount: widget.product.quantity,
                              price: widget.product.price);
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

                          createCartItem(item);
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
                          padding: const EdgeInsets.symmetric(
                            horizontal: 26,
                            vertical: 3,
                          ),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25.0)),
                        ),
                        child: const Text(
                          'أضف إلى السلة',
                          style: TextStyle(
                            fontSize: 20.0,
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

  Future createCartItem(AddProductToCart cartItem) async {
    final docCartItem = FirebaseFirestore.instance.collection('cart').doc();
    final json = cartItem.toJson();
    await docCartItem.set(
      json,
      // SetOptions(merge: true)
    );
  }

  Future updateProductAvailableAmount(AddProductToCart cartItem) async {
    final docCartItem = FirebaseFirestore.instance
        .collection('Products')
        .doc("${cartItem.productId}")
        .update({'avalibleAmount': cartItem.availableAmount});
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
