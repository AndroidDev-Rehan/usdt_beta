import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:usdt_beta/Controller/admin_controller.dart';
import 'package:usdt_beta/Controller/referal_controller.dart';
import 'package:usdt_beta/Controller/regular_trade_controller.dart';
import 'package:usdt_beta/Controller/userController.dart';
import 'package:usdt_beta/Services/database.dart';
import 'package:usdt_beta/UI/home_screem/home_widgets/copy_trade_screen.dart';
import 'package:usdt_beta/UI/home_screem/home_widgets/currency_card.dart';
import 'package:usdt_beta/UI/home_screem/home_widgets/regular_trading.dart';
import 'package:usdt_beta/UI/home_screem/home_widgets/trade_screen.dart';
import 'package:usdt_beta/sizeConfig.dart';
import 'package:usdt_beta/style/color.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final refController = Get.put(ReferalController());
  final userController = Get.put(UserController());
  final adminController = Get.put(AdminController());

  final regularTradeController = Get.put(RegularTradeController());
  final int maxTime = 420;

  RxInt seconds = 420.obs;

  bool isLoading = false;

  //final adController = Get.put(AdminController());

  @override
  void initState() {
    // adminController.getVari();
    userController.getUser();
    refController.getRef(userController.firbaseUser.value.uid);

    updateTradeType();

    super.initState();
  }

  Random random = new Random(100);
  double randomNumber = 0.0;
  double random2 = 0.0;
  double random3 = 0.0;
  double random4 = 0.0;
  double random5 = 0.0;
  double random6 = 0.0;

  @override
  Widget build(BuildContext context) {
    randomNumber = random.nextDouble();
    random2 = random.nextDouble();
    random3 = random.nextDouble();
    random4 = random.nextDouble();
    random5 = random.nextDouble();
    random6 = random.nextDouble();
    Timer(Duration(seconds: 6), () {
      if (mounted) {
        setState(() => print('Data updated'));
      }
    });

    return Scaffold(
      backgroundColor: bgColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0),
        child: Container(
          decoration: BoxDecoration(color: Colors.pink),
          child: AppBar(
            automaticallyImplyLeading: false,
            actions: [
              IconButton(
                icon: Icon(
                  Icons.refresh,
                  color: Colors.white,
                ),
                onPressed: () {
                  setState(() {});
                },
              )
            ],
            excludeHeaderSemantics: true,
            toolbarHeight: 300,
            elevation: 0.0,
            backgroundColor: bgColor,
            leading: null,
            title: Text(
              'USDTBETA',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 46,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: SizeConfig.screenHeight * 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text('Regular Trading',
                    style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
              ),
              RegularCard(
                color: Colors.amber,
                randomNumber: randomNumber,
                title: 'Gold',
                onTap: () {
                  regularTradeController.seconds.value = 420;
                  Get.to(TradeScreen(
                    color: Colors.amber,
                    title: 'rGold',
                    rate: random2,
                  ));
                },
              ),
              //SizedBox(height: SizeConfig.screenHeight * 0.0001),
              RegularCard(
                randomNumber: random2,
                title: 'Crude Oil',
                onTap: () {
                  regularTradeController.seconds.value = 420;

                  Get.to(TradeScreen(
                    rate: random2,
                    color: Color(0xff41403f),
                    title: 'rCrudeOil',
                  ));
                },
                color: Color(0xff41403f),
              ),
              RegularCard(
                randomNumber: random3,
                title: 'Silver',
                onTap: () {
                  regularTradeController.seconds.value = 420;

                  Get.to(TradeScreen(
                    rate: random3,
                    color: Color(0xff9d9384),
                    title: 'rSilver',
                  ));
                },
                color: Color(0xff9d9384),
              ),
              RegularCard(
                randomNumber: random4,
                title: 'CoinBase',
                onTap: () {
                  regularTradeController.seconds.value = 420;

                  Get.to(TradeScreen(
                    rate: random4,
                    color: Color(0xff1f73f2),
                    title: 'rCoinbase',
                  ));
                },
                color: Color(0xff1f73f2),
              ),
              RegularCard(
                randomNumber: random5,
                title: 'Amazon',
                onTap: () {
                  regularTradeController.seconds.value = 420;

                  Get.to(TradeScreen(
                    rate: random5,
                    color: Color(0xffeb9134),
                    title: 'rAmazon',
                  ));
                },
                color: Color(0xffeb9134),
              ),
              RegularCard(
                randomNumber: random6,
                title: 'Lite Coins',
                onTap: () {
                  regularTradeController.seconds.value = 420;

                  Get.to(TradeScreen(
                    rate: random6,
                    color: Color(0xffebbe7f),
                    title: 'rLiteCoin',
                  ));
                },
                color: Color(0xffebbe7f),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text('Copy Trading',
                    style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
              ),
              Obx(() => Flexible(
                  child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          SizedBox(width: SizeConfig.screenWidth * 0.03),
                          CurrencyCard(
                            color: adminController
                                        .variablesModel.isCoinbase?.value ==
                                    true
                                ? Colors.red
                                : Colors.grey,
                            onTap: () {
                              if (!isLoading) {
                                MyDatabase()
                                    .getCountDownTime('rCoinbase')
                                    .then((value) {
                                  final startAt = value.startAt.toDate();
                                  final now = DateTime.now();

                                  final difference =
                                      startAt.difference(now).inSeconds;

                                  seconds.value = maxTime + difference;

                                  if (seconds.value < maxTime &&
                                      seconds.value > 0) {
                                    adminController.variablesModel.isCoinbase
                                                ?.value ==
                                            true
                                        ? Get.to(CopyTradeScreen(
                                            title: 'Coinbase',
                                            commodityType: 'rCoinbase',
                                            endTime: seconds.value,
                                          ))
                                        : Get.snackbar('Alert',
                                            'This will be start by admin');
                                  }
                                  isLoading = false;
                                });
                              }
                            },
                            image: 'assets/images/coinbase.jpg',
                            title: 'Coinbase Global Inc.',
                            value: random4,
                          ),
                          SizedBox(width: SizeConfig.screenWidth * 0.03),
                          CurrencyCard(
                            color: adminController
                                        .variablesModel.isAmazon?.value ==
                                    true
                                ? Colors.red
                                : Colors.grey,
                            onTap: () {
                              if (!isLoading) {
                                MyDatabase()
                                    .getCountDownTime('rAmazon')
                                    .then((value) {
                                  final startAt = value.startAt.toDate();
                                  final now = DateTime.now();

                                  final difference =
                                      startAt.difference(now).inSeconds;

                                  seconds.value = maxTime + difference;

                                  if (seconds.value < maxTime &&
                                      seconds.value > 0) {
                                    adminController.variablesModel.isAmazon
                                                ?.value ==
                                            true
                                        ? Get.to(CopyTradeScreen(
                                            title: 'Amazon',
                                            commodityType: 'rAmazon',
                                            endTime: seconds.value,
                                          ))
                                        : Get.snackbar('Alert',
                                            'This will be start by admin');
                                  }
                                  isLoading = false;
                                });
                              }
                            },
                            image: 'assets/images/amazon.jpg',
                            title: 'Amazon.com, Inc.',
                            value: random5,
                          ),
                          SizedBox(width: SizeConfig.screenWidth * 0.03),
                          CurrencyCard(
                            color:
                                adminController.variablesModel.isLite?.value ==
                                        true
                                    ? Colors.red
                                    : Colors.grey,
                            onTap: () {
                              if (!isLoading) {
                                MyDatabase()
                                    .getCountDownTime('rLiteCoin')
                                    .then((value) {
                                  final startAt = value.startAt.toDate();
                                  final now = DateTime.now();

                                  final difference =
                                      startAt.difference(now).inSeconds;

                                  seconds.value = maxTime + difference;

                                  if (seconds.value < maxTime &&
                                      seconds.value > 0) {
                                    adminController
                                                .variablesModel.isLite?.value ==
                                            true
                                        ? Get.to(CopyTradeScreen(
                                            title: 'Lite',
                                            commodityType: 'rLiteCoin',
                                            endTime: seconds.value,
                                          ))
                                        : Get.snackbar('Alert',
                                            'This will be start by admin');
                                  }
                                  isLoading = false;
                                });
                              }
                            },
                            image: 'assets/images/litecoin.jpeg',
                            title: 'Lite Coin',
                            value: random6,
                          ),
                          SizedBox(width: SizeConfig.screenWidth * 0.03),
                          CurrencyCard(
                            color:
                                adminController.variablesModel.isGold?.value ==
                                        true
                                    ? Colors.red
                                    : Colors.grey,
                            onTap: () {
                              if (!isLoading) {
                                MyDatabase()
                                    .getCountDownTime('rGold')
                                    .then((value) {
                                  final startAt = value.startAt.toDate();
                                  final now = DateTime.now();

                                  final difference =
                                      startAt.difference(now).inSeconds;

                                  seconds.value = maxTime + difference;

                                  if (seconds.value < maxTime &&
                                      seconds.value > 0) {
                                    adminController
                                                .variablesModel.isGold?.value ==
                                            true
                                        ? Get.to(CopyTradeScreen(
                                            title: 'Gold',
                                            commodityType: 'rGold',
                                            endTime: seconds.value,
                                          ))
                                        : Get.snackbar('Alert',
                                            'This will be start by admin');
                                  }
                                  isLoading = false;
                                });
                              }
                            },
                            image: 'assets/images/gold.jpeg',
                            title: 'Gold',
                            value: randomNumber,
                          ),
                          SizedBox(width: SizeConfig.screenWidth * 0.03),
                          CurrencyCard(
                            color: adminController
                                        .variablesModel.isSilver?.value ==
                                    true
                                ? Colors.red
                                : Colors.grey,
                            onTap: () {
                              if (!isLoading) {
                                MyDatabase()
                                    .getCountDownTime('rSilver')
                                    .then((value) {
                                  final startAt = value.startAt.toDate();
                                  final now = DateTime.now();

                                  final difference =
                                      startAt.difference(now).inSeconds;

                                  seconds.value = maxTime + difference;

                                  if (seconds.value < maxTime &&
                                      seconds.value > 0) {
                                    adminController.variablesModel.isSilver
                                                ?.value ==
                                            true
                                        ? Get.to(CopyTradeScreen(
                                            title: 'Silver',
                                            commodityType: 'rSilver',
                                            endTime: seconds.value,
                                          ))
                                        : Get.snackbar('Alert',
                                            'This will be start by admin');
                                  }
                                  isLoading = false;
                                });
                              }
                            },
                            image: 'assets/images/silver.jpeg',
                            title: 'Silver',
                            value: random3,
                          ),
                          SizedBox(width: SizeConfig.screenWidth * 0.03),
                          CurrencyCard(
                            color: adminController
                                        .variablesModel.isCrudeOil?.value ==
                                    true
                                ? Colors.red
                                : Colors.grey,
                            onTap: () {
                              if (!isLoading) {
                                MyDatabase()
                                    .getCountDownTime('rCrudeOil')
                                    .then((value) {
                                  final startAt = value.startAt.toDate();
                                  final now = DateTime.now();

                                  final difference =
                                      startAt.difference(now).inSeconds;

                                  seconds.value = maxTime + difference;

                                  if (seconds.value < maxTime &&
                                      seconds.value > 0) {
                                    adminController.variablesModel.isCrudeOil
                                                ?.value ==
                                            true
                                        ? Get.to(CopyTradeScreen(
                                            title: 'Oil',
                                            commodityType: 'rCrudeOil',
                                            endTime: seconds.value,
                                          ))
                                        : Get.snackbar('Alert',
                                            'This will be start by admin');
                                  }
                                  isLoading = false;
                                });
                              }
                            },
                            image: 'assets/images/crudeoil.jpeg',
                            title: 'Crude Oil WTI',
                            value: random2,
                          )
                        ],
                      ))))
            ],
          ),
        ),
      ),
    );
  }

  void updateTradeType() {
    Timer.periodic(Duration(seconds: 10), (timer) {
      bool isGoldUserActive = userController.user.rGold ?? false;
      if (isGoldUserActive) updateActiveTradeType('rGold', false);

      // bool isGoldAdminActive = adminController.variablesModel.isGold.value ??
      //     false;
      // if (isGoldAdminActive)
      //   updateActiveAdminValues('rGold', false);

      bool isAmazonUserActive = userController.user.rAmazon ?? false;
      if (isAmazonUserActive) updateActiveTradeType('rAmazon', false);

      // bool isAmazonAdminActive = adminController.variablesModel.isAmazon
      //     .value ?? false;
      // if (isAmazonAdminActive)
      //   updateActiveAdminValues('rAmazon', false);

      bool isCoinbaseUserActive = userController.user.rCoinbase ?? false;
      if (isCoinbaseUserActive) updateActiveTradeType('rCoinbase', false);

      // bool isCoinbaseAdminActive = adminController.variablesModel.isCoinbase
      //     .value ?? false;
      // if (isCoinbaseAdminActive)
      //   updateActiveAdminValues('rCoinbase', false);

      bool isLiteCoinUserActive = userController.user.rLiteCoin ?? false;
      if (isLiteCoinUserActive) updateActiveTradeType('rLiteCoin', false);

      // bool isLiteCoinAdminActive = adminController.variablesModel.isLite
      //     .value ?? false;
      // if (isLiteCoinAdminActive)
      //   updateActiveAdminValues('rLiteCoin', false);

      bool isCrudeOilUserActive = userController.user.rCrudeOil ?? false;
      if (isCrudeOilUserActive) updateActiveTradeType('rCrudeOil', false);

      // bool isCrudeOilAdminActive = adminController.variablesModel.isCrudeOil
      //     .value ?? false;
      // if (isCrudeOilAdminActive)
      //   updateActiveAdminValues('rCrudeOil', false);

      bool isSilverUserActive = userController.user.rSilver ?? false;
      if (isSilverUserActive) updateActiveTradeType('rSilver', false);

      // bool isSilverAdminActive = adminController.variablesModel.isSilver
      //     .value ?? false;
      // if (isSilverAdminActive)
      //   updateActiveAdminValues('rSilver', false);
    });
  }

  void updateActiveTradeType(String commodityType, bool updateValue) {
    MyDatabase().getCountDownTime(commodityType).then((value) {
      var startAt = value.startAt.toDate();
      final now = DateTime.now();

      startAt = startAt.add(Duration(seconds: 420));

      if (startAt.isBefore(now)) {
        print('home screen time ended');
        MyDatabase()
            .getCopyTradeWinner(userController.user.uid, commodityType, true);
      }
    }).onError((error, stackTrace) {
      isLoading = false;
      print('Error: $error');
    });
  }

