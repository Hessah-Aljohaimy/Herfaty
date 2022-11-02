import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_place_picker/google_maps_place_picker.dart';
import 'package:herfaty/cart/cart.dart';
import 'package:herfaty/cart/payForm.dart';
import 'package:herfaty/constants/color.dart';
import 'package:herfaty/models/cartModal.dart';

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
  var shopOwnerId;

  @override
  Widget build(BuildContext context) {
    print("class checkout");
    add.msg = 'ادخل موقعك';
    _addState._changeFormat();

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: DefaultAppBar(title: "إتمام عملية الطلب"),
        body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
              image: DecorationImage(
            image: AssetImage('assets/images/cartBack1.png'),
            fit: BoxFit.cover,
          )),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: 25,
                  width: double.infinity,
                  margin: EdgeInsets.only(top: 15.0, left: 10.0, right: 15.0),
                  child: Text(
                    "ملخص الطلب",
                    textAlign: TextAlign.right,
                    style: TextStyle(
                        color: Color(0xff51908E),
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        //fontStyle: FontStyle.italic,
                        fontFamily: "Tajawal"),
                  ),
                ),
                _buildList(Items, shopName),
                Container(
                  height: 25,
                  width: double.infinity,
                  margin: EdgeInsets.only(top: 20.0, left: 10.0, right: 15.0),
                  child: Text(
                    "موقع التوصيل",
                    textAlign: TextAlign.right,
                    style: TextStyle(
                        color: Color(0xff51908E),
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        //fontStyle: FontStyle.italic,
                        fontFamily: "Tajawal"),
                  ),
                ),
                add(),
                /*Container(
                  height: 25,
                  width: double.infinity,
                  margin: EdgeInsets.only(top: 20.0, left: 10.0, right: 10.0),
                  child: Text(
                    "بيانات الدفع",
                    textAlign: TextAlign.right,
                    style: TextStyle(
                        color: Color(0xff51908E),
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                        fontFamily: "Tajawal"),
                  ),
                ),*/

/*

                FloatingActionButton.extended(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => payForm(Items: Items),
                    ));

                    // Add your onPressed code here!
                  },
                  label: const Text('الإكمال إلى الدفع'),
                  icon: const Icon(Icons.payment),
                  backgroundColor: Color(0xff51908E),
                ),


                */
              ],
            ),
          ),
        ),
        bottomNavigationBar: Container(
          //height: 35,
          width: double.infinity,
          color: Colors.white,
          /* margin: EdgeInsets.only(
            top: 10.0,
          ),*/
          padding: EdgeInsets.only(right: 10.0, left: 10.0, top: 5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                  "المجموع: \n ${totalPrice.toStringAsFixed(2)} ريال \n ${(totalPrice / 3.75).toStringAsFixed(2)} دولار  ",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xff51908E),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Tajawal",
                  )),
              ElevatedButton(
                child: Text(
                  "اتمام الدفع",
                  style: TextStyle(
                      fontSize: 15, color: Colors.white, fontFamily: "Tajawal"),
                ),
                onPressed: () {
                  if (add.msg == 'ادخل موقعك') {
                    ShowDialogMethod(context, "من فضلك قم بتحديد موقع التوصيل");
                  }
                  else {
                 
                  String loc =
                       add.msg;
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => payForm(
                      Items: Items,
                      location: loc,
                      shopName: shopName,
                      totalPrice: totalPrice,
                      shopOwnerId: Items[0].shopOwnerId,
                      temp: Items,
                    ),
                  ));
                  }
                },
                style: ElevatedButton.styleFrom(
                    shadowColor: Colors.white,
                    elevation: 0,
                    primary: Color(0xff51908E),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    fixedSize: Size(180, 35)),
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
      title: Text(title,
          style: TextStyle(color: kPrimaryColor, fontFamily: "Tajawal")),
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
          add.msg = 'ادخل موقعك';
          Navigator.pop(context);
        },
      ),
    );
  }
}

Widget _buildList(List<CartModal> list, String shopName) {
  return Container(
    margin: EdgeInsets.only(top: 1.0, left: 8.0, right: 8.0),
    padding: EdgeInsets.only(bottom: 5.0),
    decoration: BoxDecoration(
      color: Color.fromARGB(255, 255, 255, 255),
      border: Border.all(color: Color(0xff51908E), width: 2),
      borderRadius: BorderRadius.all(Radius.circular(10.0)),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 2,
          blurRadius: 7,
          offset: Offset(0, 3), // changes position of shadow
        ),
      ],
    ),
    child: ExpansionTile(
      initiallyExpanded: true,
      title: Text(
        //k, //ضعي اسم المتجر ثم شيلي الكومنت
        shopName,
        style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15,
            color: Color(0xff51908E),
            fontFamily: "Tajawal"),
      ),
      children: <Widget>[
        Center(
          child: ListView.builder(
              physics: NeverScrollableScrollPhysics(),
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
                              Text(
                                  " ${list[index].price.toString()}ريال لكل قطعة "),
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

class add extends StatefulWidget {
  static String msg = 'ادخل موقعك';
  add({Key? key}) : super(key: key);
  @override
  _addState createState() => _addState();
}

class _addState extends State<add> {
  static String msgButton = "اضغط هنا لتحديد موقعك";
  static Color color = new Color(0xff51908E);
  static Color Tcolor = new Color.fromARGB(255, 255, 255, 255);
  static TextDecoration t = TextDecoration.none;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 1.0, left: 8.0, right: 8.0, bottom: 8.0),
      padding: EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 255, 255, 255),
        border: Border.all(color: Color(0xff51908E), width: 2),
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Text(
                add.msg,
                style: TextStyle(
                  fontSize: 15,
                  color: new Color(0xff51908E),
                  fontWeight: FontWeight.bold,
                  fontFamily: "Tajawal",
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
                style: TextStyle(
                  fontSize: 13,
                  color: Tcolor,
                  decoration: t,
                  //fontFamily: "Tajawal"
                ),
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
              "AIzaSyA39qkpPUBK63CO4RGlDAacBIUlDl4RPgY", // Put YOUR OWN KEY here.
          onPlacePicked: (result) {
            //print(result.formattedAddress);
            Navigator.of(context).pop();
            if (mounted)
              setState(() {
                if (result.formattedAddress is Null) {
                  add.msg = 'ادخل الموقع';
                } else {
                  add.msg = result.formattedAddress!;
                  //msgButton = "تم تحديد الموقع";
                  color = new Color.fromARGB(255, 255, 255, 255);
                  Tcolor = Color.fromARGB(255, 8, 24, 246);
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

  static _changeFormat() {
    msgButton = "اضغط هنا لتحديد موقعك";
    color = new Color(0xff51908E);
    Tcolor = new Color.fromARGB(255, 255, 255, 255);
    t = TextDecoration.none;
  }
}
