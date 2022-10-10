import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:herfaty/cart/cart.dart';
import 'package:url_launcher/url_launcher.dart';
import '../constants/color.dart';
import '../models/Product1.dart';

class DriverOrderDetails extends StatefulWidget {
  String date;
  num totalOrder;
  String docID;
  Map products;
  String status;
String location;
String shopName;
  DriverOrderDetails(
      {Key? key,
      required date,
      required totalOrder,
      required docID,
      required products,
      required status,
      required location,
      required shopName})
      : this.date = date,
        this.totalOrder = totalOrder,
        this.docID = docID,
        this.products = products,
        this.status = status,
        this.location=location,
        this.shopName=shopName,
        super(key: key);

  @override
  _orderDetailsState createState() => _orderDetailsState();
}

class _orderDetailsState extends State<DriverOrderDetails> {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        appBar: DefaultAppBarO(title: "تفاصيل الطلب"),
        body: Container(
          height: 700,
          decoration: BoxDecoration(
              image: DecorationImage(
            image: AssetImage('assets/images/cartBack1.png'),
            fit: BoxFit.cover,
          )),
          child: SingleChildScrollView(
            child: Column(
              children: [
                AppBarOD(
                    date: widget.date,
                    totalOrder: widget.totalOrder,
                    status: widget.status,
                    docID: widget.docID),
                Body(),
                locationD(location: widget.location
                ,docId: widget.docID,   
                                          shopName:widget.shopName),
                SizedBox(
                  height: 30,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AppBarOD extends StatelessWidget {
  String date;
  num totalOrder;
  String status;
  String docID;

  AppBarOD({
    Key? key,
    required date,
    required totalOrder,
    required status,
    required docID,
  })  : this.date = date,
        this.totalOrder = totalOrder,
        this.status = status,
        this.docID = docID,
        super(key: key);



  @override
  Widget build(BuildContext context) {
    String newStatus = "";
    if (status == "جاهز للتوصيل")
      newStatus = "خارج للتوصيل";
    else if (status == "خارج للتوصيل")
      newStatus = "تم التوصيل";
    return Container(
      padding: const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 15),
      //height: 100,
      width: double.infinity,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
        //color: Colors.white,
        gradient: LinearGradient(
          colors: [
            (Color.fromARGB(255, 81, 144, 142)),
            (Color.fromARGB(255, 85, 150, 165)),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ignore: prefer_const_constructors
              Text(
                "تاريخ الطلب: $date",

                style: TextStyle(
                    //color: Color.fromARGB(255, 81, 144, 142),
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    fontFamily: "Tajawal"),
                //textDirection: TextDirection.rtl,
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Center(
            // ignore: prefer_const_constructors
            child: Text(
              "حالة الطلب: $status",

              style: TextStyle(
                  //color: Color.fromARGB(255, 81, 144, 142),
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  fontFamily: "Tajawal"),
              //textDirection: TextDirection.rtl,
            ),
          ),
          Button(newStatus, docID, context),
        ],
      ),
    );
  }

  Widget Button(newStatus, docID, context1) {
    if (newStatus != "تم شحن المنتج") {
      return Center(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            //primary: Color.fromARGB(255, 81, 144, 142), // background
            primary: Colors.white,
          ),
          onPressed: () {
            showDialog(
                context: context1,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text("تغيير حالة الطلب"),
                    content: Text('سيتم تغيير حالة الطلب إلى $newStatus'),
                    actions: <Widget>[
                      TextButton(
                        child: Text("تغيير",
                            style: TextStyle(
                              color: Color.fromARGB(255, 81, 144, 142),
                            )),
                        onPressed: () {
                          FirebaseFirestore.instance
                              .collection('orders')
                              .doc(docID)
                              .update({"status": newStatus});
                          Navigator.pop(context);

                          Fluttertoast.showToast(
                            msg: "تم تغيير حالة الطلب بنجاح",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 3,
                            backgroundColor: Color.fromARGB(255, 26, 96, 91),
                            textColor: Colors.white,
                            fontSize: 18.0,
                          );

                          Timer(const Duration(seconds: 0), () {
                            Navigator.pop(context1);
                          });

                          //Navigator.pop(context);
                        },
                      ),
                      TextButton(
                        child: Text("تراجع"),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                });
          },
          child: Text(
            "تغيير إلى $newStatus", //change depend on status
            style: TextStyle(
              fontFamily: "Tajawal",
              color: Color.fromARGB(255, 81, 144, 142),
            ),
          ),
        ),
      );
    } else
      return Center();
  }
}

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
          ),
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }
}

class locationD extends StatelessWidget {
  String location;
  String docId;
  String shopName;
  locationD({Key? key, required location,required docId,required shopName})
      : this.location = location,
      this.docId=docId,
      this.shopName=shopName,
        super(key: key);



        launchURL (String url)async{
if(await canLaunch(url)){
await launch(url);
}
else{
print('zsssssssssss');
}

        }
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

                   Container(
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
                    child: Row(
                    
                    
                    
                    
                       children: [
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                            SizedBox(
                            height: 17,
                          ),
                                              Text(
                                                "رقم الطلب : $docId",
                                                style: TextStyle(
                                                    fontSize: 17.0,
                                                    fontFamily: "Tajawal"),
                                              ),
                                                SizedBox(
                            height: 17,
                          ),
                                              Text(
                                                "اسم المتجر : $shopName",
                                                style: TextStyle(
                                                    fontSize: 17.0,
                                                    fontFamily: "Tajawal"),
                                              ),
  SizedBox(
                            height: 17,
                          ),
                                  Container(     

      margin: const EdgeInsets.only(right: 105.0),

child:
                                                   ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          primary: Color.fromARGB(
                                              255, 81, 144, 142), // background
                                        ),
                                        onPressed: () {
                                       var url='https://maps.google.com/?q=$location';
                                          //go to order deatils page
                                          launchURL(url);
                                        },
                                        child: Text(
                                          "موقع التوصيل",
                                          style: TextStyle(
                                            fontFamily: "Tajawal",
                                          ),
                                        ),
                                      ),
                                      ),
                                                        SizedBox(
                            height: 17,
                          ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                      // title: Text(
                      //   "المنتجات المطلوبة",
                      //   style: TextStyle(
                      //       fontWeight: FontWeight.bold,
                      //       fontSize: 15,
                      //       color: Color(0xff51908E),
                      //       fontFamily: "Tajawal"),
                      // ),
                
                    ),
                    
                  ),
                  
                  
                  ]
      ),
    );
                }
              }
       
  

  

// Stream to reach collection


class DefaultAppBarO extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  const DefaultAppBarO({
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
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(Icons.arrow_back),
      ),
    );
  }
}
