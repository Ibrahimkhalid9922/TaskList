import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:task_list/firebase_services/auth_services.dart';
import 'package:task_list/screens/authentication/controller/appControllers.dart';
import 'package:task_list/screens/authentication/view/signup.dart';
import 'package:task_list/utils/constants/colors.dart';
import 'package:task_list/widgets/button.dart';

class Sign_in extends StatefulWidget {
  const Sign_in({super.key});

  @override
  _Sign_inState createState() => _Sign_inState();
}

class _Sign_inState extends State<Sign_in> {
  bool _obscureText = true;
  final SigninController controller = SigninController();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: AppColor.themeColor,
        systemNavigationBarColor: AppColor.textColor,
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
                  controller: controller.signinmail,
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
                  controller: controller.signinpass,
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
                  height: 100,
                ),
                Mybutton(
                    ontap: () {
                      AuthService().signin(
                          email: controller.signinmail.text.toString(),
                          password: controller.signinpass.text.toString(),
                          context: context);
                    },
                    title: "Sign in",
                    circular: 25,
                    Width: double.infinity,
                    Height: 45,
                    btnclr: AppColor.buttonColor),
                const SizedBox(
                  height: 70,
                ),
                const Align(
                    alignment: Alignment.bottomRight,
                    child: Text(
                      "Don't have an account?",
                      style:
                          TextStyle(fontWeight: FontWeight.w300, fontSize: 13),
                    )),
                Align(
                    alignment: Alignment.bottomRight,
                    child: InkWell(
                      onTap: () {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (_) => const Sign_up()));
                      },
                      child: const Text(
                        "Sign up",
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