// void updateActiveAdminValues(String commodityType, bool updateValue) {
//   MyDatabase().getCountDownTime(commodityType).then((value) {
//     var startAt = value.startAt.toDate();
//     final now = DateTime.now();
//
//     startAt = startAt.add(Duration(seconds:420));
//
//     if (startAt.isBefore(now)) {
//       MyDatabase().updateValues(commodityType, updateValue);
//     }
//   }).onError((error, stackTrace) {
//     isLoading = false;
//     // MyDatabase().updateValues(commodityType, updateValue);
//     print('Error: $error');
//   });
// }

// void openCopyTradeScreen(String title, String commodityType) {
//
//   MyDatabase().getCountDownTime(commodityType).then((value) {
//     final startAt = value.startAt.toDate();
//     final now = DateTime.now();
//
//     final difference = startAt.difference(now).inSeconds;
//
//     seconds.value = maxTime + difference;
//
//     if (seconds.value < maxTime && seconds.value > 0) {
//       adminController.vari.isStartTrade?.value == commodityType
//           ? Get.to(CopyTradeScreen(
//               title: title,
//               commodityType: commodityType,
//               endTime: seconds.value,
//             ))
//           : Get.snackbar('Alert', 'This will be start by admin');
//     }
//     isLoading = false;
//   });
// }
}
