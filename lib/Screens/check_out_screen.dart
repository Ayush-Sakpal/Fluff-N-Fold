import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_popup_card/flutter_popup_card.dart';
import 'package:get_it/get_it.dart';
import 'package:the_laundry_app/providers/addressScreenProvider.dart';
import 'package:the_laundry_app/services/navigation_service.dart';
import 'package:provider/provider.dart';
import '../widgets/address_popup_card_details.dart';

class Checkoutscreen extends StatefulWidget{

  @override
  State<Checkoutscreen> createState() => _CheckoutscreenState();
}

class _CheckoutscreenState extends State<Checkoutscreen> {
  final GetIt _getIt = GetIt.instance;

  late NavigationService _navigationService;

  String? addressText;

  @override
  void initState() {
    super.initState();
    _navigationService = _getIt.get<NavigationService>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        appBar: AppBar(
          title: const Text("Checkout", style: TextStyle(fontWeight: FontWeight.w900),),
          centerTitle: true,
        ),

        body: Consumer<AddressScreenProvider>(
          builder: (context, addressProviderModel, child) => SafeArea(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Padding(
                  padding: const EdgeInsets.all(27),

                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      Card(
                        clipBehavior: Clip.antiAlias,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(21)),
                        elevation: 3,
                        child: Container(
                          height: MediaQuery.of(context).size.height*0.091,
                          width: MediaQuery.of(context).size.width,

                          decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(21))
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [

                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [

                                    Text("Address", style: TextStyle(fontSize: 20),),

                                    Text(
                                      addressProviderModel.addressLine1 == ''
                                          ? "No Address Set..."
                                          : addressProviderModel.addressLine1,
                                      style: TextStyle(color: Colors.black38, fontSize: 15),)

                                  ],
                                ),
                              ),

                              Padding(
                                padding: EdgeInsets.all(11.0),
                                child: IconButton(
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
                                                    child: AddressPopupCardDetails()
                                                ),
                                              ),
                                            );
                                          },
                                          dimBackground: true,
                                          alignment: Alignment.center,
                                          useSafeArea: true
                                      );
                                    },
                                    icon: Icon(Icons.navigate_next_rounded)
                                ),
                              )
                            ],
                          ),
                        ),
                      ),

                      SizedBox(height: MediaQuery.of(context).size.height * 0.04,),

                      Text(
                        "Pick up",
                        style: TextStyle(
                            fontSize: 20
                        ),
                      ),

                      SizedBox(height: MediaQuery.of(context).size.height * 0.01,),

                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.11,
                        child: Center(
                          child: ListView.separated(

                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return Card(
                                  elevation: 2,
                                  clipBehavior: Clip.antiAlias,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(21)
                                  ),
                                  child: Container(
                                    height: MediaQuery.of(context).size.height,
                                    width: MediaQuery.of(context).size.height * 0.105,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [

                                        Text("Today", style: TextStyle(fontSize: 19),),

                                        Text("at 9am")
                                      ],
                                    ),

                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(21)
                                    ),
                                  ),
                                );
                              },
                              separatorBuilder: (context, index) {
                                return SizedBox(width: MediaQuery.of(context).size.width * 0.049,);
                              },
                              itemCount: 9
                          ),
                        ),
                      ),

                      SizedBox(height: MediaQuery.of(context).size.height * 0.04,),

                      Text(
                        "Delivery",
                        style: TextStyle(
                            fontSize: 20
                        ),
                      ),

                      SizedBox(height: MediaQuery.of(context).size.height * 0.01,),

                      SizedBox(
                        height: 100,
                        child: Center(
                          child: ListView.separated(

                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return Card(
                                  elevation: 2,
                                  clipBehavior: Clip.antiAlias,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(21)
                                  ),
                                  child: Container(
                                    height: MediaQuery.of(context).size.height,
                                    width: MediaQuery.of(context).size.height * 0.105,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [

                                        Text("${5 - index} days", style: TextStyle(fontSize: 19),),

                                        Text("No extras")
                                      ],
                                    ),

                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(21)
                                    ),
                                  ),
                                );
                              },
                              separatorBuilder: (context, index) {
                                return SizedBox(width: MediaQuery.of(context).size.width * 0.049,);
                              },
                              itemCount: 5
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
          ),
        )
    );
  }
}
