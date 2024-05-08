import 'package:flutter/material.dart';
import 'package:news_app_ui/utils/utils.dart';



class SearchHeaderWidget extends StatelessWidget {
  const SearchHeaderWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Danh sách Camera Live',
          style: SafeGoogleFont(
            'Mulish',
            fontSize: 32,
            // fontWeight: FontWeight.w100,
            // height: 1,
            color: Color(0xff1a434e),
          ),
        ),
      ],
    );
  }
}