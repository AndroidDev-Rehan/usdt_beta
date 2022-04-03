import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:usdt_beta/Model/user_model.dart';

class AllUserController extends GetxController {
  Rx<List<UserModel>> allUserList = Rx<List<UserModel>>();

  List<UserModel> get allUser => allUserList.value;

  Rx<List<UserModel>> allUserListT = Rx<List<UserModel>>();

  Rx<List<UserModel>> allUserListTCoinbase = Rx<List<UserModel>>();
  Rx<List<UserModel>> allUserListTAmazon = Rx<List<UserModel>>();
  Rx<List<UserModel>> allUserListTLite = Rx<List<UserModel>>();
  Rx<List<UserModel>> allUserListTGold = Rx<List<UserModel>>();
  Rx<List<UserModel>> allUserListTSilver = Rx<List<UserModel>>();
  Rx<List<UserModel>> allUserListTOil = Rx<List<UserModel>>();

  List<UserModel> get allUserT => allUserListT.value;

  List<UserModel> get allUserTCoinbase => allUserListTCoinbase.value;

  List<UserModel> get allUserTAmazon => allUserListTAmazon.value;

  List<UserModel> get allUserTLite => allUserListTLite.value;

  List<UserModel> get allUserTGold => allUserListTGold.value;

  List<UserModel> get allUserTSilver => allUserListTSilver.value;

  List<UserModel> get allUserTOil => allUserListTOil.value;

  @override
  void onInit() {
    allUserList.bindStream(allUserStream());
    allUserListT.bindStream(allCopyTradeUserStream());

    allUserListTCoinbase.bindStream(copyTradeUserStream('rCoinbase', true));
    allUserListTAmazon.bindStream(copyTradeUserStream('rAmazon', true));
    allUserListTLite.bindStream(copyTradeUserStream('rLiteCoin', true));
    allUserListTGold.bindStream(copyTradeUserStream('rGold', true));
    allUserListTSilver.bindStream(copyTradeUserStream('rSilver', true));
    allUserListTOil.bindStream(copyTradeUserStream('rCrudeOil', true));

    super.onInit();
  }

  Stream<List<UserModel>> allUserStream() {
    print("enter in all user stream funtion");
    return FirebaseFirestore.instance
        .collection('user')
        .snapshots()
        .map((QuerySnapshot query) {
      List<UserModel> retVal = List();
      query.docs.forEach((element) {
        retVal.add(UserModel.fromDocumentSnapShot(element));
      });

      print('lenght of all users is ${retVal.length}');
      return retVal;
    });
  }

  Stream<List<UserModel>> allCopyTradeUserStream() {
    print("Enter in copy trade user");
    return FirebaseFirestore.instance
        .collection('user')
        .where('cTrade', isEqualTo: true)
        .snapshots()
        .map((QuerySnapshot query) {
      List<UserModel> retVal = List();
      query.docs.forEach((element) {
        retVal.add(UserModel.fromDocumentSnapShot(element));
      });

      print('lenght of all copy trade users is ${retVal.length}');
      return retVal;
    });
  }

  Stream<List<UserModel>> copyTradeUserStream(String trade, bool value) {
    print("Enter in copy trade user");
    return FirebaseFirestore.instance
        .collection('user')
        .where('cTrade', isEqualTo: true)
        .where(trade, isEqualTo: value)
        .snapshots()
        .map((QuerySnapshot query) {
      List<UserModel> retVal = List();
      query.docs.forEach((element) {
        retVal.add(UserModel.fromDocumentSnapShot(element));
      });

      print('lenght of all copy trade users is ${retVal.length}');
      return retVal;
    });
  }
}
