


import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:news_app_ui/paintOverImageLib/image_painter.dart';
import 'package:news_app_ui/paintOverImageLib/src/widgets/_mode_widget.dart';

class CameraInforEntity{
  String name;
  String link;
  String htttpLink;
  String address;
  List<PaintInfo> painHistory ;
  String username;
  String password;
  String idOnFirebase;
  CameraInforEntity(this.name, this.link, this.address,this.idOnFirebase,this.htttpLink):painHistory=<PaintInfo>[],username="",password="";
  void addPainHistory(int x1, int y1, int x2, int y2, PaintMode mode, Color color, String text){
    try{
      Offset offset = new Offset(x1.toDouble(),y1.toDouble());
      Offset offset1 = new Offset(x2.toDouble(),y2.toDouble());
      List<Offset> list = [offset,offset1];
      PaintInfo paintInfo = new PaintInfo(mode: mode, offsets: list, color: color, strokeWidth: 4);
      paintInfo.text = text ?? "line";
      this.painHistory.add(paintInfo);
    }catch(e){
        print(e);
    }

  }
  @override
  String toString() {
    // TODO: implement toString
    if(painHistory.length >0){
      return "name:"+name
          +"\nlink:"+link
          +"\nadrress:"+address
          +"\ncolor:" + painHistory[0].color.toString()
          +"\nText:" +painHistory[0].text
          +"\nmode:"+ painHistory[0].mode.toString()
      ;
    }
    return "name:"+name
        +"\nlink:"+link
        +"\nadrress:"+address;


  }

}
