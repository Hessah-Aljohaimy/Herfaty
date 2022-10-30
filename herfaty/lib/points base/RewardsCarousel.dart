import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:herfaty/points%20base/Reward.dart';
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
    return SizedBox(
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
              width: 160,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(.1),
                    blurRadius: 4.0,
                    spreadRadius: .05,
                  ), //BoxShadow
                ],
              ),
              child: Row(
                children: [
                  Container(
                    // width: 80,
                    // height: 30,
                    child: Text(
                      "الكؤوس",
                      style: TextStyle(
                          color: Color(0xffF19B1A),
                          fontSize: 20,
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
        ));
  }
}

class Rewards extends StatefulWidget {
  const Rewards({super.key});

  @override
  State<Rewards> createState() => _RewardsState();
}

class _RewardsState extends State<Rewards> {
  int points = 0;

  late String rewardclosed10;
  late String rewardclosed50;
  late String rewardclosed100;
  late String rewardclosed200;
  late String rewardclosed500;
  late String rewardopen10;
  late String rewardopen50;
  late String rewardopen100;
  late String rewardopen200;
  late String rewardopen500;
  late Reward reward1;
  late Reward reward2;
  late Reward reward3;
  late Reward reward4;
  late Reward reward5;
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

              return Container(
                height: 200,
                child: ScrollSnapList(
                  itemBuilder: (context, index) {
                    print('entering build items  method ==================');
                    // Reward reward = rewardList[index];

                    // if (RewardsItems[index].title == 'كأس البدء مغلق') {
                    return GestureDetector(
                        child: rewardsCard(
                          rewardCard: RewardsItems[index],
                        ),
                        onTap: () {});
//                       rewardclosed10 = RewardsItems[index].imagePath;
//                     // }
//                     if (RewardsItems[index].title == 'كأس الإتقان مغلق') {
//                       // return GestureDetector(
//                       //     child: rewardsCard(
//                       //       rewardCard: RewardsItems[index],
//                       //     ),
//                       //     onTap: () {});
//                       rewardclosed50 = RewardsItems[index].imagePath;
//                     }
//                     if (RewardsItems[index].title == 'كأس المهارة مغلق') {
//                       // return GestureDetector(
//                       //     child: rewardsCard(
//                       //       rewardCard: RewardsItems[index],
//                       //     ),
//                       //     onTap: () {});
//                       rewardclosed100 = RewardsItems[index].imagePath;
//                     }
//                     if (RewardsItems[index].title == 'كأس الإبداع مغلق') {
//                       // return GestureDetector(
//                       //     child: rewardsCard(
//                       //       rewardCard: RewardsItems[index],
//                       //     ),
//                       //     onTap: () {});
//                       rewardclosed200 = RewardsItems[index].imagePath;
//                     }
//                     if (RewardsItems[index].title == 'كأس الإحتراف مغلق') {
//                       // return GestureDetector(
//                       //     child: rewardsCard(
//                       //       rewardCard: RewardsItems[index],
//                       //     ),
//                       //     onTap: () {});
//                       rewardclosed500 = RewardsItems[index].imagePath;
//                     }

// //============================================================================

//                     if (RewardsItems[index].title == 'كأس البدء مفتوح') {
//                       // return GestureDetector(
//                       //     child: rewardsCard(
//                       //       rewardCard: RewardsItems[index],
//                       //     ),
//                       //     onTap: () {});
//                       rewardopen10 = RewardsItems[index].imagePath;
//                     }
//                     if (RewardsItems[index].title == 'كأس الإتقان مفتوح') {
//                       // return GestureDetector(
//                       //     child: rewardsCard(
//                       //       rewardCard: RewardsItems[index],
//                       //     ),
//                       //     onTap: () {});
//                       rewardopen50 = RewardsItems[index].imagePath;
//                     }
//                     if (RewardsItems[index].title == 'كأس المهارة مفتوح') {
//                       // return GestureDetector(
//                       //     child: rewardsCard(
//                       //       rewardCard: RewardsItems[index],
//                       //     ),
//                       //     onTap: () {});
//                       rewardopen100 = RewardsItems[index].imagePath;
//                     }
//                     if (RewardsItems[index].title == 'كأس الإبداع مفتوح') {
//                       // return GestureDetector(
//                       //     child: rewardsCard(
//                       //       rewardCard: RewardsItems[index],
//                       //     ),
//                       //     onTap: () {});
//                       rewardopen200 = RewardsItems[index].imagePath;
//                     }
//                     if (RewardsItems[index].title == 'كأس الإحتراف مفتوح') {
//                       // return GestureDetector(
//                       //     child: rewardsCard(
//                       //       rewardCard: RewardsItems[index],
//                       //     ),
//                       //     onTap: () {});
//                       rewardopen500 = RewardsItems[index].imagePath;
//                     }
//                     List<Reward> rewardList;
//                     if (points == 0) {
//                       reward1 = new Reward(
//                           imagePath: rewardclosed10, title: 'كأس البدء');
//                       reward2 = new Reward(
//                           imagePath: rewardclosed50, title: 'كأس الإتقان');
//                       reward3 = new Reward(
//                           imagePath: rewardclosed100, title: 'كأس المهارة');
//                       reward4 = new Reward(
//                           imagePath: rewardclosed200, title: 'كأس الإبداع');

//                       reward5 = new Reward(
//                           imagePath: rewardclosed500, title: 'كأس الإحتراف');

//                       // for (int i = 0; i < 5; i++) {}
//                       return GestureDetector(
//                           child: rewardsCard(
//                             rewardCard: reward1,
//                           ),
//                           onTap: () {});
//                     }
//                     return GestureDetector(
//                         child: rewardsCard(
//                           rewardCard: reward1,
//                         ),
//                         onTap: () {});

//                     // return GestureDetector(
//                     //     child: rewardsCard(
//                     //       rewardCard: RewardsItems[index],
//                     //     ),
//                     //     onTap: () {});
//                     // if (points == 0) {
//                     //   if (RewardsItems[index].title == 'كأس البدء مغلق') {

//                     //   }
//                     // }

//                     // return GestureDetector(
//                     //     child: rewardsCard(

//                     //     ),
//                     //     onTap: () {});
                  },
                  itemCount: 5,
                  itemSize: 150,
                  onItemFocus: (index) {},
                  dynamicItemSize: true,
                  scrollDirection: Axis.horizontal,
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
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.1),
              blurRadius: 4.0,
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
    return Row(
      children: [
        Padding(
            padding: EdgeInsets.all(5.0),
            child: new LinearPercentIndicator(
              width: MediaQuery.of(context).size.width - 40,
              animation: true,
              lineHeight: 20.0,
              animationDuration: 2000,
              percent: pt,
              center: Text(
                "${pt * 100}%",
                style: new TextStyle(
                  fontSize: 15.0,
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