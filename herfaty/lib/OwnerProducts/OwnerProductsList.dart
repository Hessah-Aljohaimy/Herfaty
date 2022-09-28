import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:herfaty/CustomerProducts/CustomerProductDetails.dart';
import 'package:herfaty/constants/size.dart';
import 'package:herfaty/CustomerProducts/productCard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:herfaty/models/Product1.dart';
import 'package:herfaty/constants/color.dart';
import 'package:herfaty/constants/icons.dart';

class OwnerProductsList extends StatelessWidget {
  String categoryName;

  OwnerProductsList({
    required categoryName,
    Key? key,
  })  : this.categoryName = categoryName,
        super(key: key);
  //category name is a variable to store the category name from categories page
  //  صفحة عائشة ترسل لي هنا اسم الفئة بناء عليه أعرض المنتجات
  //======================================================================================

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    String thisOwnerId = user!.uid;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: productsListAppBar(context),
      //..........................................................................................
      body: SafeArea(
        child: Column(
          children: [
            //تبعد لي البوكس اللي يعرض المنتجات عن الشريط العلوي
            const SizedBox(height: 15),
            Expanded(
              child: Stack(
                children: [
                  //This is to list all of our items fetched from the DB========================
                  StreamBuilder<List<Product1>>(
                    stream: readPrpducts(thisOwnerId),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (snapshot.hasError) {
                        return Text('Something went wrong! ${snapshot.error}');
                      } else if (snapshot.hasData) {
                        //هنا حالة النجاح في استرجاع البيانات...........................................
                        //String detailsImage = "";
                        final productItems = snapshot.data!.toList();

                        return ListView.builder(
                          itemCount: productItems.length,
                          itemBuilder: (context, index) => productCard(
                            itemIndex: index,
                            product: productItems[index],
                            press: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CustomerProdectDetails(
                                    // يرسل المعلومات لصفحة المنتج عشان يعرض التفاصيل
                                    detailsImage: productItems[index].image,
                                    product: productItems[index],
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                        //..................................................................................
                      } else {
                        return const Center(child: CircularProgressIndicator());
                      }
                    },
                  ),
                  //==================================================================================
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  //=====================================================================================
  Stream<List<Product1>> readPrpducts(String thisOwnerId) => FirebaseFirestore
      .instance
      .collection('Products')
      .where("categoryName", isEqualTo: categoryName)
      .where("shopOwnerId", isEqualTo: thisOwnerId)
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => Product1.fromJson(doc.data())).toList());

  //======================================================================================
//////////////////////////////////////////////////////////////////////////////////////////////
  //AppBar
  AppBar productsListAppBar(var context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      title: Text(
        categoryName,
        style: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.w600,
          color: kPrimaryColor,
        ),
      ),
      leading: IconButton(
        padding: EdgeInsets.only(right: 20),
        icon: const Icon(
          Icons.arrow_back, //سهم العودة
          color: Color.fromARGB(255, 26, 96, 91),
          size: 22.0,
        ),
        onPressed: () {
          Navigator.pop(context);
        }, //نخليه يرجع لصفحة المنتجات اللي عند عائشة
      ),
    );
  }
}
