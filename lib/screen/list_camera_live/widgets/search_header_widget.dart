import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:news_app_ui/utils/utils.dart';



class SearchHeaderWidget extends StatelessWidget {
  const SearchHeaderWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          'Danh sách Camera Live',
          style: SafeGoogleFont(
            'Mulish',
            fontSize: 24,
            // fontWeight: FontWeight.w100,
            // height: 1,
            color: HexColor("#8d8d8d"),
          ),
        ),
      ],
    );
  }
}