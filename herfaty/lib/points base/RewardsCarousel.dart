import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:herfaty/points%20base/Reward.dart';
import 'package:herfaty/points%20base/reviewOwnerPanle.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';

class RewardsCarousel extends StatefulWidget {
  const RewardsCarousel({super.key});

  @override
  State<RewardsCarousel> createState() => _RewardsCarouselState();
}

class _RewardsCarouselState extends State<RewardsCarousel> {
  @override
  Widget build(BuildContext context) {
    print('entering rewards scroll method ==================');
    return Row(
      children: [
        SizedBox(
            height: 60,
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                SizedBox(
                  width: 5,
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  width: 139,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.amber),
                    boxShadow: [
                      BoxShadow(
                        //color: Colors.black.withOpacity(.1),
                        color: Colors.amber.withOpacity(.7),
                        blurRadius: 6.0,
                        spreadRadius: .05,
                      ), //BoxShadow
                    ],
                  ),
                  // decoration: BoxDecoration(
                  //   color: Colors.white,
                  //   borderRadius: BorderRadius.circular(20),
                  //   boxShadow: [
                  //     BoxShadow(
                  //       color: Colors.black.withOpacity(.1),
                  //       blurRadius: 4.0,
                  //       spreadRadius: .05,
                  //     ), //BoxShadow
                  //   ],
                  // ),
                  child: Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.all(3),
                        // width: 80,
                        // height: 30,
                        child: Text(
                          "الكؤوس",
                          style: TextStyle(
                              color: Color(0xffF19B1A),
                              fontSize: 19,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Tajawal"),
                        ),
                      ),
                      Positioned(
                        bottom: 50,
                        top: 50,
                        child: Image.asset(
                          "assets/images/points_trophies/icons8-trophy.png",
                          width: 40,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
              ],
            )),
        SizedBox(
          width: 25,
        ),
        reviewOwnerPanle()
      ],
    );
  }
}

class Rewards extends StatefulWidget {
  const Rewards({super.key});

  @override
  State<Rewards> createState() => _RewardsState();
}

class _RewardsState extends State<Rewards> {
  int points = 0;
  int position = 0;

  void initState() {
    print("this is Rewards initState====");
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    String thisOwnerId = user!.uid;
    setOwnerPoints(thisOwnerId);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('entering build Rewards  method ==================');
    return SizedBox(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        StreamBuilder<List<Reward>>(
          stream: readRewards(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text(':هناك خطأ في استعراض الكؤوس \n ${snapshot.error}');
            } else if (snapshot.hasData) {
              final RewardsItems = snapshot.data!.toList();
              final RewardsItemslist;

              //sort the list
              RewardsItems.sort((a, b) {
                return a.order.compareTo(b.order);
              });

              //new list for the rewards ordered
              List<Reward> RewardsItemsOrderd = [];

              //fill the new list
              if (points == 0) {
                RewardsItemsOrderd.add(RewardsItems[1]);
                RewardsItemsOrderd.add(RewardsItems[3]);
                RewardsItemsOrderd.add(RewardsItems[5]);
                RewardsItemsOrderd.add(RewardsItems[7]);
                RewardsItemsOrderd.add(RewardsItems[9]);
              } else {
                for (int i = 0; i < RewardsItems.length; i++) {
                  if (points >= 500) {
                    RewardsItemsOrderd.add(RewardsItems[0]);
                    RewardsItemsOrderd.add(RewardsItems[2]);
                    RewardsItemsOrderd.add(RewardsItems[4]);
                    RewardsItemsOrderd.add(RewardsItems[6]);
                    RewardsItemsOrderd.add(RewardsItems[8]);
                  } else if (points >= 200) {
                    RewardsItemsOrderd.add(RewardsItems[0]);
                    RewardsItemsOrderd.add(RewardsItems[2]);
                    RewardsItemsOrderd.add(RewardsItems[4]);
                    RewardsItemsOrderd.add(RewardsItems[6]);
                    RewardsItemsOrderd.add(RewardsItems[9]);
                  } else if (points >= 100) {
                    RewardsItemsOrderd.add(RewardsItems[0]);
                    RewardsItemsOrderd.add(RewardsItems[2]);
                    RewardsItemsOrderd.add(RewardsItems[4]);
                    RewardsItemsOrderd.add(RewardsItems[7]);
                    RewardsItemsOrderd.add(RewardsItems[9]);
                  } else if (points >= 50) {
                    RewardsItemsOrderd.add(RewardsItems[0]);
                    RewardsItemsOrderd.add(RewardsItems[2]);
                    RewardsItemsOrderd.add(RewardsItems[5]);
                    RewardsItemsOrderd.add(RewardsItems[7]);
                    RewardsItemsOrderd.add(RewardsItems[9]);
                  } else if (points >= 10) {
                    RewardsItemsOrderd.add(RewardsItems[0]);
                    RewardsItemsOrderd.add(RewardsItems[3]);
                    RewardsItemsOrderd.add(RewardsItems[5]);
                    RewardsItemsOrderd.add(RewardsItems[7]);
                    RewardsItemsOrderd.add(RewardsItems[9]);
                  }
                }
              }
              return Container(
                height: 200,
                child: Column(
                  children: [
                    Flexible(
                      child: ScrollSnapList(
                        itemBuilder: (context, index) {
                          print(
                              'entering build items  method ==================');
                          // Reward reward = rewardList[index];

                          // if (RewardsItems[index].title == 'كأس البدء مغلق') {
                          return GestureDetector(
                              child: rewardsCard(
                                rewardCard: RewardsItemsOrderd[index],
                              ),
                              onTap: () {});
                        },
                        itemCount: 5,
                        itemSize: 150,
                        onItemFocus: (index) {
                          print(' this is index ${index}');
                          setState(() {
                            position = index;
                          });
                        },
                        dynamicItemSize: true,
                        scrollDirection: Axis.horizontal,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    AnimatedPageIndicatorFb1(
                      currentPage: position,
                      numPages: 5,
                      gradient: LinearGradient(colors: [
                        Color.fromARGB(255, 130, 130, 130),
                        Color.fromARGB(255, 126, 126, 126),
                      ]),
                      activeGradient: LinearGradient(colors: [
                        Color.fromARGB(255, 96, 170, 168),
                        Color.fromARGB(255, 97, 172, 170),
                      ]),
                    )
                  ],
                ),
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        )
      ],
    ));
  }

  Stream<List<Reward>> readRewards() => FirebaseFirestore.instance
      .collection('Rewards')
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => Reward.fromJson(doc.data())).toList());

