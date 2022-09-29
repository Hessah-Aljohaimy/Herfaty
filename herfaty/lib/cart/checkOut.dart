import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_place_picker/google_maps_place_picker.dart';
import 'package:herfaty/cart/payForm.dart';
import 'package:herfaty/constants/color.dart';
import 'package:herfaty/models/cartModal.dart';
import 'package:status_change/status_change.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';

class checkOut extends StatelessWidget {
  List<CartModal> Items;
  num totalPrice;
  String shopName;

  checkOut({
    Key? key,
    required Items,
    required totalPrice,
    required shopName,
  })  : this.Items = Items,
        this.totalPrice = totalPrice,
        this.shopName = shopName,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        appBar: DefaultAppBar(title: "إكمال عملية الدفع"),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 25,
                width: double.infinity,
                margin: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
                child: Text(
                  "ملخص الطلب",
                  textAlign: TextAlign.right,
                  style: TextStyle(
                      color: Color(0xff5596A5),
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      fontFamily: "Tajawal"),
                ),
              ),
              _buildList(Items, shopName),
              Container(
                height: 25,
                width: double.infinity,
                margin: EdgeInsets.only(top: 20.0, left: 10.0, right: 10.0),
                child: Text(
                  "موقع التوصيل",
                  textAlign: TextAlign.right,
                  style: TextStyle(
                      color: Color(0xff5596A5),
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      fontFamily: "Tajawal"),
                ),
              ),
              add(),
              Container(
                height: 25,
                width: double.infinity,
                margin: EdgeInsets.only(top: 20.0, left: 10.0, right: 10.0),
                child: Text(
                  "بيانات الدفع",
                  textAlign: TextAlign.right,
                  style: TextStyle(
                      color: Color(0xff5596A5),
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      fontFamily: "Tajawal"),
                ),
              ),
              payForm(Items: Items),
              Container(
                height: 35,
                width: double.infinity,
                color: Colors.white,
                margin: EdgeInsets.only(top: 10.0, left: 8.0, right: 8.0),
                padding: EdgeInsets.all(4.0),
                child: Text("المجموع $totalPrice ريال",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xff5596A5),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Tajawal",
                    )),
              ),
            ],
          ),
        ),
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
      leading: IconButton(
        padding: EdgeInsets.only(right: 20),
        icon: const Icon(
          Icons.arrow_back, //سهم العودة
          color: Color.fromARGB(255, 26, 96, 91),
          size: 22.0,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}

Widget _buildList(List<CartModal> list, String shopName) {
  return Container(
    margin: EdgeInsets.only(top: 1.0, left: 8.0, right: 8.0),
    padding: EdgeInsets.all(1.0),
    decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Color(0xff51908E), width: 1),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
              color: Color(0xff51908E).withOpacity(0.9), offset: Offset(1, 1))
        ]),
    child: ExpansionTile(
      title: Text(
        //k, //ضعي اسم المتجر ثم شيلي الكومنت
        shopName,
        style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15,
            color: Color(0xff51908E)),
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
                  decoration: BoxDecoration(
                      border: Border.all(color: Color(0xFFF1F1F1))),
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
                              Text("الكمية ${list[index].quantity.toString()}"),
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
    ),
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
/*
Widget adress() {
  String msg = 'ادخل موقعك';
  return Container(
    margin: EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
    padding: EdgeInsets.all(8.0),
    decoration: BoxDecoration(border: Border.all(color: Color(0xFFF1F1F1))),
    child: Row(
      children: [
        Text(
          msg,
          style: TextStyle(fontSize: 16),
        ),
        ElevatedButton(
          child: Text(
            "اضغط هنا لتحديد موقعك",
            style: TextStyle(fontSize: 20),
          ),
          onPressed: _changeText,
        )
      ],
    ),
  );
}*/

class add extends StatefulWidget {
  const add({Key? key}) : super(key: key);

  @override
  _addState createState() => _addState();
}

class _addState extends State<add> {
  String msg = 'ادخل موقعك';
  String msgButton = "اضغط هنا لتحديد موقعك";
  Color color = new Color(0xff51908E);
  Color Tcolor = new Color.fromARGB(255, 255, 255, 255);
  TextDecoration t = TextDecoration.none;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 1.0, left: 8.0, right: 8.0),
      padding: EdgeInsets.all(5.0),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: new Color(0xff51908E), width: 1),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                color: new Color(0xff51908E).withOpacity(0.9),
                offset: Offset(1, 1))
          ]),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Text(
                msg,
                style: TextStyle(
                  fontSize: 15,
                  color: new Color(0xff51908E),
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.ellipsis,
                softWrap: false,
                maxLines: 5,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 8.0, top: 2.0, bottom: 2.0),
            child: ElevatedButton(
              child: Text(
                msgButton,
                style: TextStyle(fontSize: 15, color: Tcolor, decoration: t),
              ),
              onPressed: _changeText,
              style: ElevatedButton.styleFrom(
                  shadowColor: Colors.white,
                  elevation: 0,
                  primary: color,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  fixedSize: Size(165, 35)),
            ),
          )
        ],
      ),
    );
  }

  _changeText() {
    final kInitialPosition = LatLng(24.575714, 46.830308);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PlacePicker(
          apiKey:
              "AIzaSyAwT-rSNhTijJZ2Op4IWMddDdLF0Dcq8-o", // Put YOUR OWN KEY here.
          onPlacePicked: (result) {
            //print(result.formattedAddress);
            Navigator.of(context).pop();
            setState(() {
              if (result.formattedAddress is Null) {
                msg = 'ادخل الموقع';
              } else {
                msg = result.formattedAddress!;
                color = new Color.fromARGB(255, 255, 255, 255);
                Tcolor = Color.fromARGB(255, 0, 0, 0);
                t = TextDecoration.underline;
                msgButton = "اضغط لتغيير الموقع";
              }
            });
          },
          initialPosition: kInitialPosition,
          useCurrentLocation: true,
        ),
      ),
    );
  }
}
