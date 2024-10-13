import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../services/alert_service.dart';
import '../services/auth_service.dart';
import '../services/navigation_service.dart';

class SlidingDashBoard extends StatefulWidget {
  const SlidingDashBoard({super.key});

  @override
  State<SlidingDashBoard> createState() => _SlidingDashBoardState();
}

class _SlidingDashBoardState extends State<SlidingDashBoard> {

  final GetIt _getIt = GetIt.instance;

  late NavigationService _navigationService;
  late AuthService _authService;
  late AlertService _alertService;

  @override
  void initState() {
    super.initState();
    _navigationService = _getIt.get<NavigationService>();
    _authService = _getIt.get<AuthService>();
    _alertService = _getIt.get<AlertService>();
  }

  void showDialogBoxOnLogout() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Sure to Logout?"),
            content: const Text("No worries! You can always login back later :)"),
            actionsAlignment: MainAxisAlignment.spaceBetween,
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("No")),
              TextButton(
                  onPressed: () async {
                    bool result = await _authService.logout();

                    if (result) {
                      _navigationService.pushReplacementNamed("/login");
                      _alertService.showToast(
                          text: "Successfully logged out!",
                          icon: Icons.done,
                          color: Colors.green);
                    } else {
                      _alertService.showToast(
                          text: "Failed to logout, Please try again!",
                          icon: Icons.error,
                          color: Colors.red);
                    }
                  },
                  child: const Text("Yes"))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(

      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
              accountName: const Text(
                  'Aayush Sakpal',
                style: TextStyle(
                  fontSize: 21
                ),
              ),
              accountEmail: const Text('aayush@test.com'),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Image.asset('assets/images/registerScreenImage.png'),
              ),
            ),
            decoration: const BoxDecoration(
              color: Colors.blueAccent
            ),
          ),

          ListTile(
            leading: const Icon(Icons.account_circle),
            title: const Text('Profile'),
            onTap: (){},
          ),

          ListTile(
            leading: const Icon(Icons.history_rounded),
            title: const Text('History'),
            onTap: (){},
          ),

          ListTile(
            leading: const Icon(Icons.feedback_rounded),
            title: const Text('Feedback'),
            onTap: (){},
          ),

          ListTile(
            leading: const Icon(Icons.logout_rounded),
            title: const Text('Logout'),
            onTap: (){
              showDialogBoxOnLogout();
            },
          ),
        ],
      ),
    );
  }
}
