import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'OrderModel.dart';
import 'orderDetails.dart';
//import 'package:flutterfiredemo/item_details.dart';
//import 'add_item.dart';

class list extends StatelessWidget {
  list({Key? key}) : super(key: key) {
    // _stream = _reference.snapshots();
  }
  //CollectionReference _reference =
  // FirebaseFirestore.instance.collection('ShopOwnerOrders');

  late Stream<QuerySnapshot> _stream;
  Stream<List<orderModel>> readPrpducts() {
    // final uid = user.getIdToken();

    return FirebaseFirestore.instance
        .collection('ShopOwnerOrders')
        //  .where("categoryName", isEqualTo: categoryName)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => orderModel.fromJson(doc.data()))
            .toList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('الطلبات'),
      ),
      body: StreamBuilder<List<orderModel>>(
        stream: readPrpducts(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          //Check error
          if (snapshot.hasError) {
            return Center(child: Text('Some error occurred ${snapshot.error}'));
          }

          //Check if data arrived
          if (snapshot.hasData) {
            //get the data
            QuerySnapshot querySnapshot = snapshot.data;
            final productItems = snapshot.data!.toList();
            List<QueryDocumentSnapshot> documents = querySnapshot.docs;

            //Convert the documents to Maps
            List<Map> items = documents
                .map((e) => {
                      'customerID': e['customerID'],
                      'image': e['image'],
                      'orderDate': e['orderDate'],
                      'orderDay': e['orderDay'],
                      'shopOwnerID': e['shopOwnerID'],
                      'qantity': e['qantity'],
                      'totalPrice': e['totalPrice'],
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
    );
  }
}
