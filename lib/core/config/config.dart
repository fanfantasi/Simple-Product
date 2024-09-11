import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
enum CaptionType { normal, mention, hashtag, seeMore, seeLess }

enum Proccess { pending, done, filed }

class Configs {
  static const uri = 'http://192.168.1.8:3100';
  static const appName = 'KLONTONG';
  static const baseUrl = '$uri/v1/';
  static ScrollController scrollControllerHome = ScrollController();
  
  
  bool charForTag(String text) {
    final result = RegExp(r'^[a-zA-Z0-9]+$').hasMatch(text);
    return result;
  }
  
  static String currency(int num) {
    final formatter = NumberFormat("#,###");
    return 'Rp. ${formatter.format(num)}';
  }

  static String numberformat(int num) {
    final formatter = NumberFormat("#,###");
    return formatter.format(num);
  }


  static String dateIndo(String date) {
    return DateFormat('yyyy-MM-dd').format(DateTime.parse(date));
  }

}
