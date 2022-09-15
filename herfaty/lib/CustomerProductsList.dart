import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:herfaty/CustomerProductDetails.dart';
import 'package:herfaty/constants/size.dart';
import 'package:herfaty/productCard.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:herfaty/Product1.dart';
import 'package:herfaty/screens/customer_base_screen.dart';

import 'constants/color.dart';
import 'constants/icons.dart';

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
      backgroundColor: Colors.white,
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

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

/*
//NvigationBar
  GNav NavigationBar() {
    return GNav(
      backgroundColor: Colors.white, //should change the color
      color: Color.fromARGB(255, 26, 96, 91),
      activeColor: Color.fromARGB(255, 26, 96, 91),
      tabBackgroundColor: Colors.grey.shade100,
      gap: 8,
      padding: EdgeInsets.all(16),
      tabs: const [
        GButton(
          icon: Icons.home,
          text: 'الرئيسية',
        ),
        GButton(
          icon: Icons.favorite_border,
          text: 'المفضلة',
        ),
        GButton(
          icon: Icons.settings, //change it
          text: 'السلة',
        ),
        GButton(
          icon: Icons.search,
          text: 'تسجيل خروج',
        ),
      ],
    );
  }*/

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

/*

class nav extends StatefulWidget {
  const nav({Key? key}) : super(key: key);

  @override
  _navState createState() => _navState();
}

class _navState extends State<customerBaseScreen> {
  int _selectedIndex = -1;

  static const List<Widget> _widgetOptions = <Widget>[
    customerHomeScreen(),
    Cart(),
    customerHomeScreen(),
    customerHomeScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: navMethod(),
    );
  }

  BottomNavigationBar navMethod() {
    return BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: kPrimaryColor,
        backgroundColor: Colors.white,
        elevation: 0,
        items: [
          BottomNavigationBarItem(
            activeIcon: Image.asset(
              icFeatured,
              height: kBottomNavigationBarItemSize,
            ),
            icon: Image.asset(
              icFeaturedOutlined,
              height: kBottomNavigationBarItemSize,
            ),
            label: "الرئيسية",
          ),
          BottomNavigationBarItem(
            activeIcon: Image.asset(
              icLearning,
              height: kBottomNavigationBarItemSize,
            ),
            icon: Image.asset(
              icLearningOutlined,
              height: kBottomNavigationBarItemSize,
            ),
            label: "سلتي",
          ),
          BottomNavigationBarItem(
            activeIcon: Image.asset(
              icWishlist,
              height: kBottomNavigationBarItemSize,
            ),
            icon: Image.asset(
              icWishlistOutlined,
              height: kBottomNavigationBarItemSize,
            ),
            label: "مفضلاتي",
          ),
          BottomNavigationBarItem(
            activeIcon: Image.asset(
              icSetting,
              height: kBottomNavigationBarItemSize,
            ),
            icon: Image.asset(
              icSettingOutlined,
              height: kBottomNavigationBarItemSize,
            ),
            label: "تسجيل الخروج",
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        });
  }
}
*/
