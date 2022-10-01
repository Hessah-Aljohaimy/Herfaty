import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:herfaty/constants/color.dart';

class orderState {
  //extends State<OrderList> {
  CollectionReference referenceShopOwnerOrder =
      FirebaseFirestore.instance.collection("ShopOwnerOrders");
  late Stream<QuerySnapshot> streamOrder;

  initState() {
    //  super.initState();
    streamOrder = referenceShopOwnerOrder.snapshots();
  }

  Widget build(BuildContext context) {
    referenceShopOwnerOrder.get(); //give future
    referenceShopOwnerOrder.snapshots(); // return stream
    return Scaffold(
      appBar: AppBar(
        title: Text("طلبات جديدة"),
        actions: [],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: streamOrder,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }

          if (snapshot.connectionState == ConnectionState.active) {
            //try to get data
            QuerySnapshot querySnapshot = snapshot.data;
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
} // class

class OrderList extends StatelessWidget {
  const OrderList({super.key});

  @override
  @override
  Widget build(BuildContext context) {
    const title = 'قائمة الطلبات';

    return MaterialApp(
      title: title,
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: DefaultAppBar(title: "طلبات متجري"),

        //title: const Text(title),
        // ),
        body: ListView(
          children: const <Widget>[
            ListTile(
              //leading: Icon(Icons.map),
              title: Text('الطلب الأول'),

              //style:Color(0xff51908E),
            ),
            ListTile(
              //leading: Icon(Icons.photo_album),
              title: Text('الطلب الثاني'),
            ),
            ListTile(
              // leading: Icon(Icons.phone),
              title: Text('الطلب الثالث'),
            ),
          ],
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
      title: Text(title, style: TextStyle(color: kPrimaryColor)),
      centerTitle: true,
      backgroundColor: Colors.white,
      elevation: 0,
      automaticallyImplyLeading: false,
      iconTheme: IconThemeData(color: kPrimaryColor),
    );
  }
}
