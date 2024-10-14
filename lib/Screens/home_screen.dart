import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:the_laundry_app/services/database_service.dart';
import 'package:the_laundry_app/widgets/sliding_dashBoard.dart';
import '../models/user_profile.dart';
import '../services/alert_service.dart';
import '../services/auth_service.dart';
import '../services/navigation_service.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late NavigationService _navigationService;
  late AuthService _authService;
  late AlertService _alertService;
  late DatabaseService _databaseService;

  String userId = '';
  String? userName;

  final GetIt _getIt = GetIt.instance;

  @override
  void initState() {
    super.initState();
    _navigationService = _getIt.get<NavigationService>();
    _authService = _getIt.get<AuthService>();
    _alertService = _getIt.get<AlertService>();
    _databaseService = _getIt.get<DatabaseService>();

    userId = _authService.user!.uid;
    userName = _authService.user!.displayName;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SlidingDashBoard(),
      appBar: AppBar(
        elevation: 0,
        // leading: Padding(
        //   padding: EdgeInsets.only(left: 11),
        //   child: IconButton(
        //     onPressed: (){},
        //     icon: Icon(Icons.account_circle),
        //     iconSize: 42,
        //   ),
        // ),
        backgroundColor: Colors.transparent,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Hello! $userName",
              style: TextStyle(fontSize: 27),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 11),
            child: IconButton(
              onPressed: () {
                _navigationService.pushNamed('/cart');
              },
              icon: Icon(Icons.shopping_cart),
            ),
          ),
        ],
      ),
      extendBodyBehindAppBar: true,
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: EdgeInsets.all(27.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.011,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            _navigationService.pushNamed("/standardwash");
                          },
                          child: _clickableCards(
                            'assets/images/laundry_basic_illustration.jpg'
                                .toString(),
                            'Standard Wash',
                          ),
                        ),
                        SizedBox(
                          height: 29,
                        ),
                        GestureDetector(
                          child: _clickableCards(
                            'assets/images/laundry_basic_illustration.jpg'
                                .toString(),
                            'Dry Clean',
                          ),
                          onTap: () {
                            _navigationService.pushNamed("/dryclean");
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.025,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          child: _clickableCards(
                            'assets/images/laundry_basic_illustration.jpg'
                                .toString(),
                            'Premium Wash',
                          ),
                          onTap: () {
                            _navigationService.pushNamed("/premiumwash");
                          },
                        ),
                        SizedBox(
                          height: 29,
                        ),
                        GestureDetector(
                          child: _clickableCards(
                            'assets/images/laundry_basic_illustration.jpg'
                                .toString(),
                            'Ironing',
                          ),
                          onTap: () {
                            _navigationService.pushNamed("/ironing");
                          },
                        ),
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.039,
                ),
                Text(
                  "In Progress",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.33,
                  child: ListView.separated(
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        return Card(
                          clipBehavior: Clip.antiAlias,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(21)),
                          elevation: 3,
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.095,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(21))),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(27.0),
                                      child: Icon(Icons.wash_rounded),
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "8 Aug 2024",
                                          style: TextStyle(
                                              color: Colors.black38,
                                              fontSize: 15),
                                        ),
                                        Text(
                                          "Washing",
                                          style: TextStyle(fontSize: 20),
                                        ),
                                        Text("15 items",
                                            style: TextStyle(
                                                color: Colors.black54,
                                                fontSize: 15))
                                      ],
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(11.0),
                                  child: Icon(Icons.navigate_next_rounded),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return SizedBox(
                          height: 7,
                        );
                      },
                      itemCount: 7),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _clickableCards(String imgUrl, String cardText) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.18,
      width: MediaQuery.of(context).size.width * 0.42,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Material(
            child: Image.asset(
              imgUrl,
              height: MediaQuery.of(context).size.height * 0.14,
              width: MediaQuery.of(context).size.width * 0.42,
              fit: BoxFit.fill,
            ),
            clipBehavior: Clip.antiAlias,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(21)),
            elevation: 2,
          ),
          Padding(
            padding: const EdgeInsets.all(7.0),
            child: Text(
              cardText,
              style: TextStyle(fontSize: 17),
            ),
          )
        ],
      ),
    );
  }
}