  //===================================================
  //reding the current user earned points
  Future<void> setOwnerPoints(String thisOwnerId) async {
    int existedPoints = await getpoints(thisOwnerId);
    if (existedPoints != 0) {
      setState(() {
        points = existedPoints;
      });
    } else {
      setState(() {
        points = 0;
      });
    }
  }

  //===================================================
  Future<int> getpoints(String thisOwnerId) async {
    int OwnerPoints = 0;
    final OwnersDoc = await FirebaseFirestore.instance
        .collection('shop_owner')
        .where("id", isEqualTo: thisOwnerId)
        .get();
    if (OwnersDoc.size > 0) {
      var data = OwnersDoc.docs.elementAt(0).data() as Map;
      OwnerPoints = data["points"];
      print("existed points is ${OwnerPoints}");
    }
    return OwnerPoints;
  }
}

//===========================Rewards Cards================
class rewardsCard extends StatelessWidget {
  final Reward rewardCard;

  const rewardsCard({
    Key? key,
    required this.rewardCard,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        width: 150,
        height: 154,
        // Within the SecondRoute widget
        padding: const EdgeInsets.all(10),

        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.amber),
          boxShadow: [
            BoxShadow(
              //color: Colors.black.withOpacity(.1),
              color: Colors.amber.withOpacity(.7),
              blurRadius: 6.0,
              spreadRadius: .05,
            ), //BoxShadow
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Image.asset(
                rewardCard.imagePath,
                height: 120.0,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(rewardCard.title,
                style: TextStyle(
                    color: Color.fromARGB(255, 66, 66, 66),
                    fontWeight: FontWeight.bold,
                    fontFamily: "Tajawal",
                    fontSize: 16)),
          ],
        ),
      ),
    );
  }
}

//#494B4A
class Indicator extends StatefulWidget {
  const Indicator({super.key});

  @override
  State<Indicator> createState() => _IndicatorState();
}

