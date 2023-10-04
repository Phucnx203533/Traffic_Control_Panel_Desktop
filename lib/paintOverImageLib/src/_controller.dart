import 'dart:collection';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:news_app_ui/dummy_data/cameraInfo.dart';

import '../image_painter.dart';
import 'package:firedart/firedart.dart';

class Controller extends ChangeNotifier {
  late double _strokeWidth;
  late Color _color;
  late PaintMode _mode;
  late String _text;
  late bool _fill;

  final List<Offset?> _offsets = [];

  final List<PaintInfo> _paintHistory = [];
  late String _idOnFirebase;
  Offset? _start, _end;

  int _strokeMultiplier = 1;
  bool _paintInProgress = false;

  Paint get brush => Paint()
    ..color = _color
    ..strokeWidth = _strokeWidth * _strokeMultiplier
    ..style = shouldFill ? PaintingStyle.fill : PaintingStyle.stroke;

  PaintMode get mode => _mode;
  String get text=> _text;
  String get idOnFirebase=> _idOnFirebase;
  double get strokeWidth => _strokeWidth;

  double get scaledStrokeWidth => _strokeWidth * _strokeMultiplier;

  bool get busy => _paintInProgress;

  bool get fill => _fill;

  Color get color => _color;

  List<PaintInfo> get paintHistory => _paintHistory;

  List<Offset?> get offsets => _offsets;

  Offset? get start => _start;

  Offset? get end => _end;


  bool get onTextUpdateMode =>
      _mode == PaintMode.text &&
      _paintHistory
          .where((element) => element.mode == PaintMode.text)
          .isNotEmpty;

  Controller({
    double strokeWidth = 2.0,
    Color color = Colors.red,
    PaintMode mode = PaintMode.line,
    String text = '',
    bool fill = false,
    String idOnFirebase ='',
  }) {
    _strokeWidth = strokeWidth;
    _color = color;
    _mode = mode;
    _text = text;
    _fill = fill;
    _idOnFirebase = idOnFirebase;
  }


  void addPaintInfo(PaintInfo paintInfo) {
    for(int i=0;i < _paintHistory.length;i++){
        if(_paintHistory[i].mode == paintInfo.mode){
          _paintHistory.remove(_paintHistory[i]);
          break;
        }
    }
    _paintHistory.add(paintInfo);
    notifyListeners();
  }
  void getPaintFromFirebase(CameraInforEntity cameraInforEntity){
    if(cameraInforEntity.painHistory.length >0){
      _paintHistory.addAll(cameraInforEntity.painHistory);

    }
  }
  void updateFireStoreLine(){
      for(int i =0 ;i<_paintHistory.length;i++){
        HashMap<String,List<dynamic>> value = new HashMap();
        switch(paintHistory[i].mode){
          case PaintMode.centerLane:
            value.putIfAbsent("point_center_lane",()=>addOffsetToList(_paintHistory[i]));
            break;
          case PaintMode.rightDirect:
            value.putIfAbsent("point_right_lane",()=>addOffsetToList(_paintHistory[i]));
            break;
          case PaintMode.leftLane:
            value.putIfAbsent("point_left_lane",()=>addOffsetToList(_paintHistory[i]));
            break;
          case PaintMode.centerDirect:
            value.putIfAbsent("point_center_direct",()=>addOffsetToList(_paintHistory[i]));
            break;
          case PaintMode.rightDirect:
            value.putIfAbsent("point_right_direct",()=>addOffsetToList(_paintHistory[i]));
            break;
          case PaintMode.leftDirect:
            value.putIfAbsent("point_left_direct",()=>addOffsetToList(_paintHistory[i]));
            break;
          case PaintMode.rightDirect:
            value.putIfAbsent("point_right_direct",()=>addOffsetToList(_paintHistory[i]));
            break;
          case PaintMode.rectRedlight:
            value.putIfAbsent("point_rect_lane",()=>addOffsetToList(_paintHistory[i]));
            break;
        }
        try{
          var documentReference = Firestore.instance.collection('cameraIp').document(idOnFirebase);
          documentReference.update(value);
        }catch(e){
          print(e);
        }

      }
  }
  List<dynamic> addOffsetToList(PaintInfo paintInfo){
      List<dynamic> list = [];
      list.add(paintInfo.offsets[0]!.dx.toInt());
      list.add(paintInfo.offsets[0]!.dy.toInt());
      list.add(paintInfo.offsets[1]!.dx.toInt());
        list.add(paintInfo.offsets[1]!.dy.toInt());
      return list;
  }

  void undo() {
    if (_paintHistory.isNotEmpty) {
      _paintHistory.removeLast();
      notifyListeners();
    }
  }

  void clear() {
    if (_paintHistory.isNotEmpty) {
      _paintHistory.clear();
      notifyListeners();
    }
  }

  void setStrokeWidth(double val) {
    _strokeWidth = val;
    notifyListeners();
  }

  void setColor(Color color) {
    _color = color;
    notifyListeners();
  }

  void setMode(PaintMode mode) {
    _mode = mode;
    notifyListeners();
  }

  void setText(String val) {
    _text = val;
    notifyListeners();
  }
  void setIdOnFirebae(String val){
    _idOnFirebase = val;
        notifyListeners();
  }

  void addOffsets(Offset? offset) {
    _offsets.add(offset);
    notifyListeners();
  }

  void setStart(Offset? offset) {
    _start = offset;
    notifyListeners();
  }

  void setEnd(Offset? offset) {
    _end = offset;
    notifyListeners();
  }

  void resetStartAndEnd() {
    _start = null;
    _end = null;
    notifyListeners();
  }

  void update({
    double? strokeWidth,
    Color? color,
    bool? fill,
    PaintMode? mode,
    String? text,
    int? strokeMultiplier,
  }) {
    _strokeWidth = strokeWidth ?? _strokeWidth;
    _color = color ?? _color;
    _fill = fill ?? _fill;
    _mode = mode ?? _mode;
    _text = text ?? _text;
    _strokeMultiplier = strokeMultiplier ?? _strokeMultiplier;
    notifyListeners();
  }

  void setInProgress(bool val) {
    _paintInProgress = val;
    notifyListeners();
  }

  bool get shouldFill {
    if (mode == PaintMode.circle || mode == PaintMode.rectRedlight) {
      return _fill;
    } else {
      return false;
    }
  }
}

extension ControllerExt on Controller {
  bool canFill() {
    return mode == PaintMode.circle || mode == PaintMode.rectRedlight;
  }
}
