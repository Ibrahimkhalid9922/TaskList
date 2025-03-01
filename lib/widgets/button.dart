import 'package:flutter/material.dart';
import 'package:task_list/utils/constants/colors.dart';

class Mybutton extends StatelessWidget {
  final String title;
  final ontap;
  final double circular;
  final double Width;
  final double Height;
  final Color btnclr;
  const Mybutton(
      {required this.title,
      this.ontap,
      required this.circular,
      required this.Width,
      required this.Height,
      required this.btnclr});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Container(
        height: Height,
        width: Width,
        decoration: BoxDecoration(
          color: btnclr,
          borderRadius: BorderRadius.circular(circular),
        ),
        child: Center(
            child: Text(
          title,
          style: TextStyle(color: AppColor.textColor),
        )),
      ),
    );
  }
}
