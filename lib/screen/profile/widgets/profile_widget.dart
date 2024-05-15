



import 'package:flutter/cupertino.dart';
import 'package:news_app_ui/main.dart';

class AvatarAndNameWidget extends StatelessWidget {
  const AvatarAndNameWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset("assets/icons/ic_user.png",width: 32,),
        Text("username",style: TextStyle(

        ),)
      ],
    );
  }
}
