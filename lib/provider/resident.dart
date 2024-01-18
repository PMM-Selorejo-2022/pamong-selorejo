import 'package:flutter/cupertino.dart';
import 'package:pamong_selorejo/model/resident.dart';

class ResidentProvider with ChangeNotifier {
  Resident? resident;
  List<VerifiedResident>? listResident;
  String nop = " ";

  addResident(res) {
    resident = res;
    notifyListeners();
  }

  removeResident() {
    resident = null;
    notifyListeners();
  }

  addAllListResident(list) {
    listResident = list;
    notifyListeners();
  }

  removeAllListResident() {
    listResident = null;
    notifyListeners();
  }

  addNOP(nops) {
    nop = nops;
    notifyListeners();
  }

  removeNOP() {
    nop = " ";
    notifyListeners();
  }
}
