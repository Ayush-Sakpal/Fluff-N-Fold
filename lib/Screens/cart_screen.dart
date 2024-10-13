import 'dart:core';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:the_laundry_app/providers/dryCleanProvider.dart';
import 'package:the_laundry_app/providers/ironProvider.dart';
import 'package:the_laundry_app/providers/premWashProvider.dart';
import 'package:the_laundry_app/providers/stdWashProvider.dart';
import '../Screens/check_out_screen.dart';
import 'package:provider/provider.dart';


class CartScreen extends StatefulWidget {
  static const routeName = '/cart';

  const CartScreen({super.key});
  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {

  void showDialogBoxOnProceed(){
    showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
            title: const Text("'Unable to Proceed"),
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

    final stdWashProvider = Provider.of<StandardWashProvider>(context);
    final premWashProvider = Provider.of<PremiumWashProvider>(context);
    final dryCleanProvider = Provider.of<DryCleanProvider>(context);
    final ironProvider = Provider.of<IronProvider>(context);

    double getCartTotal(){
      double total = stdWashProvider.getStdCartTotal() + premWashProvider.getPremCartTotal() + dryCleanProvider.getDryCleanCartTotal() + ironProvider.getIronCartTotal();
      return total;
    }

    return DefaultTabController(
      length: 4,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Cart',
          ),
          centerTitle: true,

          bottom: TabBar(
            overlayColor: WidgetStateColor.transparent,
            indicator: UnderlineTabIndicator(
                borderSide: BorderSide(
                  color: Colors.blueAccent,
                  width: 7,
                ),
                borderRadius: BorderRadius.circular(3.5)
            ),

            labelPadding: EdgeInsets.symmetric(horizontal: 21),

            tabs: [
              Tab(
                child: Text("Standard"),
              ),
              Tab(
                child: Text("Premium"),
              ),
              Tab(
                child: Text("Dry Clean"),
              ),
              Tab(
                child: Text("Iron"),
              )
            ],
          ),
        ),

        body: SafeArea(
            child: TabBarView(
              children: [
                Consumer<StandardWashProvider>(

                  builder: (context, listProviderModel, child) => SafeArea(
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
                ),

                Consumer<PremiumWashProvider>(

                  builder: (context, listProviderModel, child) => SafeArea(
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
                ),

                Consumer<DryCleanProvider>(

                  builder: (context, listProviderModel, child) => SafeArea(
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
                ),

                Consumer<IronProvider>(

                  builder: (context, listProviderModel, child) => SafeArea(
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
                ),
              ],
            )
        ),

        bottomNavigationBar: ClipRRect(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(21), topRight: Radius.circular(21)),
          child: BottomAppBar(
            height: (MediaQuery.of(context).size.height) * 0.125,
            elevation: 21,
            shadowColor: Colors.black12,

            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(21), topRight: Radius.circular(21))
              ),
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Cart Total',
                          style: TextStyle(fontSize: 18, color: Colors.black54),
                        ),

                        const SizedBox(
                          width: 50,
                        ),

                        Text(
                          '\u{20B9}' + getCartTotal().toStringAsFixed(2),
                          style: const TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ],
                    ),

                    const Spacer(),

                    ElevatedButton(
                        onPressed: (){
                          if(getCartTotal() != 0){
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context){
                                      return Checkoutscreen();
                                    }
                                )
                            );
                          }
                          else{
                            showDialogBoxOnProceed();
                          }
                        },

                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blueAccent,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(21)
                            )
                        ),
                        child: const Text(
                          "Proceed to Checkout",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 17
                          ),
                        )
                    )
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
