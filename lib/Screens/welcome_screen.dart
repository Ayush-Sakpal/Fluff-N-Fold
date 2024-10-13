import 'package:flutter/material.dart';
import 'package:the_laundry_app/Screens/login_screen.dart';
import 'package:the_laundry_app/Screens/signup_screen.dart';
import 'package:the_laundry_app/widgets/custom_scaffold.dart';
import 'package:the_laundry_app/widgets/welcome_button.dart';

class WelcomeScreen extends StatelessWidget{
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      child: Column(
        children: [
          Flexible(
            flex: 8,
              child: Container(
                padding: EdgeInsets.symmetric(
                  vertical: 0,
                  horizontal: 40.0
                ),
                child: Center(
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: const TextSpan(
                      children: [
                        TextSpan(
                          text: "Welcome!\n",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 45,
                            fontWeight: FontWeight.w600
                          )
                        ),

                        TextSpan(
                          text: "\nEnter details to your customer account",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 21
                          )
                        )
                      ]
                    ),
                  ),
                ),
              )
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: const Flexible(
              flex: 1,
                child: Row(
                  children: [
                    Expanded(child: WelcomeButton(
                      onTap: LoginScreen(),
                      buttonText: 'Login',
                      color: Colors.transparent,
                      textColor: Colors.white,
                    )),

                    Expanded(child: WelcomeButton(
                      onTap: SignupScreen(),
                      buttonText: 'Sign up',
                      color: Colors.white,
                      textColor: Colors.blueAccent,
                    )),

                  ],
                )
            ),
          )
        ],
      )
    );
  }

}