import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:task_list/firebase_services/auth_services.dart';
import 'package:task_list/screens/authentication/controller/appControllers.dart';
import 'package:task_list/screens/authentication/view/signin.dart';
import 'package:task_list/utils/constants/colors.dart';
import 'package:task_list/widgets/button.dart';

class Sign_up extends StatefulWidget {
  const Sign_up({super.key});

  @override
  _Sign_upState createState() => _Sign_upState();
}

class _Sign_upState extends State<Sign_up> {
  bool _obscureText = true;
  final SignupController controller = SignupController();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: AppColor.themeColor,
        systemNavigationBarColor: AppColor.textColor,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
    );
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColor.themeColor,
      body: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          height: 500,
          width: double.infinity,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(45),
              topRight: Radius.circular(45),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 30,
                ),
                const Text(
                  "Gmail",
                  style: TextStyle(
                    color: AppColor.themeColor,
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                TextField(
                  controller: controller.signupmail,
                  decoration: const InputDecoration(
                    hintText: "user@gmail.com",
                    suffixIcon: Icon(Icons.mail_outlined),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Password",
                  style: TextStyle(
                    color: AppColor.themeColor,
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                TextField(
                  controller: controller.signuppass,
                  obscureText: _obscureText,
                  decoration: InputDecoration(
                    hintText: "******",
                    suffixIcon: InkWell(
                      onTap: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                      child: Icon(
                        _obscureText
                            ? Icons.remove_red_eye_outlined
                            : Icons.visibility_off_outlined,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Confirm password",
                  style: TextStyle(
                    color: AppColor.themeColor,
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                TextField(
                  controller: controller.signuprepass,
                  obscureText: _obscureText,
                  decoration: InputDecoration(
                    hintText: "******",
                    suffixIcon: InkWell(
                      onTap: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                      child: Icon(
                        _obscureText
                            ? Icons.remove_red_eye_outlined
                            : Icons.visibility_off_outlined,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                Mybutton(
                    ontap: () {
                      AuthService().signup(
                          email: controller.signupmail.text.toString(),
                          password: controller.signuppass.text.toString(),
                          context: context);
                    },
                    title: "Sign up",
                    circular: 25,
                    Width: double.infinity,
                    Height: 45,
                    btnclr: AppColor.buttonColor),
                const SizedBox(
                  height: 30,
                ),
                const Align(
                    alignment: Alignment.bottomRight,
                    child: Text(
                      "Already have an account?",
                      style:
                          TextStyle(fontWeight: FontWeight.w300, fontSize: 13),
                    )),
                Align(
                    alignment: Alignment.bottomRight,
                    child: InkWell(
                      onTap: () {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (_) => const Sign_in()));
                      },
                      child: const Text(
                        "Sign in",
                        style: TextStyle(
                            color: AppColor.buttonColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
