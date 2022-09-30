import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../constants/color.dart';
import 'OrderModel.dart';
import 'orderDetails.dart';
//import 'package:flutterfiredemo/item_details.dart';
//import 'add_item.dart';

class list extends StatelessWidget {
  list({Key? key}) : super(key: key) {
    // _stream = _reference.snapshots();
  }
  Stream<List<orderModal>> readPrpducts() => FirebaseFirestore.instance
      // final uid = user.getIdToken();
      .collection('orders')
      //  .where("categoryName", isEqualTo: categoryName)
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => OrderModel.fromJson(doc.data())).toList());

  Widget buildUser(orderModal orderModel) => ListTile(
        //leading: CircleAvatar(child: Text('${orders.docId}')),
        title: Text(orderModel.docId),
        subtitle: Text('yes'),
      );
  //CollectionReference _reference =
  // FirebaseFirestore.instance.collection('ShopOwnerOrders');

  //late Stream<QuerySnapshot> _stream;

  // 1 METHOD....

  /*return FirebaseFirestore.instance
        .collection('orders')
        //  .where("categoryName", isEqualTo: categoryName)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => orderModel.fromJson(doc.data()))
            .toList());*/

  @override
  Widget build(BuildContext context) {
    const title = 'قائمة الطلبات';

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: DefaultAppBar(title: "طلبات متجري"),
      body: StreamBuilder<List<orderModal>>(
          stream: readPrpducts(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasError) {
              return Center(
                  child: Text('Some error occurred ${snapshot.error}'));
            } else if (snapshot.hasData) {
              final orders = snapshot.data!; //.toList();
              return ListView(
                children: orders.map(buildUser).toList(),
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }

  //Check error
  /* if (snapshot.hasError) {
            return Center(child: Text('Some error occurred ${snapshot.error}'));
          

          //Check if data arrived
          if (snapshot.hasData) {
            //get the data
            QuerySnapshot querySnapshot = snapshot.data;
            final productItems = snapshot.data!.toList();
            List<QueryDocumentSnapshot> documents = querySnapshot.docs;

            //Convert the documents to Maps
            List<Map> items = documents
                .map((e) => {
                      'customerId': e['customerId'],
                      'docId': e['docId'],
                      'shopOwnerId': e['shopOwnerId'],
                      'location': e['location'],
                      'total': e['total'],
                      'shopName': e['shopName'],
                      'notification': e['notification'],
                      'productId': e['productId'],
                      'status': e['status'],
                      'cartDocId': e['cartDocId'],
                      'orderDate': e['orderDate'],
                    })
                .toList();

            //Display the list
            return ListView.builder(
                itemCount: items.length,
                itemBuilder: (BuildContext context, int index) {
                  //Get the item at this index
                  Map thisItem = items[index];
                  //REturn the widget for the list items
                  return ListTile(
                    title: Text('${thisItem['orderDate']}'),
                    subtitle: Text('${thisItem['totalPrice']}'),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => orderDetails(thisItem['id'])));
                    },
                  );
                });
          }

          //Show loader
          return Center(child: CircularProgressIndicator());
        },
      ), //Display a list // Add a FutureBuilder
      /*floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => AddItem()));
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),*/
    );*/

  // );
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
