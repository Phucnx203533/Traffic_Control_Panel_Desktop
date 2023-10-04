import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app_ui/utils/utils.dart';
import 'package:news_app_ui/widgets/spacer/spacer_custom.dart';

class DetailInfor extends StatelessWidget {
  final String field;
  final String infor;


  DetailInfor(this.field, this.infor);

  @override
  Widget build(BuildContext context) {
    TextStyle infoTitleStyle = TextStyle(
        color: Colors.black45,
        fontSize: 16,
        fontWeight: FontWeight.bold);
    TextStyle infoTextStyle =
    TextStyle(color: Colors.black45, fontSize: 16);
    return Row(

      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          field,
          style: infoTitleStyle,
        ),
        Text(
          infor,
          style: infoTextStyle,
        ),
      ],
    );
  }
}
