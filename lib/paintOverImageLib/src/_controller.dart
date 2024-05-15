import 'package:flutter/material.dart';
import '../../dummy_data/cameraInfo.dart';
import '../image_painter.dart';
// import 'package:firedart/firedart.dart';

class Controller extends ChangeNotifier {
  late double _strokeWidth;
  late Color _color;
  late PaintMode _mode;
  late String _text;
  late bool _fill;

  final List<Offset?> _offsets = [];

  List<PaintInfo> _paintHistory = [];
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


  set mode(PaintMode value) {
    _mode = value;
  }


  set paintHistory(List<PaintInfo> value) {
    _paintHistory = value;
  }

  bool get onTextUpdateMode =>
      _mode == PaintMode.text &&
      _paintHistory
          .where((element) => element.mode == PaintMode.text)
          .isNotEmpty;

  Controller({
    double strokeWidth = 2.0,
    Color color = Colors.red,
    PaintMode mode = PaintMode.none,
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
    _paintHistory.add(paintInfo);
    notifyListeners();
  }
  void getPaintFromFirebase(CameraInforEntity cameraInforEntity){
    // if(cameraInforEntity.painHistory.length >0){
    //   _paintHistory.addAll(cameraInforEntity.painHistory);
    //
    // }
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
