// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:herfaty/CustomerProducts/CustomerProductDetails.dart';
import 'package:herfaty/CustomerProducts/productCard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:herfaty/OwnerProducts/OwnerProductsList.dart';
import 'package:herfaty/ShopOwnerOrder/list.dart';
import 'package:herfaty/models/Product1.dart';
import 'package:herfaty/constants/color.dart';
// import 'package:dartarabic/dartarabic.dart';

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

const Iterable<int> arabicTashkelChar = [
  1617,
  124,
  1614,
  124,
  1611,
  124,
  1615,
  124,
  1612,
  124,
  1616,
  124,
  1613,
  124,
  1618,
  625,
  627,
  655,
];

enum Menu { itemOne, itemTwo, itemThree }

final List<String> productsName = [];
bool takeName = false;
String CatName = '';

Map catCheck = {
  "الخرز والإكسسوار": false,
  "الفخاريات": false,
  "الحياكة والتطريز": false,
  "فنون الورق والتلوين": false,
};

List<String> cat1 = [];
List<String> cat2 = [];
List<String> cat3 = [];
List<String> cat4 = [];

class _CustomerProductsListState extends State<CustomerProductsList> {
  //variable to store the category name from categories page
  Stream<List<Product1>> readPrpducts() => FirebaseFirestore.instance
      .collection('Products')
      .where("categoryName", isEqualTo: widget.categoryName)
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => Product1.fromJson(doc.data())).toList());

  void initState() {
    CatName = widget.categoryName;
    Map catCheck = {
      "الخرز والإكسسوار": false,
      "الفخاريات": false,
      "الحياكة والتطريز": false,
      "فنون الورق والتلوين": false,
    };
    cat1.clear();
    cat2.clear();
    cat3.clear();
    cat4.clear();
  }

  //======================================================================================
  String typeOfSort = "الأحدث";

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
              //تبعد لي البوكس اللي يعرض المنتجات عن الشريط العلوي
              const SizedBox(height: 13),
              Expanded(
                child: Stack(
                  children: [
                    //This is to list all of our items fetched from the DB========================

                    StreamBuilder<List<Product1>>(
                      stream: readPrpducts(),
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

                          productItems.sort((a, b) {
                            return DateTime.parse(b.proudctDate)
                                .compareTo(DateTime.parse(a.proudctDate));
                          });
                          //(cat1.contains(productItems[i].name.replaceAll('ه', "ة")))
                          if (cat1.isEmpty &&
                              widget.categoryName == "الخرز والإكسسوار") {
                            for (var i = 0; i < productItems.length; i++) {
                              if ((cat1.contains(productItems[i].name)) ==
                                      false &&
                                  productItems[i].categoryName ==
                                      "الخرز والإكسسوار") {
                                cat1.add(productItems[i].name);
                              }
                            }
                          }

                          if (cat2.isEmpty &&
                              widget.categoryName == "الفخاريات") {
                            for (var i = 0; i < productItems.length; i++) {
                              if ((cat2.contains(productItems[i].name)) ==
                                      false &&
                                  productItems[i].categoryName == "الفخاريات") {
                                cat2.add(productItems[i].name);
                              }
                            }
                          }

                          if (cat3.isEmpty &&
                              widget.categoryName == "الحياكة والتطريز") {
                            for (var i = 0; i < productItems.length; i++) {
                              if ((cat3.contains(productItems[i].name)) ==
                                      false &&
                                  productItems[i].categoryName ==
                                      "الحياكة والتطريز") {
                                cat3.add(productItems[i].name);
                              }
                            }
                          }

                          if (cat4.isEmpty &&
                              widget.categoryName == "فنون الورق والتلوين") {
                            for (var i = 0; i < productItems.length; i++) {
                              if ((cat4.contains(productItems[i].name)) ==
                                      false &&
                                  productItems[i].categoryName ==
                                      "فنون الورق والتلوين") {
                                cat4.add(productItems[i].name);
                              }
                            }
                          }
                          // if( catCheck[widget.categoryName]==false){

                          //   for (var i = 0; i < productItems.length; i++) {

                          //     if((productsName.contains(productItems[i].name))==false){

                          //                               productsName.add(productItems[i].name);

                          //     }
                          //                                        }

                          //                catCheck[widget.categoryName]=true;
                          //    takeName=true;
                          // }
                          if (typeOfSort == 'itemThree') {
                            productItems.sort((a, b) {
                              return (b.price).compareTo((a.price));
                            });
                          }
                          if (typeOfSort == 'itemTwo') {
                            productItems.sort((a, b) {
                              return (a.price).compareTo((b.price));
                            });
                          }

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
      backgroundColor: Colors.white,
      shadowColor: Color.fromARGB(255, 39, 141, 134),
      elevation: 3,
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
      actions: <Widget>[
        // This button presents popup menu items.
        IconButton(
          padding: EdgeInsets.only(right: 20),
          icon: const Icon(
            Icons.search,
            color: Color.fromARGB(255, 26, 96, 91),
            size: 22.0,
          ),
          onPressed: () {
            showSearch(
              context: context,
              delegate: mySearch(),
            );
          },
        ),
        PopupMenuButton<Menu>(
            icon: Icon(
              Icons.sort_rounded,
              color: Color.fromARGB(255, 26, 96, 91),
              size: 22.0,
            ),
            // Callback that sets the selected popup menu item.
            onSelected: (Menu item) {
              setState(() {
                typeOfSort = item.name;
              });
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<Menu>>[
                  const PopupMenuItem<Menu>(
                    value: Menu.itemTwo,
                    child: Text('الأسعار من الأقل'),
                  ),
                  const PopupMenuItem<Menu>(
                    value: Menu.itemThree,
                    child: Text('الأسعار من الأعلى'),
                  ),
                  const PopupMenuItem<Menu>(
                    value: Menu.itemOne,
                    child: Text('الأحدث'),
                  ),
                ]),
      ],
    );
  }
}

class mySearch extends SearchDelegate {
  Stream<List<Product1>> readPrpducts() => FirebaseFirestore.instance
      .collection('Products')
      .where("categoryName", isEqualTo: CatName)
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => Product1.fromJson(doc.data())).toList());


  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(
          Icons.clear,
          color: Color.fromARGB(255, 26, 96, 91),
          size: 22.0,
        ),
        onPressed: () {
          if (query.isEmpty) {
            close(context, null);
          } else {
            query = '';
          }
        },
      ),
      // TODO: implement buildActions
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      padding: EdgeInsets.only(right: 20),
      icon: const Icon(
        Icons.arrow_back,
        color: Color.fromARGB(255, 26, 96, 91),
        size: 22.0,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
        image: AssetImage('assets/images/cartBack1.png'),
        fit: BoxFit.cover,
      )),
      child: StreamBuilder<List<Product1>>(
        stream: readPrpducts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Text('Something went wrong! ${snapshot.error}');
          }
          if (snapshot.hasData) {
            //هنا حالة النجاح في استرجاع البيانات...........................................
            final data = snapshot.data!;
            if (data.isEmpty) {
              return const Center(
                child: Text(
                  'لا توجد منتجات بهذا الاسم',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                    fontFamily: "Tajawal",
                    color: Colors.grey,
                  ),
                ),
              );
            }  else if(query.trim().isEmpty){
                               return const Center(
                                child: Text(
                                  'لا توجد منتجات بهذا الاسم',
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: "Tajawal",
                                    color: Colors.grey,
                                  ),
                                ),
                              );
                            }
                            else {
              final productItems = snapshot.data!.toList();
              List<Product1> productItems2 = [];
              for (var i = 0; i < productItems.length; i++) {
                if (productItems[i].name.contains(query)

                    //     ||
                    //     // productItems[i].name.replaceAll('ة', "ه")
                    //     productItems[i].name.replaceAll('\u0622', '\u0627')
                    // .replaceAll('\u0623', '\u0627')
                    // .replaceAll('\u0625', '\u0627')
                    // .replaceAll(RegExp(String.fromCharCodes(arabicTashkelChar)), '').contains(query)

                    ) {
                  productItems2.add((productItems[i]));
                }
              }

              if (productItems2.isEmpty) {
                return const Center(
                  child: Text(
                    'لا توجد منتجات بهذا الاسم',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600,
                      fontFamily: "Tajawal",
                      color: Colors.grey,
                    ),
                  ),
                );
              }

              return ListView.builder(
                itemCount: productItems2.length,
                itemBuilder: (context, index) => productCard(
                  itemIndex: index,
                  product: productItems2[index],
                  press: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CustomerProdectDetails(
                          // يرسل المعلومات لصفحة المنتج عشان يعرض التفاصيل
                          detailsImage: productItems2[index].image,
                          product: productItems2[index],
                        ),
                      ),
                    );
                  },
                ),
              );
              //..................................................................................
            }
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions

  List<String> Suggestions = [];

    if (CatName == "الخرز والإكسسوار") {

       for (var i = 0; i < cat1.length; i++) {
      if(cat1[i].contains(query)){
        Suggestions.add(cat1[i]);
      }
    }
    } else if (CatName == "الفخاريات") {



       for (var i = 0; i < cat2.length; i++) {
      if(cat2[i].contains(query)){
        Suggestions.add(cat2[i]);
      }

    
    } }
    else if (CatName == "الحياكة والتطريز") {



       for (var i = 0; i < cat3.length; i++) {
      if(cat3[i].contains(query)){
        Suggestions.add(cat3[i]);
      }

       }
    } else {

       for (var i = 0; i < cat4.length; i++) {
      if(cat4[i].contains(query)){
        Suggestions.add(cat4[i]);
      }

       }
   
    }
    // for (var i = 0; i < productsName.length; i++) {
    //   if(productsName[i].contains(query)){
    //     Suggestions.add(productsName[i]);
    //   }
    // }
    return ListView.builder(
      itemCount: Suggestions.length,
      itemBuilder: (context, index) {
        final Suggestion = Suggestions[index];

        return ListTile(
          title: Text(Suggestion),
          onTap: () {
            query = Suggestion;
            showResults(context);
          },
        );
      },
    );
  }
}
