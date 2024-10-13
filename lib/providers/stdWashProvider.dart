import 'package:flutter/material.dart';

class StandardWashProvider extends ChangeNotifier{
  List<int> itemQuantities = [];
  List<String?> itemNames = [];

  void addItemName(String itemName){
    itemNames.add(itemName);
    notifyListeners();
  }

  void addItemQty(int itemQty){
    itemQuantities.add(itemQty);
    notifyListeners();
  }

  void stdWashIncrementQty(int index){
      itemQuantities[index]++;
      notifyListeners();
  }

  void stdWashDecrementQty(int index){
      if(itemQuantities[index] > 0){
        itemQuantities[index]--;
      }
      notifyListeners();
  }

  double getStdCartTotal(){
    double stdWashTotal = 0;
    double itemPrice = 0;

    for(int i = 0; i < itemNames.length; i++){
      switch(itemNames[i]){
        case "Tops":{
          itemPrice = 10;
        }
        break;
        case "Bottoms": {
          itemPrice = 12;
        }
        break;
        case "Coats": {
          itemPrice = 18;
        }
        break;
        case "Dress": {
          itemPrice = 30;
        }
      }
      stdWashTotal += itemQuantities[i] * itemPrice;
    }

    return stdWashTotal;
  }

}