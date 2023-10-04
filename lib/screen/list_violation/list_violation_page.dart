
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app_ui/screen/list_violation/widgets/list_violation.dart';
import 'package:news_app_ui/utils/utils.dart';
import 'package:news_app_ui/widgets/spacer/spacer_custom.dart';

class ListViolationPage extends StatefulWidget {
  const ListViolationPage({super.key});

  @override
  State<ListViolationPage> createState() => _ListViolationState();
}

class _ListViolationState extends State<ListViolationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Row(
            // mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'Danh sách vi phạm',
                style: SafeGoogleFont(
                  'Mulish',
                  fontSize: 32,
                  // fontWeight: FontWeight.w100,
                  // height: 1,
                  color: Color(0xff1a434e),
                ),
              ),
            ],
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24.0, 45, 24, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomHeightSpacer(
                size: 0.04,
              ),
              ListViolation(),

            ],
          ),
        ),
      ),
    );;
  }
}
