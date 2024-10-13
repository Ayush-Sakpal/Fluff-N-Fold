import 'package:flutter/material.dart';
import 'package:the_laundry_app/providers/stdWashProvider.dart';
import '../Screens/standard_wash_screen.dart';
import '../Screens/premium_wash_screen.dart';
import '../providers/premWashProvider.dart';
import 'package:provider/provider.dart';

class PremPopupCardDetails extends StatefulWidget{
  PremPopupCardDetails({super.key,});

  @override
  State<PremPopupCardDetails> createState() => _PremPopupCardDetailsState();
}

class _PremPopupCardDetailsState extends State<PremPopupCardDetails> {

  String _dropDownValue = "";
  TextEditingController qtyController = TextEditingController();

  String itemType = '';
  int itemQuantity = 0;

  @override
  Widget build(BuildContext context) {
    return Consumer<PremiumWashProvider>(
      builder: (context, listProviderModel, child) => Padding(
        padding: const EdgeInsets.all(21.0),
        child: Container(
          width: MediaQuery.of(context).size.width*0.9,
          height: MediaQuery.of(context).size.height * 0.5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Add Items",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.w700
                ),
              ),
              SizedBox(
                height: 60,
              ),
              DropdownButton(
                hint: _dropDownValue == ""
                    ? Text("Select Item")
                    : Text(
                  _dropDownValue,
                  style: TextStyle(
                      color: Colors.blueAccent
                  ),
                ),

                isExpanded: true,
                menuWidth: MediaQuery.of(context).size.width * 0.7,
                borderRadius: BorderRadius.circular(11),

                iconSize: 30,
                items: ['Tops', 'Bottoms', 'Coats', 'Dress'].map(
                        (val){
                      return DropdownMenuItem<String>(
                          value: val,
                          child: Text(val)
                      );
                    }
                ).toList(),
                onChanged: (val){
                  setState(() {
                    _dropDownValue = val!;
                  });
                },
              ),
              SizedBox(
                height: 40,
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                controller: qtyController,
                decoration: const InputDecoration(
                    label: Text("Quantity"),
                    hintText: "Enter quantity",
                    border: OutlineInputBorder()
                ),
              ),
              SizedBox(
                height: 60,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.35,
                    child: MaterialButton(
                      onPressed: (){},
                      elevation: 0,
                      child: Text(
                        "Cancel",
                        style: TextStyle(
                            color: Colors.black
                        ),
                      ),
                      color: Theme.of(context).colorScheme.outlineVariant,
                      shape: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.35,
                    child: MaterialButton(
                      onPressed: (){
                        if (_dropDownValue.isNotEmpty && qtyController.text.isNotEmpty){
                          listProviderModel.itemNames.add(_dropDownValue);
                          listProviderModel.itemQuantities.add(int.parse(qtyController.text));
                          Navigator.of(context).pop();
                          listProviderModel.notifyListeners();
                        }
                      },
                      child: Text(
                        "Done",
                        style: TextStyle(
                            color: Colors.white
                        ),
                      ),
                      color: Colors.blueAccent,
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}