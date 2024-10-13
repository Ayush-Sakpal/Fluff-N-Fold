import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/addressScreenProvider.dart';

class AddressPopupCardDetails extends StatefulWidget {
  const AddressPopupCardDetails({super.key});

  @override
  State<AddressPopupCardDetails> createState() => _AddressPopupCardDetailsState();
}

class _AddressPopupCardDetailsState extends State<AddressPopupCardDetails> {

  final TextEditingController addressLine1 = TextEditingController();
  final TextEditingController addressLine2 = TextEditingController();
  final TextEditingController city = TextEditingController();
  final TextEditingController pinCode = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<AddressScreenProvider>(
      builder: (context, addressProviderModel, child) => Padding(
          padding: EdgeInsets.all(21),
        child:  Container(
          width: MediaQuery.of(context).size.width*0.9,
          height: MediaQuery.of(context).size.height * 0.60,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Enter Address",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.w700
                ),
              ),
              SizedBox(
                height: 60,
              ),
              TextField(
                controller: addressLine1,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  hintText: "Address Line 1...",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              TextField(
                controller: addressLine2,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  hintText: "Address Line 2...",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              TextField(
                controller: city,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  hintText: "City...",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              TextField(
                controller: pinCode,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: "Pincode",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.06,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.35,
                    child: MaterialButton(
                      onPressed: (){
                        Navigator.pop(context);
                      },
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
                        addressProviderModel.addressLine1 = addressLine1.text;
                        addressProviderModel.notifyListeners();
                          Navigator.of(context).pop();
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
