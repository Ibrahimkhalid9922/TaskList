import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:task_list/screens/authentication/view/signin.dart';
import 'package:task_list/utils/constants/colors.dart';
import 'package:task_list/widgets/button.dart';

class StartedScreen extends StatelessWidget {
  const StartedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: AppColor.themeColor,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: AppColor.themeColor,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
    );
    return Scaffold(
      backgroundColor: AppColor.themeColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 150,
              ),
              Center(
                child: Image.asset(
                  "assets/task.png",
                  height: 200,
                ),
              ),
              const SizedBox(
                height: 160,
              ),
              RichText(
                text: const TextSpan(children: [
                  TextSpan(
                    text: "Daily Tasks are the milestones towards",
                    style: TextStyle(
                        color: AppColor.textColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                  WidgetSpan(
                      child: SizedBox(
                    width: 120,
                  )),
                  TextSpan(
                    text: "Success",
                    style: TextStyle(
                        color: AppColor.textColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                ]),
              ),
              const SizedBox(height: 25),
              Mybutton(
                  ontap: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (_) => const Sign_in()));
                  },
                  title: "Get Started",
                  circular: 25,
                  Width: double.infinity,
                  Height: 45,
                  btnclr: AppColor.buttonColor)
            ],
          ),
        ),
      ),
    );
  }
}
