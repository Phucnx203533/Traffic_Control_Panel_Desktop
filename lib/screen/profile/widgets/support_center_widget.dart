import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class SupportCenterHelp extends StatefulWidget {
  const SupportCenterHelp({super.key});

  @override
  State<SupportCenterHelp> createState() => _SupportCenterHelpState();
}

class _SupportCenterHelpState extends State<SupportCenterHelp> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double screenWidth = screenSize.width;
    double screenHeight = screenSize.height;
    return Container(
      width: screenWidth,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Color.fromRGBO(241, 241, 241, 1.0)
      ),
      child:Padding(
        padding: EdgeInsets.all(20),
        child:  Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Trung tâm trợ giúp",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(12, 12, 12, 1.0)),
            ),
            SizedBox(height: 10,),
            Container(
              height: 60,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(width: 0.5, color: Colors.black), // Border dày 1px ở dưới
                ),
              ),
              child: Padding(
                padding: EdgeInsets.all(6),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.info_outline_rounded,color: Color.fromRGBO(12, 12, 12, 1.0),),
                    SizedBox(width: 10,),
                    Text(
                      "Giới thiệu",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color.fromRGBO(12, 12, 12, 1.0)),
                    ),
                    Spacer(),
                    TextButton(onPressed: (){}, child: Icon(Icons.arrow_forward_ios_outlined,color: Color.fromRGBO(12, 12, 12, 1.0),size: 14,))

                  ],
                ),
              )

            ),
            Container(
                height: 60,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(width: 0.5, color: Colors.black), // Border dày 1px ở dưới
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.all(6),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.my_library_books_rounded,color: Color.fromRGBO(12, 12, 12, 1.0),),
                      SizedBox(width: 10,),
                      Text(
                        "Hướng dẫn sử dụng",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color.fromRGBO(12, 12, 12, 1.0)),
                      ),
                      Spacer(),
                      TextButton(onPressed: (){}, child: Icon(Icons.arrow_forward_ios_outlined,color: Color.fromRGBO(12, 12, 12, 1.0),size: 14,))

                    ],
                  ),
                )

            ),
            // SizedBox(height: 10,),
            Container(
                height: 60,
                decoration: BoxDecoration(

                ),
                child: Padding(
                  padding: EdgeInsets.all(6),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(MdiIcons.helpCircleOutline,color: Color.fromRGBO(12, 12, 12, 1.0),),
                      SizedBox(width: 10,),
                      Text(
                        "Câu hỏi thường gặp",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color.fromRGBO(12, 12, 12, 1.0)),
                      ),
                      Spacer(),
                      TextButton(onPressed: (){}, child: Icon(Icons.arrow_forward_ios_outlined,color: Color.fromRGBO(12, 12, 12, 1.0),size: 14,))

                    ],
                  ),
                )

            )


          ],
        ),
      )
    );
  }
}
