
import 'package:flutter/material.dart';
import 'package:news_app_ui/utils/constants/app_colors.dart';

class ServiceBox extends StatelessWidget {
  const ServiceBox({
    Key? key,
    required this.title,
    required this.icon,
    this.color,
    this.bgColor,
  }) : super(key: key);

  final String icon;
  final Color? color;
  final Color? bgColor;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width*0.2,
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: this.bgColor,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 1,
            offset: Offset(1, 1),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white
            ),
            child: Image.asset(
              icon,
              width: 24,
              height: 24,
              color: Theme.of(context).primaryColor,
            ),
          ),
          const SizedBox(height: 13),
          Text(
            title,
            style: TextStyle(
              color: color,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          )
        ],
      ),
    );
  }
}