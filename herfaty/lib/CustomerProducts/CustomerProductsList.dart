// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:herfaty/CustomerProducts/CustomerProductDetails.dart';
import 'package:herfaty/CustomerProducts/productCard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:herfaty/models/Product1.dart';
import 'package:herfaty/constants/color.dart';

class CustomerProductsList extends StatelessWidget {
  String categoryName;

  CustomerProductsList({
    required categoryName,
    Key? key,
  })  : this.categoryName = categoryName,
        super(key: key);
  //variable to store the category name from categories page

  //  صفحة عائشة ترسل لي هنا اسم الفئة بناء عليه أعرض المنتجات
  Stream<List<Product1>> readPrpducts() => FirebaseFirestore.instance
      .collection('Products')
      .where("categoryName", isEqualTo: categoryName)
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => Product1.fromJson(doc.data())).toList());

  //======================================================================================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 250, 250, 250),
      appBar: productsListAppBar(context),
      //bottomNavigationBar: navMethod(), // the new nav need tap change page
      //NavigationBar(), // the old nav
      ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
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
                    stream: readPrpducts(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (snapshot.hasError) {
                        return Text('Something went wrong! ${snapshot.error}');
                      } else if (snapshot.hasData) {
                        final productItems = snapshot.data!.toList();
                        final data = snapshot.data!;
                        if (data.isEmpty) {
                          return const Center(
                            child: Text(
                              'لا توجد منتجات ضمن هذه الفئة',
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.w600,
                                fontFamily: "Tajawal",
                                color: Colors.grey,
                              ),
                            ),
                          );
                        }
                        //هنا حالة النجاح في استرجاع البيانات...........................................
                        //String detailsImage = "";

                        else {
                          return ListView.builder(
                            itemCount: productItems.length,
                            itemBuilder: (context, index) => productCard(
                              itemIndex: index,
                              product: productItems[index],
                              press: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        CustomerProdectDetails(
                                      // يرسل المعلومات لصفحة المنتج عشان يعرض التفاصيل
                                      detailsImage: productItems[index].image,
                                      product: productItems[index],
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        }
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

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  //AppBar
  AppBar productsListAppBar(var context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Color.fromARGB(255, 250, 250, 250),
      centerTitle: true,
      title: Text(
        categoryName,
        style: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.w600,
          color: kPrimaryColor,
          fontFamily: "Tajawal",
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