class _IndicatorState extends State<Indicator> {
  int points = 0;
  double pt = 0;
  void initState() {
    print("this is Rewards initState====");
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    String thisOwnerId = user!.uid;
    setOwnerPoints(thisOwnerId);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // if (points == 0) {
    //   pt = 0;
    // } else if (points >= 10 && points < 50) {
    //   pt = 0.2;
    // } else if (points >= 50 && points < 100) {
    //   pt = 0.4;
    // } else if (points >= 100 && points < 200) {
    //   pt = 0.6;
    // }
    pt = points / 500;
    if (points > 500) {
      pt = 1;
    }
    return Row(
      children: [
        Padding(
            padding: EdgeInsets.all(5.0),
            child: new LinearPercentIndicator(
              width: MediaQuery.of(context).size.width - 60,
              animation: true,
              lineHeight: 15.0,
              animationDuration: 2000,
              percent: pt,
              center: Text(
                "${pt * 100}%",
                style: new TextStyle(
                  fontSize: 13.0,
                  fontWeight: FontWeight.w800,
                  color: Color(0xff545454),
                ),
              ),
              barRadius: const Radius.circular(16),
              progressColor: Color(0xffFFC71F),
              backgroundColor: Color(0xffD9D9D9),
            )),
        Positioned(
          bottom: 50,
          top: 50,
          child: Image.asset(
            "assets/images/points_trophies/icons8-trophy.png",
            width: 22,
          ),
        ),
      ],
    );
  }

  //===================================================
  //reding the current user earned points
  Future<void> setOwnerPoints(String thisOwnerId) async {
    int existedPoints = await getpoints(thisOwnerId);
    if (existedPoints != 0) {
      setState(() {
        points = existedPoints;
      });
    } else {
      setState(() {
        points = 0;
      });
    }
  }

  //===================================================
  Future<int> getpoints(String thisOwnerId) async {
    int OwnerPoints = 0;
    final OwnersDoc = await FirebaseFirestore.instance
        .collection('shop_owner')
        .where("id", isEqualTo: thisOwnerId)
        .get();
    if (OwnersDoc.size > 0) {
      var data = OwnersDoc.docs.elementAt(0).data() as Map;
      OwnerPoints = data["points"];
      print("existed points is ${OwnerPoints}");
    }
    return OwnerPoints;
  }
}

//#FFC71F
//Color(0xffA6A6A6),
//A6A6A6
class AnimatedPageIndicatorFb1 extends StatelessWidget {
  const AnimatedPageIndicatorFb1(
      {Key? key,
      required this.currentPage,
      required this.numPages,
      this.dotHeight = 10,
      this.activeDotHeight = 10,
      this.dotWidth = 10,
      this.activeDotWidth = 20,
      this.gradient =
          const LinearGradient(colors: [Color(0xff4338CA), Color(0xff6D28D9)]),
      this.activeGradient =
          const LinearGradient(colors: [Color(0xff4338CA), Color(0xff6D28D9)])})
      : super(key: key);

  final int
      currentPage; //the index of the active dot, i.e. the index of the page you're on
  final int
      numPages; //the total number of dots, i.e. the number of pages your displaying

  final double dotWidth; //the width of all non-active dots
  final double activeDotWidth; //the width of the active dot
  final double activeDotHeight; //the height of the active dot
  final double dotHeight; //the height of all dots
  final Gradient gradient; //the gradient of all non-active dots
  final Gradient activeGradient; //the gradient of the active dot

  double _calcRowSize() {
    //Calculates the size of the outer row that creates spacing that is equivalent to the width of a dot
    final int widthFactor = 2; //assuming spacing is equal to the width of a dot
    return (dotWidth * numPages * widthFactor) + activeDotWidth - dotWidth;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: _calcRowSize(),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(
          numPages,
          (index) => AnimatedPageIndicatorDot(
            isActive: currentPage == index,
            gradient: gradient,
            activeGradient: activeGradient,
            activeWidth: activeDotWidth,
            activeHeight: activeDotHeight,
          ),
        ),
      ),
    );
  }
}

class AnimatedPageIndicatorDot extends StatelessWidget {
  const AnimatedPageIndicatorDot(
      {Key? key,
      required this.isActive,
      this.height = 10,
      this.width = 10,
      this.activeWidth = 20,
      this.activeHeight = 10,
      required this.gradient,
      required this.activeGradient})
      : super(key: key);

  final bool isActive;
  final double height;
  final double width;
  final double activeWidth;
  final double activeHeight;
  final Gradient gradient;
  final Gradient activeGradient;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      width: isActive ? activeWidth : width,
      height: isActive ? activeHeight : height,
      duration: Duration(milliseconds: 300),
      decoration: BoxDecoration(
          gradient: isActive ? activeGradient : gradient,
          borderRadius: BorderRadius.all(Radius.circular(30))),
    );
  }
}
