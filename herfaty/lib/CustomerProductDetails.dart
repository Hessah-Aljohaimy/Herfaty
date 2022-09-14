import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:herfaty/AddProductToCart.dart';
import 'package:herfaty/Product1.dart';
import 'package:herfaty/constants/color.dart';
//import 'package:herfaty/ProductDetailsBody.dart';

class CustomerProdectDetails extends StatefulWidget {
  final Product1 product;
  String detailsImage;

  CustomerProdectDetails(
      {super.key, required this.product, required this.detailsImage});

  @override
  State<CustomerProdectDetails> createState() => _CustomerProdectDetailsState();
}

class _CustomerProdectDetailsState extends State<CustomerProdectDetails> {
  @override
  Widget build(BuildContext context) {
    //////////////////////////////////////////////////////////////////////////////////////////
    AddProductToCart item = AddProductToCart(
        name: widget.product.name,
        detailsImage: widget.detailsImage,
        productId: widget.product.id,
        customerId: "customerId",
        //هنا نحط ال ايدي حق الكستمر اللي يستعمل المتجر
        quantity: 1,
        availableAmount: widget.product.quantity, //تحتاج تغيير
        price: widget.product.price);
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
                      //product image=====================================================================
                      Center(
                        child: ProductImage(
                          size: size,
                          image: widget.detailsImage,
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.product.name,
                            style: const TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.w600,
                              color: Color.fromARGB(255, 0, 0, 0),
                            ),
                          ),
                          // product price======================================================================
                          Text(
                            ' ${widget.product.price} ريال',
                            style: const TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.w600,
                              color: Colors.orange,
                            ),
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
                    child: Text(
                      widget.product.description,
                      style: const TextStyle(
                        fontSize: 18.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                //(أضافة إلى السلة)============================================================//
                //////////////////////////////////////////////////////////////////////////////////
                /////=============================================================================
                //////////////////////////////////////////////////////////////////////////////////
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      child: ElevatedButton(
                        onPressed: () {
                          item.availableAmount - 1;
                          createCartItem(item);
                          String idToBeUpdated = item.productId;

                          //update available amount of the product in the product collection
                          final updateAvailableAmount = FirebaseFirestore
                              .instance
                              .collection('Products')
                              .doc("${idToBeUpdated}");
                          updateAvailableAmount.update({'avalibleAmount': 20});
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 30,
                            vertical: 6,
                          ),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0)),
                        ),
                        child: const Text(
                          'أضف إلى السلة',
                          style: TextStyle(
                            fontSize: 22.0,
                            fontWeight: FontWeight.w900,
                            color: kPrimaryColor,
                          ),
                        ),
                      ),
                    ),

                    ////////////////////////////////////////////////////////////////////////////////
                    ///
                    Row(
                      //mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        IconButton(
                            onPressed: () {
                              setState(() {
                                if (item.quantity > 1) {
                                  var updaterAmount = (item.quantity) - 1;
                                  FirebaseFirestore.instance
                                      .collection('cart')
                                      .doc(item.productId)
                                      .update({"quantity": updaterAmount});
                                } else {
                                  //erro message no item less than 1
                                }
                              });
                            },
                            icon: Icon(
                              Icons.remove_circle_outline,
                              color: Colors.white,
                              size: 35,
                            )),
                        Container(
                            width: 44.0,
                            height: 44.0,
                            padding: EdgeInsets.only(top: 22.0),
                            color: kPrimaryColor,
                            child: TextField(
                              enabled: false,
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: item.quantity.toString(),
                                  hintStyle: const TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 25,
                                      color:
                                          Color.fromARGB(255, 255, 255, 255))),
                            )),
                        IconButton(
                            onPressed: () {
                              setState(() {
                                if (item.quantity < item.availableAmount) {
                                  var updaterAmount = (item.quantity) + 1;
                                  FirebaseFirestore.instance
                                      .collection('cart')
                                      .doc(item.productId)
                                      .update({"quantity": updaterAmount});
                                }
                              });
                            },
                            icon: Icon(
                              Icons.add_circle_outline,
                              color: Colors.white,
                              size: 35,
                            )),
                      ],
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

  Future createCartItem(AddProductToCart cartItem) async {
    final docCartItem = FirebaseFirestore.instance
        .collection('cart')
        .doc("${cartItem.productId}");
    final json = cartItem.toJson();
    await docCartItem.set(json);
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
        " رجوع",
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
      margin: const EdgeInsets.symmetric(vertical: 10),
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
