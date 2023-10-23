import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class CustomAppBarController{
  TextEditingController searchController = TextEditingController();
  bool isSearch = false;
  ValueNotifier<double> searchWidth = ValueNotifier<double>(0);

  void changeIsSearch(){
    isSearch = !isSearch;
    searchWidth.value = isSearch ? 200:0;
  }

}