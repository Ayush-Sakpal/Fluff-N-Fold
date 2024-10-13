import 'dart:core';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_popup_card/flutter_popup_card.dart';
import 'package:get_it/get_it.dart';
import 'package:the_laundry_app/providers/dryCleanProvider.dart';
import '../providers/premWashProvider.dart';
import '../widgets/dry_clean_popup_card_details.dart';
import '../widgets/prem_popup_card_details.dart';
import '../Screens/check_out_screen.dart';
import '../services/navigation_service.dart';
import 'package:provider/provider.dart';


class DryCleanScreen extends StatefulWidget {
  static const routeName = '/sws';
  @override
  State<DryCleanScreen> createState() => _DryCleanScreenState();
}

class _DryCleanScreenState extends State<DryCleanScreen> {

  final GetIt _getIt = GetIt.instance;

  late NavigationService _navigationService;

  String _dropDownValue = "";
  TextEditingController qtyController = TextEditingController();

  @override
  void initState() {
    _navigationService = _getIt.get<NavigationService>();
    super.initState();
  }

  void showDialogBoxOnProceed(){
    showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
            title: const Text("Unable to Proceed"),
            content: const Text("Nothing in Cart!"),
            actions: [
              TextButton(
                  onPressed: (){
                    Navigator.of(context).pop();
                  },
                  child: const Text("Ok")
              )
            ],
          );
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DryCleanProvider>(

      builder: (context, listProviderModel, child) => Scaffold(
      appBar: AppBar(
        title: Text(
          'Dry Clean',
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: (){
                _navigationService.pushNamed("/cart");
              },
              icon: const Icon(
                  Icons.shopping_cart
              )
          )
        ],
      ),

      body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(27),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                      flex: 1,
                      child: ListView.separated(
                          separatorBuilder: (context, index) {
                            return SizedBox(
                              height: MediaQuery.of(context).size.height * 0.009,
                            );
                          },
                          itemCount: listProviderModel.itemNames.length,
                          itemBuilder: ((context, index){
                            return Dismissible(
                              key: Key(listProviderModel.itemNames[index]!),
                              direction: DismissDirection.endToStart,
                              onDismissed: (direction){
                                listProviderModel.itemNames.removeAt(index);
                                listProviderModel.itemQuantities.removeAt(index);
                                listProviderModel.notifyListeners();
                              },
                              background: Container(
                                decoration: BoxDecoration(
                                  color: Colors.redAccent,
                                  borderRadius: BorderRadius.circular(21),
                                ),
                                alignment: Alignment.centerRight,
                                padding: const EdgeInsets.only(right: 16),
                                child: const Icon(
                                  Icons.cancel_rounded,
                                  color: Colors.white,
                                ),
                              ),

                              child: Card(
                                clipBehavior: Clip.antiAlias,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(21)),
                                elevation: 2,
                                child: Column(
                                  children: [
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      padding: const EdgeInsets.only(
                                          right: 16,
                                          top: 5
                                      ),
                                      margin: const EdgeInsets.only(
                                        // left: 2,
                                        // right: 2,
                                          bottom: 2
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(21),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(14.0),
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [

                                            Container(
                                              margin: const EdgeInsets.only(bottom: 7),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    listProviderModel.itemNames[index]!,
                                                    style: const TextStyle(fontSize: 18),
                                                  ),
                                                ],
                                              ),
                                            ),

                                            const Spacer(),

                                            Row(
                                              children: [
                                                Container(
                                                  height: MediaQuery.of(context).size.height * 0.037,
                                                  width: MediaQuery.of(context).size.height * 0.037,
                                                  decoration: BoxDecoration(
                                                      borderRadius: const BorderRadius.only(
                                                          topLeft: Radius.circular(7),
                                                          bottomLeft: Radius.circular(7)
                                                      ),
                                                      border: Border.all(
                                                          width: 0.1,
                                                          color: Colors.grey
                                                      )
                                                  ),

                                                  child: Center(
                                                    child: IconButton(
                                                      padding: EdgeInsets.zero,
                                                      onPressed: (){
                                                        listProviderModel.stdWashDecrementQty(index);

                                                        if(listProviderModel.itemQuantities[index] == 0){
                                                          listProviderModel.itemQuantities.removeAt(index);
                                                          listProviderModel.itemNames.removeAt(index);
                                                        }
                                                        listProviderModel.notifyListeners();
                                                      },
                                                      icon: const Icon(Icons.remove),
                                                    ),
                                                  ),
                                                ),

                                                Container(
                                                  height: MediaQuery.of(context).size.height * 0.037,
                                                  width: MediaQuery.of(context).size.height * 0.037,
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          width: 0.1,
                                                          color: Colors.grey
                                                      )
                                                  ),

                                                  child: Center(
                                                    child: Text(
                                                      listProviderModel.itemQuantities[index].toString(),
                                                      style: const TextStyle(
                                                          fontSize: 18
                                                      ),
                                                    ),
                                                  ),
                                                ),

                                                Container(
                                                  height: MediaQuery.of(context).size.height * 0.037,
                                                  width: MediaQuery.of(context).size.height * 0.037,
                                                  decoration: BoxDecoration(
                                                      borderRadius: const BorderRadius.only(
                                                          topRight: Radius.circular(7),
                                                          bottomRight: Radius.circular(7)
                                                      ),
                                                      border: Border.all(
                                                          width: 0.1,
                                                          color: Colors.grey
                                                      )
                                                  ),

                                                  child: Center(
                                                    child: IconButton(
                                                      padding: EdgeInsets.zero,
                                                      onPressed: (){
                                                        listProviderModel.stdWashIncrementQty(index);
                                                        listProviderModel.notifyListeners();
                                                      },
                                                      icon: const Icon(Icons.add),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),

                                  ],
                                ),
                              ),
                            );
                          }
                          )
                      )
                  ),

                ],
              ),
            )
        ),

        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            showPopupCard(
                context: context,
                builder: (context){
                  return Padding(
                    padding: const EdgeInsets.all(11.0),
                    child: Padding(
                      padding: const EdgeInsets.all(11.0),
                      child: PopupCard(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(11),
                              side: BorderSide(
                                  color: Theme.of(context).colorScheme.outlineVariant
                              )
                          ),
                          child: DryCleanPopupCardDetails()
                      ),
                    ),
                  );
                },
                dimBackground: true,
                alignment: Alignment.center,
                useSafeArea: true
            );
          },
          child: Icon(Icons.add, color: Colors.white,),
          backgroundColor: Colors.blueAccent,
        ),

        bottomNavigationBar: listProviderModel.itemNames.length == 0
            ? null :
        ClipRRect(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(21), topRight: Radius.circular(21)),
          child: BottomAppBar(
            height: (MediaQuery.of(context).size.height) * 0.125,
            elevation: 21,
            shadowColor: Colors.black12,
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(21),
                      topRight: Radius.circular(21))),
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Dry Clean Total',
                          style: TextStyle(fontSize: 14, color: Colors.black54),
                        ),
                        const SizedBox(
                          width: 50,
                        ),
                        Text(
                          '\u{20B9}' + listProviderModel.getDryCleanCartTotal().toStringAsFixed(2),
                          style: const TextStyle(
                              fontSize: 26, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const Spacer(),
                    ElevatedButton(
                        onPressed: () {
                          if (listProviderModel.getDryCleanCartTotal() != 0) {
                            _navigationService.pushNamed('/cart');
                          } else {
                            showDialogBoxOnProceed();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blueAccent,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(21))),
                        child: const Text(
                          "Go to Cart",
                          style: TextStyle(color: Colors.white, fontSize: 17),
                        ))
                  ],
                ),
              ),
            ),
          ),
        ),
      ),


    );
  }
}
