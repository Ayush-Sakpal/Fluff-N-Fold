import 'package:flutter/material.dart';

class AddressScreenProvider extends ChangeNotifier{
  String addressLine1 = '';
  String addressLine2 = '';
  String city = '';
  int pinCode = 0;

  notifyListeners();
}