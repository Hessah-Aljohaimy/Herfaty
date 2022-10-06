import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../constants/color.dart';
import 'package:herfaty/ShopOwnerOrder/OrderModel.dart';

import 'login.dart';


class driverPage  extends StatelessWidget {
  driverPage({Key? key}) : super(key: key) {
  }



  @override
  Widget build(BuildContext context) {
    const title = 'قائمة الطلبات';

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: DefaultAppBar(title: "طلبات التوصيل"),

        body: SingleChildScrollView(
          child: Container(
            height: 900,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/cartBack1.png'),
                    fit: BoxFit.cover)),
            child: StreamBuilder<List<OrderModel>>(
                stream: readPrpducts(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text("somting wrong \n ${snapshot.error}");
                  } else if (!snapshot.hasData) {
                    return Text("");
                  } else if (snapshot.hasData) {
                    final cItems = snapshot.data!.toList();
                    Size size = MediaQuery.of(context).size;

                    if (cItems.isEmpty) {
                      return const Center(
                        child: Text(
                          'لا يوجد طلبات',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w600,
                            fontFamily: "Tajawal",
                            color: Colors.grey,
                          ),
                        ),
                      );
                    } else {
                      return ListView.builder(
                          itemCount: cItems.length,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: EdgeInsets.only(
                                  top: 8.0, left: 8.0, right: 8.0),
                              padding: EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(color: Color(0xFFF1F1F1))),
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
                                          Text(
                                              //cItems[index].customerId,
                                              "طلب رقم ${cItems[index].docId}",
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  fontSize: 17.0,
                                                  fontFamily: "Tajawal")),
                                          Text(
                                            "تاريح الطلب :${cItems[index].orderDate} ",
                                            style: TextStyle(
                                                fontSize: 17.0,
                                                fontFamily: "Tajawal"),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  // ElevatedButton(
                                  //   style: ElevatedButton.styleFrom(
                                  //     primary: Color.fromARGB(
                                  //         255, 81, 144, 142), // background
                                  //   ),
                                  //   onPressed: () {
                                  //     //go to order deatils page
                                  //   },
                                  //   child: Text(
                                  //     "تفاصيل الطلب",
                                  //     style: TextStyle(
                                  //       fontFamily: "Tajawal",
                                  //     ),
                                  //   ),
                                  // ),
                                ],
                              ),
                            );
                          });
                    }
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                }),
          ),
        ),

     
      ),
    );
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
      title: Text("طلبات التوصيل",
          style: TextStyle(
            color: Color(0xff51908E),
            fontFamily: "Tajawal",
          )),
      centerTitle: true,
      backgroundColor: Colors.white,
      shadowColor: Color.fromARGB(255, 39, 141, 134),
      elevation: 0,
      leading: IconButton(
         icon: Icon(Icons.logout, color: Color.fromARGB(255, 81, 144, 142)),
          onPressed: () async {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text("تنبيه"),
                    content: Text('سيتم تسجيل خروجك من الحساب'),
                    actions: <Widget>[
                      TextButton(
                        child: Text("تسجيل خروج",
                            style: TextStyle(color: Colors.red)),
                        onPressed: () {
                          // FirebaseAuth.instance.signOut();
                          // Navigator.of(context).pushNamedAndRemoveUntil(
                          //     "/", (Route<dynamic> route) => false);
                          Navigator.of(context, rootNavigator: true)
                              .pushReplacement(MaterialPageRoute(
                                  builder: (context) => new login()));
                        },
                      ),
                      TextButton(
                        child: Text("تراجع"),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      )
                    ],
                  );
                });

            /*Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (BuildContext context) {
              return Welcome();
            }));*/
          },
        ),
      automaticallyImplyLeading: false,
      iconTheme: IconThemeData(color: Color(0xff51908E)),
    );
  }
}

Stream<List<OrderModel>> readPrpducts() {


    return FirebaseFirestore.instance
        .collection('orders')
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => OrderModel.fromJson(doc.data()))
            .toList());
  
}
