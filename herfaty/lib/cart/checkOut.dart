import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:herfaty/constants/color.dart';
import 'package:herfaty/models/cartModal.dart';
import 'package:status_change/status_change.dart';

class checkOut extends StatelessWidget {
  List<CartModal> Items;
  num totalPrice;

  checkOut({
    Key? key,
    required Items,
    required totalPrice,
    //required shopName,
  })  : this.Items = Items,
        this.totalPrice = totalPrice,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        appBar: DefaultAppBar(title: "إكمال عملية الدفع"),
        body: _buildList(Items),
      ),
    ); // Column
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

Widget _drawer(List<CartModal> data) {
  return Drawer(
      child: SafeArea(
    child: SingleChildScrollView(),
  ));
}

Widget _buildList(List<CartModal> list) {
  return ExpansionTile(
    title: Text(
      //k, //ضعي اسم المتجر ثم شيلي الكومنت
      "المنتجات المختارة من اسم المتجر",
      style: TextStyle(
          fontWeight: FontWeight.bold, fontSize: 20, color: Color(0xff5596A5)),
    ),
    children: <Widget>[
      Center(
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: list.length,
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
                padding: EdgeInsets.all(8.0),
                decoration:
                    BoxDecoration(border: Border.all(color: Color(0xFFF1F1F1))),
                child: Row(
                  children: [
                    ProductImage(
                      size: MediaQuery.of(context).size,
                      image: list[index].image,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(list[index].name,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(fontSize: 16.0)),
                            Text(" ${list[index].price.toString()}ريال "),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
      ),
    ],
  );
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
      height: 90.0,
      width: 90.0,
      fit: BoxFit.cover,
    );
  }
}
