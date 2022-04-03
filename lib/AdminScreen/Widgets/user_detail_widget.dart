import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:usdt_beta/Controller/referal_controller.dart';
import 'package:usdt_beta/UI/ReferalScreen/Widget/ref_widget.dart';
import 'package:usdt_beta/sizeConfig.dart';
import 'package:usdt_beta/style/color.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import '../../Model/user_model_list.dart';


///New Code Version 25.3

ReferenceModelList referanceModelList;

getReferralInfoAdmin (String selectedUserId) async{
  var firebaseFirestore = FirebaseFirestore.instance;
  log("entered into referal model info");
  DocumentSnapshot documentSnapshot = await firebaseFirestore.collection('References').doc(selectedUserId).get();
  final Map map = documentSnapshot.data();
  log(map.toString());
  if(map == null)
  {
    referanceModelList = ReferenceModelList(list: []);
  }
  else {
    referanceModelList = ReferenceModelList.fromMap(map);
  }

  log("length is ${referanceModelList.list.length}" );
  log("wtfffffffffffff");

  final snap = await firebaseFirestore.collection('refShown').doc(selectedUserId).get();

  final Map map2 = snap.data();
  log(map2.toString());
}



class UserDetailWidget extends StatelessWidget {
  const UserDetailWidget({Key key, this.allUserData}) : super(key: key);
  final dynamic allUserData;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColorLight,
      appBar: AppBar(
        backgroundColor: bgColor,
        title: Text(allUserData.name),
      ),
      body: FutureBuilder(
          future: Future.delayed(Duration(seconds: 0)),
          builder: (context,s) {
            return ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Neumorphic(
                    style: NeumorphicStyle(depth: -3, color: bgColor),
                    padding: EdgeInsets.all(6),
                    //curve: Neumorphic.DEFAULT_CURVE,
                    child: Container(
                        height: SizeConfig.screenHeight * 0.25,
                        child: Column(
                          children: [
                            CircleAvatar(
                              radius: 45,
                              backgroundImage:
                              // (allUserData.userImage != null || allUserData.userImage.toString().isNotEmpty)
                              //     ? NetworkImage(allUserData.userImage) :
                              AssetImage('assets/images/man.png'),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 80),
                              child: Divider(
                                color: Colors.white,
                                thickness: 3,
                              ),
                            ),
                            Text(
                              'Name : ${allUserData.name}',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: SizeConfig.defaultSize),
                            ),
                            Text(
                              'Email : ${allUserData.email}',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: SizeConfig.defaultSize),
                            ),
                            Text(
                              'Password : ${allUserData.password}',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: SizeConfig.defaultSize),
                            ),
                            Text(
                              'InvestmentAmount :\$ ${allUserData.investmentAmount}',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: SizeConfig.defaultSize),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 80),
                              child: Divider(
                                color: Colors.white,
                                thickness: 3,
                              ),
                            ),
                          ],
                        )),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Divider(
                    color: Colors.white,
                    thickness: 3,
                  ),
                ),
                Text(
                  'Referals',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 19),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Divider(
                    color: Colors.white,
                    thickness: 3,
                  ),
                ),
                FutureBuilder(
                    future: getReferralInfoAdmin(allUserData.uid),
                    builder: (context, s) {
                      if (s.connectionState == ConnectionState.done)
                        return ListView(
                          shrinkWrap: true,
                          children: [
                            Container(
                              height: SizeConfig.screenHeight * 0.9,
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.vertical,
                                  itemCount:
                                  referanceModelList.list.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: RefWidget(
                                        refModel:
                                        referanceModelList.list[index],
                                      ),
                                    );
                                  }),
                            )
                          ],
                        );
                      else
                        return Center(
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        );
                    })
                // GetX<ReferalController>(
                //     init: Get.put<ReferalController>(ReferalController()),
                //     builder: (ReferalController refController) {
                //       if (refController.referal1 != null) {
                //         return Container(
                //           height: SizeConfig.screenHeight * 0.9,
                //           child: ListView.builder(
                //               shrinkWrap: true,
                //               scrollDirection: Axis.vertical,
                //               itemCount: refController.referal1.length,
                //               itemBuilder: (context, index) {
                //                 return Padding(
                //                   padding: const EdgeInsets.all(8.0),
                //                   child: RefWidget(
                //                     oldRefModel: refController.referal1[index],
                //                   ),
                //                 );
                //               }),
                //         );
                //       } else {
                //         return Center(
                //           child: Text(
                //             'Referal Loading...',
                //             style: TextStyle(fontSize: 20),
                //           ),
                //         );
                //       }
                //     })
              ],
            );
          }
      ),
    );
  }
}