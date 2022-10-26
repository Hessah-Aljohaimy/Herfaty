// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:herfaty/CustomerProducts/CustomerProductDetails.dart';
import 'package:herfaty/CustomerProducts/productCard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:herfaty/models/Product1.dart';
import 'package:herfaty/constants/color.dart';

class CustomerProductsList extends StatefulWidget {
  String categoryName;

  CustomerProductsList({
    required categoryName,
    Key? key,
  })  : this.categoryName = categoryName,
        super(key: key);

  @override
  State<CustomerProductsList> createState() => _CustomerProductsListState();
}

class _CustomerProductsListState extends State<CustomerProductsList> {
  //variable to store the category name from categories page
  Stream<List<Product1>> readPrpducts() => FirebaseFirestore.instance
      .collection('Products')
      .where("categoryName", isEqualTo: widget.categoryName)
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => Product1.fromJson(doc.data())).toList());

 Stream<List<Product1>> readSerach(String srerch) => FirebaseFirestore.instance
      .collection('Products')
      .where("categoryName", isEqualTo: widget.categoryName)
      .where('name', isEqualTo: srerch)
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => Product1.fromJson(doc.data())).toList());

  TextEditingController editingController = TextEditingController();
 
  
  //======================================================================================
String searchString = "";

List<Product1> forSearch=[];
List<Product1> allPro=[];


//  @override
//   void initState() {
//     forSearch.addAll(productItems);
//     super.initState();
//   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color.fromARGB(255, 250, 250, 250),
      appBar: productsListAppBar(context),
      ///////////////////////////////////////////////////////////////////////////////////////////////
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
            image: AssetImage('assets/images/cartBack1.png'),
            fit: BoxFit.cover,
          )),
          child: Column(
            children: [
            TextFormField(
               autovalidateMode: AutovalidateMode.onUserInteraction,
                onChanged: (value) {
          searchString=value;
        },
  
  decoration: InputDecoration(
    
      labelText: "البحث",
      hintText: "البحث",
      suffixIcon: Icon(Icons.search),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)))),
),
              //تبعد لي البوكس اللي يعرض المنتجات عن الشريط العلوي
              const SizedBox(height: 15),
              Expanded(
                child: Stack(
                  children: [
                    //This is to list all of our items fetched from the DB========================
                    StreamBuilder<List<Product1>>(
                      stream: (searchString != "") ?  readSerach(searchString) :readPrpducts(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                        if (snapshot.hasError) {
                          return Text(
                              'Something went wrong! ${snapshot.error}');
                        } else if (snapshot.hasData) {
                          final productItems = snapshot.data!.toList();
                          final data = snapshot.data!;
                          allPro.addAll(productItems);
                          print(searchString);
                          searchString = "";
                                                    print('aaaaaaaaaaaaaaaa');

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
                          return const Center(
                              child: CircularProgressIndicator());
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
        widget.categoryName,
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
  
 void filterSearchResults(String query) {
    List<Product1> results = [];
    if (query.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = allPro;
    } else {
      results = allPro
          .where((name) =>
          "name".toLowerCase().contains(query.toLowerCase()))
          .toList();
      // we use the toLowerCase() method to make it case-insensitive
    }

    setState(() {
      forSearch=results;
    });
}


}
