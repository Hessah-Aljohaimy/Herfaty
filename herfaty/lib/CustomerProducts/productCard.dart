// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:herfaty/models/Product1.dart';

class productCard extends StatelessWidget {
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
  Widget build(BuildContext context) {
    Size size =
        MediaQuery.of(context).size; //to get the width and height of the app
    return Container(
      decoration: BoxDecoration(
        //color: const Color(0xFFFAF9F6),
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
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
        onTap:
            press, // يعني ان المستخدم لما يضغط على الكارد تفتح معاه صفحة جديدة
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
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            //*************************This part contains product photo:
            Positioned(
              top: 0,
              left: 0,
              child: Container(
                // margin: const EdgeInsets.symmetric(
                //   vertical: 15,
                // ),
                // padding: const EdgeInsets.symmetric(
                //   horizontal: 20,
                // ),
                height: 180,
                width: 180,
                decoration: BoxDecoration(
                  border: Border.all(width: 0.1, color: Colors.white),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                  ),
                  //color: Color(0xFFFAF9F6),
                  color: Colors.white,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                  ),
                  child: Image.network(
                    product.image,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),

            //**********************This part contains product name and price
            Positioned(
              bottom: 0,
              right: 0,
              child: SizedBox(
                height: 136,
                //because our image is 200, so the siz of this box = width -200
                width: size.width - 200,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //product name=======================================================================
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        product.name,
                        style: const TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w600,
                          fontFamily: "Tajawal",
                          color: Colors.black,
                        ),
                      ),
                    ),
                    //const Spacer(),
                    //const Spacer(),
                    //const Spacer(),
                    //سعر المنتج وعلامة التفضيل===============================================================
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            //vertical: 10,
                            right: 18,
                            top: 18,
                          ),
                          child: Text(
                            ' ${product.price} ريال',
                            style: const TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.w400,
                              fontFamily: "Tajawal",
                              color: Colors.orange,
                            ),
                          ),
                        ),

                        //(أضافة إلى المفضلة )--------------------------
                        Padding(
                          padding: const EdgeInsets.only(
                            right: 10,
                            top: 18,
                          ),
                          child: IconButton(
                            padding: EdgeInsets.only(right: 1),
                            icon: const Icon(
                              Icons.favorite_border,
                              color: Colors.red,
                              size: 35.0,
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
