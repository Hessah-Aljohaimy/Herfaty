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
enum Menu { itemOne, itemTwo, itemThree}
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
String typeOfSort="العادي";

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
              Container(
                 padding: EdgeInsets.symmetric(horizontal: 40),
                 // margin: EdgeInsets.symmetric(horizontal: 10,vertical: 9),
          child:  TextField(
            
                onChanged: (value) {
          searchString=value;
        },
  
  decoration: InputDecoration(
  contentPadding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 25),    
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Color.fromARGB(255, 26, 96, 91)),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide:
            BorderSide(width: 2, color: Color.fromARGB(255, 26, 96, 91)),
      ),
      hintText: "البحث",
      suffixIcon: Icon(Icons.search
      , color: Color.fromARGB(255, 26, 96, 91),),
      // border: OutlineInputBorder(
      //     borderRadius: BorderRadius.all(Radius.circular(29.0)))
          ),
),
              ),
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
                          var serchList=[];
                           if(typeOfSort=='itemThree'){
                               productItems.sort((a, b) {
                          return (b.price)
                              .compareTo((a.price));
                        });
                           }

  if(typeOfSort=='itemTwo'){
                               productItems.sort((a, b) {
                          return (a.price)
                              .compareTo((b.price));
                        });
                           }


                            for (var i = 0; i < productItems.length; i++) {
                              if(searchString!="" && productItems[i].name.contains(searchString)){
                               serchList.add(productItems[i]);}
                                       }      
                                       
                                     if(searchString.isNotEmpty && serchList.isEmpty)  {
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
                                  searchString="";
                                 print(serchList.isEmpty);
                                   print('sssssssssssssss');
                            
                           
                        
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
                            if(serchList.isEmpty){
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
                      
                         if(serchList.isNotEmpty){

       return ListView.builder(
                              itemCount: serchList.length,
                              itemBuilder: (context, index) => productCard(
                                itemIndex: index,
                                product: serchList[index],
                                press: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          CustomerProdectDetails(
                                        // يرسل المعلومات لصفحة المنتج عشان يعرض التفاصيل
                                        detailsImage: serchList[index].image,
                                        product: serchList[index],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            );

                          }
                          else {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
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
       

        actions: <Widget>[
          // This button presents popup menu items.
          PopupMenuButton<Menu>(
                    
            icon: Icon(
              Icons.sort_rounded ,color: Color.fromARGB(255, 26, 96, 91),
         size: 22.0,
            ),
              // Callback that sets the selected popup menu item.
              onSelected: (Menu item) {
                setState(() {
                  typeOfSort = item.name;
                  print(typeOfSort);
                  print('ssssssssssssssssssssssssss');
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
                      child: Text('بلا ترتيب'),
                    ),
                  ]),
        ],

//  actions: <Widget>[
//           IconButton(
//             icon: const Icon(Icons.sort_rounded ,color: Color.fromARGB(255, 26, 96, 91),
//           size: 22.0,),
//             onPressed: () {
               
//                 items: dropDown.map<DropdownMenuItem<String>>((String value) {
//                   return DropdownMenuItem<String>(
//                     value: value,
//                     child: Text(value),
//                   );
//                 }).toList();
//                 onChanged: (String value) {
                
//                 typeOfSort=value;
                
                
//                 //  setState(() {});
//                 };
//             },
//           ),
        
//         ],


    );
    
  }
  }