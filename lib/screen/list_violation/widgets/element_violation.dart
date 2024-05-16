


import 'package:flutter/cupertino.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:news_app_ui/dummy_data/violationInfor.dart';
import 'package:news_app_ui/screen/list_violation/widgets/detail_violation.dart';
import 'package:news_app_ui/utils/utils.dart';

class ElementViolation extends StatelessWidget {
  final Violation violation;
  const ElementViolation({super.key,required this.violation});

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double screenWidth = screenSize.width;
    double screenHeight = screenSize.height;
    return GestureDetector(
      onTap: (){
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (_, __, ___) =>DetailViolation(violation: violation) ,
            opaque: false,
            transitionDuration: Duration(seconds: 0),
          ),);
      },
      child: Padding(
        padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
        child: Container(
          width: screenWidth,
          height: 50,
          decoration: BoxDecoration(
              color: Color.fromRGBO(218, 218, 218, 1.0)
          ),
          child: Row(
            children: [
              SizedBox(width: 10,),
              Image.asset("assets/icons/ic_cctv.png",scale: 20,),
              SizedBox(width: 10,),
              Text("Lỗi vi phạm: ${violation.violation}",
                style: SafeGoogleFont(
                  'Mulish',
                  fontSize: 16,
                  // fontWeight: FontWeight.w100,
                  // height: 1,
                  color: HexColor("#ffffff"),
                ),),
              SizedBox(width: 10,),
              Text("Biển số xe: ${violation.licenseplate}",
                style: SafeGoogleFont(
                  'Mulish',
                  fontSize: 16,
                  // fontWeight: FontWeight.w100,
                  // height: 1,
                  color: HexColor("#ffffff"),
                ),),
              SizedBox(width: 10,),
              Text("Thời gian: ${formatTime(violation.timeViolation)}",
                style: SafeGoogleFont(
                  'Mulish',
                  fontSize: 16,
                  // fontWeight: FontWeight.w100,
                  // height: 1,
                  color: HexColor("#ffffff"),
                ),)
            ],
          ),
        ),
      )
      ,
    );
  }
  String formatTime(DateTime dateTime) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');

    String day = twoDigits(dateTime.day);
    String month = twoDigits(dateTime.month);
    String year = twoDigits(dateTime.year); // Lấy hai chữ số cuối của năm

    String hour = twoDigits(dateTime.hour);
    String minute = twoDigits(dateTime.minute);
    String second = twoDigits(dateTime.second);

    return '$day-$month-$year $hour:$minute:$second';
  }
}
