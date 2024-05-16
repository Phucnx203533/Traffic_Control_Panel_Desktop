import 'dart:async';
import 'dart:io' show File;
import 'dart:ui' as ui;
import 'dart:math' as math;
import 'package:flutter/material.dart' hide Image;
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
import 'package:panara_dialogs/panara_dialogs.dart';
import '../../dummy_data/cameraInfo.dart';
import '../../api/cameraInforApi.dart';
import '_controller.dart';
import '_image_painter.dart';
import '_signature_painter.dart';
import 'delegates/text_delegate.dart';
import 'widgets/_color_widget.dart';
import 'widgets/_mode_widget.dart';
import 'widgets/_range_slider.dart';
import 'widgets/_text_dialog.dart';

export '_image_painter.dart';
// import 'package:firedart/firedart.dart';

///[ImagePainter] widget.
@immutable
class ImagePainter extends StatefulWidget {
  const ImagePainter._(
      {Key? key,
      this.assetPath,
      this.networkUrl,
      this.byteArray,
      this.file,
      this.height,
      this.width,
      this.placeHolder,
      this.isScalable,
      this.brushIcon,
      this.clearAllIcon,
      this.colorIcon,
      this.undoIcon,
      this.isSignature = false,
      this.controlsAtTop = true,
      this.signatureBackgroundColor = Colors.white,
      this.colors,
      this.initialPaintMode,
      this.initialStrokeWidth,
      this.initialColor,
      this.onColorChanged,
      this.onStrokeWidthChanged,
      this.onPaintModeChanged,
      this.textDelegate,
      this.showControls = true,
      required this.cameraInforEntity})
      : super(key: key);

  ///Constructor for loading image from network url.
  factory ImagePainter.network(String url,
      {required Key key,
      double? height,
      double? width,
      Widget? placeholderWidget,
      bool? scalable,
      List<Color>? colors,
      Widget? brushIcon,
      Widget? undoIcon,
      Widget? clearAllIcon,
      Widget? colorIcon,
      PaintMode? initialPaintMode,
      double? initialStrokeWidth,
      Color? initialColor,
      ValueChanged<PaintMode>? onPaintModeChanged,
      ValueChanged<Color>? onColorChanged,
      ValueChanged<double>? onStrokeWidthChanged,
      TextDelegate? textDelegate,
      bool? controlsAtTop,
      bool? showControls,
      CameraInforEntity? cameraInforEntity}) {
    return ImagePainter._(
        key: key,
        networkUrl: url,
        height: height,
        width: width,
        placeHolder: placeholderWidget,
        isScalable: scalable,
        colors: colors,
        brushIcon: brushIcon,
        undoIcon: undoIcon,
        colorIcon: colorIcon,
        clearAllIcon: clearAllIcon,
        initialPaintMode: initialPaintMode,
        initialColor: initialColor,
        initialStrokeWidth: initialStrokeWidth,
        onPaintModeChanged: onPaintModeChanged,
        onColorChanged: onColorChanged,
        onStrokeWidthChanged: onStrokeWidthChanged,
        textDelegate: textDelegate,
        controlsAtTop: controlsAtTop ?? true,
        showControls: showControls ?? true,
        cameraInforEntity: cameraInforEntity ??
            CameraInforEntity(
                " ", " ", " ", " ", " ", " ", " ", " ", 0, 0, 0, " ", ""));
  }

  ///Constructor for loading image from assetPath.
  // factory ImagePainter.asset(
  //   String path, {
  //   required Key key,
  //   double? height,
  //   double? width,
  //   bool? scalable,
  //   Widget? placeholderWidget,
  //   List<Color>? colors,
  //   Widget? brushIcon,
  //   Widget? undoIcon,
  //   Widget? clearAllIcon,
  //   Widget? colorIcon,
  //   PaintMode? initialPaintMode,
  //   double? initialStrokeWidth,
  //   Color? initialColor,
  //   ValueChanged<PaintMode>? onPaintModeChanged,
  //   ValueChanged<Color>? onColorChanged,
  //   ValueChanged<double>? onStrokeWidthChanged,
  //   TextDelegate? textDelegate,
  //   bool? controlsAtTop,
  //   bool? showControls,
  // }) {
  //   return ImagePainter._(
  //     key: key,
  //     assetPath: path,
  //     height: height,
  //     width: width,
  //     isScalable: scalable ?? false,
  //     placeHolder: placeholderWidget,
  //     colors: colors,
  //     brushIcon: brushIcon,
  //     undoIcon: undoIcon,
  //     colorIcon: colorIcon,
  //     clearAllIcon: clearAllIcon,
  //     initialPaintMode: initialPaintMode,
  //     initialColor: initialColor,
  //     initialStrokeWidth: initialStrokeWidth,
  //     onPaintModeChanged: onPaintModeChanged,
  //     onColorChanged: onColorChanged,
  //     onStrokeWidthChanged: onStrokeWidthChanged,
  //     textDelegate: textDelegate,
  //     controlsAtTop: controlsAtTop ?? true,
  //     showControls: showControls ?? true,
  //   );
  // }

  ///Constructor for loading image from [File].
  // factory ImagePainter.file(
  //   File file, {
  //   required Key key,
  //   double? height,
  //   double? width,
  //   bool? scalable,
  //   Widget? placeholderWidget,
  //   List<Color>? colors,
  //   Widget? brushIcon,
  //   Widget? undoIcon,
  //   Widget? clearAllIcon,
  //   Widget? colorIcon,
  //   PaintMode? initialPaintMode,
  //   double? initialStrokeWidth,
  //   Color? initialColor,
  //   ValueChanged<PaintMode>? onPaintModeChanged,
  //   ValueChanged<Color>? onColorChanged,
  //   ValueChanged<double>? onStrokeWidthChanged,
  //   TextDelegate? textDelegate,
  //   bool? controlsAtTop,
  //   bool? showControls,
  // }) {
  //   return ImagePainter._(
  //     key: key,
  //     file: file,
  //     height: height,
  //     width: width,
  //     placeHolder: placeholderWidget,
  //     colors: colors,
  //     isScalable: scalable ?? false,
  //     brushIcon: brushIcon,
  //     undoIcon: undoIcon,
  //     colorIcon: colorIcon,
  //     clearAllIcon: clearAllIcon,
  //     initialPaintMode: initialPaintMode,
  //     initialColor: initialColor,
  //     initialStrokeWidth: initialStrokeWidth,
  //     onPaintModeChanged: onPaintModeChanged,
  //     onColorChanged: onColorChanged,
  //     onStrokeWidthChanged: onStrokeWidthChanged,
  //     textDelegate: textDelegate,
  //     controlsAtTop: controlsAtTop ?? true,
  //     showControls: showControls ?? true,
  //   );
  // }

  ///Constructor for loading image from memory.
  factory ImagePainter.memory(Uint8List byteArray,
      {required Key key,
      double? height,
      double? width,
      bool? scalable,
      Widget? placeholderWidget,
      List<Color>? colors,
      Widget? brushIcon,
      Widget? undoIcon,
      Widget? clearAllIcon,
      Widget? colorIcon,
      PaintMode? initialPaintMode,
      double? initialStrokeWidth,
      Color? initialColor,
      ValueChanged<PaintMode>? onPaintModeChanged,
      ValueChanged<Color>? onColorChanged,
      ValueChanged<double>? onStrokeWidthChanged,
      TextDelegate? textDelegate,
      bool? controlsAtTop,
      bool? showControls,
      CameraInforEntity? cameraInforEntity}) {
    return ImagePainter._(
        key: key,
        byteArray: byteArray,
        height: height,
        width: width,
        placeHolder: placeholderWidget,
        isScalable: scalable ?? false,
        colors: colors,
        brushIcon: brushIcon,
        undoIcon: undoIcon,
        colorIcon: colorIcon,
        clearAllIcon: clearAllIcon,
        initialPaintMode: initialPaintMode,
        initialColor: initialColor,
        initialStrokeWidth: initialStrokeWidth,
        onPaintModeChanged: onPaintModeChanged,
        onColorChanged: onColorChanged,
        onStrokeWidthChanged: onStrokeWidthChanged,
        textDelegate: textDelegate,
        controlsAtTop: controlsAtTop ?? true,
        showControls: showControls ?? true,
        cameraInforEntity: cameraInforEntity ??
            CameraInforEntity(
                " ", " ", " ", " ", " ", " ", " ", " ", 0, 0, 0, " ", ""));
  }

  ///Constructor for signature painting.
  // factory ImagePainter.signature({
  //   required Key key,
  //   Color? signatureBgColor,
  //   double? height,
  //   double? width,
  //   List<Color>? colors,
  //   Widget? brushIcon,
  //   Widget? undoIcon,
  //   Widget? clearAllIcon,
  //   Widget? colorIcon,
  //   ValueChanged<PaintMode>? onPaintModeChanged,
  //   ValueChanged<Color>? onColorChanged,
  //   ValueChanged<double>? onStrokeWidthChanged,
  //   TextDelegate? textDelegate,
  //   bool? controlsAtTop,
  //   bool? showControls,
  // }) {
  //   return ImagePainter._(
  //     key: key,
  //     height: height,
  //     width: width,
  //     isSignature: true,
  //     isScalable: false,
  //     colors: colors,
  //     signatureBackgroundColor: signatureBgColor ?? Colors.white,
  //     brushIcon: brushIcon,
  //     undoIcon: undoIcon,
  //     colorIcon: colorIcon,
  //     clearAllIcon: clearAllIcon,
  //     onPaintModeChanged: onPaintModeChanged,
  //     onColorChanged: onColorChanged,
  //     onStrokeWidthChanged: onStrokeWidthChanged,
  //     textDelegate: textDelegate,
  //     controlsAtTop: controlsAtTop ?? true,
  //     showControls: showControls ?? true,
  //   );
  // }

  ///Only accessible through [ImagePainter.network] constructor.
  final String? networkUrl;

  ///Only accessible through [ImagePainter.memory] constructor.
  final Uint8List? byteArray;

  ///Only accessible through [ImagePainter.file] constructor.
  final File? file;

  ///Only accessible through [ImagePainter.asset] constructor.
  final String? assetPath;

  ///Height of the Widget. Image is subjected to fit within the given height.
  final double? height;

  ///Width of the widget. Image is subjected to fit within the given width.
  final double? width;

  ///Widget to be shown during the conversion of provided image to [ui.Image].
  final Widget? placeHolder;

  ///Defines whether the widget should be scaled or not. Defaults to [false].
  final bool? isScalable;

  ///Flag to determine signature or image;
  final bool isSignature;

  ///Signature mode background color
  final Color signatureBackgroundColor;

  ///List of colors for color selection
  ///If not provided, default colors are used.
  final List<Color>? colors;

  ///Icon Widget of strokeWidth.
  final Widget? brushIcon;

  ///Widget of Color Icon in control bar.
  final Widget? colorIcon;

  ///Widget for Undo last action on control bar.
  final Widget? undoIcon;

  ///Widget for clearing all actions on control bar.
  final Widget? clearAllIcon;

  ///Define where the controls is located.
  ///`true` represents top.
  final bool controlsAtTop;

  ///Initial PaintMode.
  final PaintMode? initialPaintMode;

  //the initial stroke width
  final double? initialStrokeWidth;

  //the initial color
  final Color? initialColor;

  final ValueChanged<Color>? onColorChanged;

  final ValueChanged<double>? onStrokeWidthChanged;

  final ValueChanged<PaintMode>? onPaintModeChanged;

  //the text delegate
  final TextDelegate? textDelegate;

  ///It will control displaying the Control Bar
  final bool showControls;

  final CameraInforEntity cameraInforEntity;
  @override
  ImagePainterState createState() => ImagePainterState();
}

///
class ImagePainterState extends State<ImagePainter> {
  final _repaintKey = GlobalKey();
  ui.Image? _image;
  late Controller _controller;
  late final ValueNotifier<bool> _isLoaded;
  late final TextEditingController _textController;
  late final TransformationController _transformationController;
  late List<PaintInfo> list;
  int _strokeMultiplier = 1;
  late TextDelegate textDelegate;
  CameraInforApi request = CameraInforApi();

  Future<void> getRuleConfig() async {
    Map<String, dynamic> res =
        await request.getRuleConfig(widget.cameraInforEntity.id);
    List<PaintInfo> tmp = [];
    if (res['code'] == "000") {
      List<dynamic> listTrafficLightConfig =
          res['data']['trafficLightEntities'];
      listTrafficLightConfig.forEach((element) {
        PaintInfo info = PaintInfo(
            mode: PaintMode.rectRedlight,
            offsets: [
              Offset(element['location'][0], element['location'][1]),
              Offset(element['location'][2], element['location'][3])
            ],
            color: Colors.white,
            strokeWidth: 2.0);
        info.text = element['name'];
        tmp.add(info);
      });
      List<dynamic> listLineConfig = res['data']['lineEntities'];
      listLineConfig.forEach((element) {
        PaintInfo info = PaintInfo(
            mode: PaintMode.line,
            offsets: [
              Offset(element['location'][0], element['location'][1]),
              Offset(element['location'][2], element['location'][3])
            ],
            color: Colors.yellow,
            strokeWidth: 2.0);
        info.text = element['name'];

        List<String> tmp_attribute = [];
        for (var item in element['attributes']) {
          tmp_attribute.add(item.toString());
        }
        info.attributes = tmp_attribute;
        tmp.add(info);
      });
      setState(() {
        _controller.paintHistory = tmp;
        list = tmp;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    list = [];
    _isLoaded = ValueNotifier<bool>(false);
    _controller = Controller();
    // _controller.getPaintFromFirebase(widget.cameraInforEntity);
    // _controller.setIdOnFirebae(widget.cameraInforEntity.idOnFirebase);
    if (widget.isSignature) {
      _controller.update(
        mode: PaintMode.freeStyle,
        color: Colors.black,
      );
    } else {
      _controller.update(
        mode: widget.initialPaintMode,
        strokeWidth: widget.initialStrokeWidth,
        color: widget.initialColor,
      );
    }
    getRuleConfig();
    _resolveAndConvertImage();

    _textController = TextEditingController();
    _transformationController = TransformationController();
    textDelegate = widget.textDelegate ?? TextDelegate();
  }

  @override
  void dispose() {
    _controller.dispose();
    _isLoaded.dispose();
    _textController.dispose();
    _transformationController.dispose();
    super.dispose();
  }

  bool get isEdited => _controller.paintHistory.isNotEmpty;

  Size get imageSize =>
      Size(_image?.width.toDouble() ?? 0, _image?.height.toDouble() ?? 0);

  ///Converts the incoming image type from constructor to [ui.Image]
  Future<void> _resolveAndConvertImage() async {
    if (widget.networkUrl != null) {
      _image = await _loadNetworkImage(widget.networkUrl!);
      if (_image == null) {
        throw ("${widget.networkUrl} couldn't be resolved.");
      } else {
        _setStrokeMultiplier();
      }
    } else if (widget.assetPath != null) {
      final img = await rootBundle.load(widget.assetPath!);
      _image = await _convertImage(Uint8List.view(img.buffer));
      if (_image == null) {
        throw ("${widget.assetPath} couldn't be resolved.");
      } else {
        _setStrokeMultiplier();
      }
    } else if (widget.file != null) {
      final img = await widget.file!.readAsBytes();
      _image = await _convertImage(img);
      if (_image == null) {
        throw ("Image couldn't be resolved from provided file.");
      } else {
        _setStrokeMultiplier();
      }
    } else if (widget.byteArray != null) {
      _image = await _convertImage(widget.byteArray!);
      if (_image == null) {
        throw ("Image couldn't be resolved from provided byteArray.");
      } else {
        _setStrokeMultiplier();
      }
    } else {
      _isLoaded.value = true;
    }
  }

  ///Dynamically sets stroke multiplier on the basis of widget size.
  ///Implemented to avoid thin stroke on high res images.
  _setStrokeMultiplier() {
    if ((_image!.height + _image!.width) > 1000) {
      _strokeMultiplier = (_image!.height + _image!.width) ~/ 1000;
    }
    _controller.update(strokeMultiplier: _strokeMultiplier);
  }

  ///Completer function to convert asset or file image to [ui.Image] before drawing on custompainter.
  Future<ui.Image> _convertImage(Uint8List img) async {
    final completer = Completer<ui.Image>();
    ui.decodeImageFromList(img, (image) {
      _isLoaded.value = true;
      return completer.complete(image);
    });
    return completer.future;
  }

  ///Completer function to convert network image to [ui.Image] before drawing on custompainter.
  Future<ui.Image> _loadNetworkImage(String path) async {
    final completer = Completer<ImageInfo>();
    final img = NetworkImage(path);
    img.resolve(const ImageConfiguration()).addListener(
        ImageStreamListener((info, _) => completer.complete(info)));
    final imageInfo = await completer.future;
    _isLoaded.value = true;
    return imageInfo.image;
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: _isLoaded,
      builder: (_, loaded, __) {
        if (loaded) {
          return _paintImage(context);
          // return _paintSignature();
        } else {
          return Container(
            height: widget.height ?? double.maxFinite,
            width: widget.width ?? double.maxFinite,
            child: Center(
              child: widget.placeHolder ?? const CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }

  ///paints image on given constrains for drawing if image is not null.
  Widget _paintImage(context) {
    Size screenSize = MediaQuery.of(context).size;
    double screenWidth = screenSize.width;
    double screenHeight = screenSize.height;
    return OrientationBuilder(builder: (context, orientation) {
      return Center(
        child: SizedBox(
          height: screenHeight,
          width: screenWidth,
          child: orientation == Orientation.portrait
              ? Container(
                  height: double.maxFinite,
                  width: double.maxFinite,
                  child: Column(
                    children: [
                      if (widget.controlsAtTop && widget.showControls)
                        _buildControls(),
                      FittedBox(
                        alignment: FractionalOffset.center,
                        child: ClipRect(
                          child: AnimatedBuilder(
                            animation: _controller,
                            builder: (context, child) {
                              return InteractiveViewer(
                                transformationController:
                                    _transformationController,
                                panEnabled: _controller.mode == PaintMode.none,
                                scaleEnabled: false,
                                onInteractionUpdate: _scaleUpdateGesture,
                                onInteractionEnd: _scaleEndGesture,
                                child: CustomPaint(
                                  size: imageSize,
                                  willChange: true,
                                  isComplex: true,
                                  painter: DrawImage(
                                    image: _image,
                                    controller: _controller,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SingleChildScrollView(
                        child: Container(
                            width: screenWidth,
                            child: Column(
                              children: [
                                Text("Danh sách đường kẻ vẽ"),
                                ListView.builder(
                                  shrinkWrap: true,
                                  physics:
                                      const AlwaysScrollableScrollPhysics(),
                                  itemCount: list.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Padding(
                                      padding: EdgeInsets.fromLTRB(5, 3, 5, 3),
                                      child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            border: Border.all(
                                              color: Colors
                                                  .black, // Màu của border
                                              width: 1, // Độ dày của border
                                            ),
                                          ),
                                          child: GestureDetector(
                                            onTap: () {
                                              _editPaintHistory(_controller
                                                  .paintHistory[index]);
                                            },
                                            child: Row(
                                              children: [
                                                SizedBox(
                                                  width: 2,
                                                ),
                                                if(list[index].mode ==PaintMode.line)
                                                  Icon(Icons.horizontal_rule),
                                                if(list[index].mode !=PaintMode.line)
                                                  Icon(Icons.traffic_outlined),
                                                Text(list[index].text),
                                                Spacer(),
                                                TextButton(
                                                    onPressed: () async {
                                                      setState(() {
                                                        list.remove(
                                                            list[index]);
                                                      });
                                                      _controller.paintHistory
                                                          .remove(_controller
                                                                  .paintHistory[
                                                              index]);
                                                    },
                                                    child: Icon(
                                                      Icons.delete,
                                                      color: Colors.black,
                                                    )),
                                              ],
                                            ),
                                          )),
                                    );
                                  },
                                ),
                              ],
                            )),
                      ),
                      // if (!widget.controlsAtTop && widget.showControls) _buildControls(),
                      SizedBox(height: MediaQuery.of(context).padding.bottom)
                    ],
                  ))
              : Container(
                  height: screenHeight,
                  width: screenWidth,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        if (widget.controlsAtTop && widget.showControls)
                          _buildControls(),
                        Row(
                          children: [
                            Expanded(
                              child: FittedBox(
                                alignment: FractionalOffset.center,
                                child: ClipRect(
                                  child: AnimatedBuilder(
                                    animation: _controller,
                                    builder: (context, child) {
                                      return InteractiveViewer(
                                        transformationController:
                                            _transformationController,
                                        // maxScale: 2.4,
                                        // minScale: 1,
                                        panEnabled:
                                            _controller.mode == PaintMode.none,
                                        // scaleEnabled: widget.isScalable!,
                                        scaleEnabled: false,
                                        onInteractionUpdate:
                                            _scaleUpdateGesture,
                                        onInteractionEnd: _scaleEndGesture,
                                        child: CustomPaint(
                                          size: imageSize,
                                          willChange: true,
                                          isComplex: true,
                                          painter: DrawImage(
                                            image: _image,
                                            controller: _controller,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                            SingleChildScrollView(
                              child: Container(
                                  width: screenWidth * 0.2,
                                  child: Column(
                                    children: [
                                      Text("Danh sách đường kẻ vẽ"),
                                      ListView.builder(
                                        shrinkWrap: true,
                                        physics:
                                            const AlwaysScrollableScrollPhysics(),
                                        itemCount: list.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return Padding(
                                            padding:
                                                EdgeInsets.fromLTRB(5, 3, 5, 3),
                                            child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  border: Border.all(
                                                    color: Colors
                                                        .black, // Màu của border
                                                    width:
                                                        1, // Độ dày của border
                                                  ),
                                                ),
                                                child: GestureDetector(
                                                  onTap: () {
                                                    _editPaintHistory(
                                                        _controller
                                                                .paintHistory[
                                                            index]);
                                                  },
                                                  child: Row(
                                                    children: [
                                                      SizedBox(
                                                        width: 2,
                                                      ),
                                                      if(list[index].mode ==PaintMode.line)
                                                        Icon(Icons.horizontal_rule),
                                                      if(list[index].mode !=PaintMode.line)
                                                        Icon(Icons.traffic_outlined),
                                                      Text(list[index].text),
                                                      Spacer(),
                                                      TextButton(
                                                          onPressed: () async {
                                                            setState(() {
                                                              list.remove(
                                                                  list[index]);
                                                            });
                                                            _controller
                                                                .paintHistory
                                                                .remove(_controller
                                                                        .paintHistory[
                                                                    index]);
                                                          },
                                                          child: Icon(
                                                            Icons.delete,
                                                            color: Colors.black,
                                                          )),
                                                    ],
                                                  ),
                                                )),
                                          );
                                        },
                                      ),
                                    ],
                                  )),
                            ),
                          ],
                        )

                        // if (!widget.controlsAtTop && widget.showControls) _buildControls(),
                        // SizedBox(height: MediaQuery.of(context).padding.bottom)
                      ],
                    ),
                  )),
        ),
      );
    });
  }

  Widget _paintSignature() {
    return Stack(
      children: [
        RepaintBoundary(
          key: _repaintKey,
          child: ClipRect(
            child: Container(
              width: widget.width ?? double.maxFinite,
              height: widget.height ?? double.maxFinite,
              child: AnimatedBuilder(
                animation: _controller,
                builder: (_, __) {
                  return InteractiveViewer(
                    transformationController: _transformationController,
                    panEnabled: false,
                    scaleEnabled: false,
                    onInteractionStart: _scaleStartGesture,
                    onInteractionUpdate: _scaleUpdateGesture,
                    onInteractionEnd: _scaleEndGesture,
                    child: CustomPaint(
                      willChange: true,
                      isComplex: true,
                      painter: SignaturePainter(
                        backgroundColor: widget.signatureBackgroundColor,
                        controller: _controller,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
        if (widget.showControls)
          Positioned(
            top: 0,
            right: 0,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  tooltip: textDelegate.undo,
                  icon: widget.undoIcon ??
                      Icon(Icons.reply, color: Colors.grey[700]),
                  onPressed: () => _controller.undo(),
                ),
                IconButton(
                  tooltip: textDelegate.clearAllProgress,
                  icon: widget.clearAllIcon ??
                      Icon(Icons.clear, color: Colors.grey[700]),
                  onPressed: () => _controller.clear(),
                ),
              ],
            ),
          ),
      ],
    );
  }

  _scaleStartGesture(ScaleStartDetails onStart) {
    final _zoomAdjustedOffset =
        _transformationController.toScene(onStart.localFocalPoint);
    if (!widget.isSignature) {
      _controller.setStart(_zoomAdjustedOffset);
      _controller.addOffsets(_zoomAdjustedOffset);
    }
  }

  ///Fires while user is interacting with the screen to record painting.
  void _scaleUpdateGesture(ScaleUpdateDetails onUpdate) {
    final _zoomAdjustedOffset =
        _transformationController.toScene(onUpdate.localFocalPoint);
    _controller.setInProgress(true);
    if (_controller.start == null) {
      _controller.setStart(_zoomAdjustedOffset);
    }
    _controller.setEnd(_zoomAdjustedOffset);
    if (_controller.mode == PaintMode.freeStyle) {
      _controller.addOffsets(_zoomAdjustedOffset);
    }
    if (_controller.onTextUpdateMode) {
      _controller.paintHistory
          .lastWhere((element) => element.mode == PaintMode.text)
          .offsets = [_zoomAdjustedOffset];
    }
  }

  ///Fires when user stops interacting with the screen.
  void _scaleEndGesture(ScaleEndDetails onEnd) {
    _controller.setInProgress(false);
    if (_controller.start != null &&
        _controller.end != null &&
        (_controller.mode == PaintMode.freeStyle)) {
      _controller.addOffsets(null);
      // _addFreeStylePoints();
      _controller.offsets.clear();
    } else if (_controller.start != null &&
        _controller.end != null &&
        _controller.mode != PaintMode.none) {
      // _addEndPoints();
      PaintInfo info = PaintInfo(
        offsets: <Offset?>[_controller.start, _controller.end],
        mode: _controller.mode,
        color: _controller.color,
        strokeWidth: _controller.scaledStrokeWidth,
        fill: _controller.fill,
        text: _controller.text,
      );
      setState(() {
        list.add(info);
        _addPaintHistory(info);
      });
    }
    _controller.resetStartAndEnd();
  }

  void _addEndPoints() => _addPaintHistory(
        PaintInfo(
          offsets: <Offset?>[_controller.start, _controller.end],
          mode: _controller.mode,
          color: _controller.color,
          strokeWidth: _controller.scaledStrokeWidth,
          fill: _controller.fill,
          text: _controller.text,
        ),
      );

  void _addFreeStylePoints() => _addPaintHistory(
        PaintInfo(
          offsets: <Offset?>[..._controller.offsets],
          mode: PaintMode.freeStyle,
          color: _controller.color,
          strokeWidth: _controller.scaledStrokeWidth,
          text: _controller.text,
        ),
      );

  ///Provides [ui.Image] of the recorded canvas to perform action.
  Future<ui.Image> _renderImage() async {
    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder);
    final painter = DrawImage(image: _image, controller: _controller);
    final size = Size(_image!.width.toDouble(), _image!.height.toDouble());
    painter.paint(canvas, size);
    return recorder
        .endRecording()
        .toImage(size.width.floor(), size.height.floor());
  }

  PopupMenuItem _showOptionsRow() {
    return PopupMenuItem(
      enabled: false,
      child: Center(
        child: SizedBox(
          child: Wrap(
            children: paintModes(textDelegate)
                .map(
                  (item) => SelectionItems(
                    data: item,
                    isSelected: _controller.mode == item.mode,
                    onTap: () {
                      if (widget.onPaintModeChanged != null) {
                        widget.onPaintModeChanged!(item.mode);
                      }
                      _controller.setMode(item.mode);
                      _controller.setColor(item.color);
                      _controller.setText(item.label);
                      Navigator.of(context).pop();
                    },
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }

  PopupMenuItem _showRangeSlider() {
    return PopupMenuItem(
      enabled: false,
      child: SizedBox(
        width: double.maxFinite,
        child: AnimatedBuilder(
          animation: _controller,
          builder: (_, __) {
            return RangedSlider(
              value: _controller.strokeWidth,
              onChanged: (value) {
                _controller.setStrokeWidth(value);
                if (widget.onStrokeWidthChanged != null) {
                  widget.onStrokeWidthChanged!(value);
                }
              },
            );
          },
        ),
      ),
    );
  }

  PopupMenuItem _showColorPicker() {
    return PopupMenuItem(
      enabled: false,
      child: Center(
        child: Wrap(
          alignment: WrapAlignment.center,
          spacing: 10,
          runSpacing: 10,
          children: (widget.colors ?? editorColors).map((color) {
            return ColorItem(
              isSelected: color == _controller.color,
              color: color,
              onTap: () {
                _controller.setColor(color);
                if (widget.onColorChanged != null) {
                  widget.onColorChanged!(color);
                }
                Navigator.pop(context);
              },
            );
          }).toList(),
        ),
      ),
    );
  }

  ///Generates [Uint8List] of the [ui.Image] generated by the [renderImage()] method.
  ///Can be converted to image file by writing as bytes.
  Future<Uint8List?> exportImage() async {
    late ui.Image _convertedImage;
    if (widget.isSignature) {
      final _boundary = _repaintKey.currentContext!.findRenderObject()
          as RenderRepaintBoundary;
      _convertedImage = await _boundary.toImage(pixelRatio: 3);
    } else if (widget.byteArray != null && _controller.paintHistory.isEmpty) {
      return widget.byteArray;
    } else {
      _convertedImage = await _renderImage();
    }
    final byteData =
        await _convertedImage.toByteData(format: ui.ImageByteFormat.png);
    return byteData?.buffer.asUint8List();
  }

  void _editPaintHistory(PaintInfo info) {
    final nameLineController = TextEditingController();
    final directController = MultiSelectController<ValueItem>();
    final typeTrafficController = MultiSelectController<ValueItem>();
    nameLineController.text = info.text;
    bool isValidateName = false;
    bool isValidateDirect = false;
    bool isValidateType = false;
    bool isValidated = true;
    double tanx = (info.offsets[0]!.dy-info.offsets[1]!.dy).abs()/(info.offsets[0]!.dx-info.offsets[1]!.dx).abs();
    bool isHorizontal = tanx<math.tan(30*(math.pi/180));
    final List<ValueItem<ValueItem<dynamic>>> directlist = [

      isHorizontal?ValueItem(
          label: 'Từ dưới lên',
          value: ValueItem(label: 'Từ dưới lên', value: -2)):ValueItem(
          label: 'Từ trái qua phải',
          value: ValueItem(label: 'Từ trái qua phải', value: -1)),
      ValueItem(
          label: 'Hai chiều', value: ValueItem(label: 'Hai chiều', value: 0)),

      isHorizontal?ValueItem(
          label: 'Từ trên xuống',
          value: ValueItem(label: 'Từ trên xuống', value: 2)):ValueItem(
          label: 'Từ phải qua trái',
          value: ValueItem(label: 'Từ phải qua trái', value: 1)),
    ];

    final List<ValueItem<ValueItem<dynamic>>> typeList = [
      ValueItem(
          label: 'Người đi bộ',
          value: ValueItem(label: 'Người đi bộ', value: "person")),
      ValueItem(
          label: 'Xe đạp', value: ValueItem(label: 'Xe đạp', value: "bicycle")),
      ValueItem(label: 'Ô tô', value: ValueItem(label: 'Ô tô', value: "car")),
      ValueItem(
          label: 'Xe máy',
          value: ValueItem(label: 'Xe máy', value: "motorcycle")),
      ValueItem(
          label: 'Xe buýt', value: ValueItem(label: 'Xe buýt', value: "bus")),
      ValueItem(
          label: 'Xe tải', value: ValueItem(label: 'Xe tải', value: "truck")),
    ];
    directController.setOptions(directlist);
    typeTrafficController.setOptions(typeList);
    directController.setSelectedOptions(directlist
        .where((element) => element.value!.value == info.direct)
        .toList());
    typeTrafficController.setSelectedOptions(typeList
        .where((element) => info.attributes.contains(element.value!.value))
        .toList());
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text(info.mode == PaintMode.line
                  ? 'Cài đặt làn đường'
                  : 'Cài đặt đèn giao thông'),
              content: SingleChildScrollView(
                child: Wrap(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(info.mode == PaintMode.line
                                ? 'Cài đặt làn đường'
                                : "Cài đặt đèn giao thông"),
                            SizedBox(height: 2),
                            TextField(
                              controller: nameLineController,
                              decoration: InputDecoration(
                                hintText: info.mode== PaintMode.line
                                    ? "Nhập tên làn"
                                    : "Nhập tên đèn",
                                border: OutlineInputBorder(),
                                errorText: isValidateName
                                    ? info.mode == PaintMode.line
                                        ? "Tên làn đường không được để trống"
                                        : "Tên đèn không được để trống"
                                    : null,
                              ),
                              onChanged: (value) {
                                info.text = value;
                                setState(() {
                                  isValidateName = value.isEmpty;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    if (info.mode == PaintMode.line)
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Hướng di chuyển của phương tiện"),
                              SizedBox(height: 2),
                              MultiSelectDropDown(
                                onOptionSelected:
                                    (List<ValueItem> selectedOptions) {
                                  setState(() {
                                    info.direct = selectedOptions.isEmpty
                                        ? 0
                                        : selectedOptions[0].value.value;
                                    isValidateDirect = selectedOptions.isEmpty;
                                  });
                                },
                                options: directlist,
                                hint: "Lựa chọn chiều đi được cho phép",
                                selectionType: SelectionType.single,
                                chipConfig:
                                    const ChipConfig(wrapType: WrapType.wrap),
                                dropdownHeight: 200,
                                controller: directController,
                                optionTextStyle: const TextStyle(fontSize: 16),
                                selectedOptionIcon:
                                    const Icon(Icons.check_circle),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              if (isValidateDirect)
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      "Hướng đi phương tiện không được để trống",
                                      style: TextStyle(
                                          color: Colors.red, fontSize: 12),
                                    )
                                  ],
                                )
                            ],
                          ),
                        ),
                      ),
                    if (info.mode == PaintMode.line)
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Loại phương tiện được phép đi"),
                              SizedBox(height: 2),
                              MultiSelectDropDown<ValueItem<dynamic>>(
                                onOptionSelected:
                                    (List<ValueItem<dynamic>> selectedOptions) {
                                  setState(() {
                                    List<String> tmp_att = [];
                                    selectedOptions.forEach((element) {
                                      tmp_att.add(element.value.value);
                                    });
                                    info.attributes = tmp_att;
                                    isValidateType = selectedOptions.isEmpty;
                                  });
                                },
                                options: typeList,
                                controller: typeTrafficController,
                                hint:
                                    "Lựa chọn các loại phương tiện được cho phép",
                                selectionType: SelectionType.multi,
                                chipConfig:
                                    const ChipConfig(wrapType: WrapType.wrap),
                                dropdownHeight: 300,
                                optionTextStyle: const TextStyle(fontSize: 16),
                                selectedOptionIcon:
                                    const Icon(Icons.check_circle),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              if (isValidateType)
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      "Phương tiện cho phép không được để trống",
                                      style: TextStyle(
                                          color: Colors.red, fontSize: 12),
                                    )
                                  ],
                                )
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  child: Text('Ok'),
                  onPressed: () {
                    setState(() {
                      isValidateName = nameLineController.text.isEmpty;
                      if (info.mode == PaintMode.line) {
                        isValidateDirect =
                            directController.selectedOptions.isEmpty;
                        isValidateType =
                            typeTrafficController.selectedOptions.isEmpty;
                        isValidated = !isValidateName &&
                            !isValidateDirect &&
                            !isValidateType;
                      }else{
                        isValidated = !isValidateName;
                      }
                    });
                    if (isValidated) {
                      Navigator.of(context).pop();
                      // _controller.addPaintInfo(info);
                    }
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _addPaintHistory(PaintInfo info) {
    final nameLineController = TextEditingController();
    final directController = MultiSelectController<ValueItem>();
    final typeTrafficController = MultiSelectController<ValueItem>();

    bool isValidateName = false;
    bool isValidateDirect = false;
    bool isValidateType = false;
    bool isValidated = true;
    double tanx = (info.offsets[0]!.dy-info.offsets[1]!.dy).abs()/(info.offsets[0]!.dx-info.offsets[1]!.dx).abs();
    bool isHorizontal = tanx<math.tan(30*(math.pi/180));
    final List<ValueItem<ValueItem<dynamic>>> directlist = [

      isHorizontal?ValueItem(
          label: 'Từ dưới lên',
          value: ValueItem(label: 'Từ dưới lên', value: -2)):ValueItem(
          label: 'Từ trái qua phải',
          value: ValueItem(label: 'Từ trái qua phải', value: -1)),
      ValueItem(
          label: 'Hai chiều', value: ValueItem(label: 'Hai chiều', value: 0)),

      isHorizontal?ValueItem(
          label: 'Từ trên xuống',
          value: ValueItem(label: 'Từ trên xuống', value: 2)):ValueItem(
          label: 'Từ phải qua trái',
          value: ValueItem(label: 'Từ phải qua trái', value: 1)),
    ];
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text(_controller.mode == PaintMode.line
                  ? 'Cài đặt làn đường'
                  : "Cài đặt đèn giao thông"),
              content: SingleChildScrollView(
                child: Wrap(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Tên làn đường"),
                            SizedBox(height: 2),
                            TextField(
                              controller: nameLineController,
                              decoration: InputDecoration(
                                hintText: _controller.mode == PaintMode.line
                                    ? "Nhập tên làn"
                                    : "Nhập tên đèn giao thông",
                                border: OutlineInputBorder(),
                                errorText: isValidateName
                                    ? _controller.mode == PaintMode.line
                                        ? "Tên làn đường không được để trống"
                                        : "Tên đèn không được để trống"
                                    : null,
                              ),
                              onChanged: (value) {
                                info.text = value;
                                setState(() {
                                  isValidateName = value.isEmpty;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    if (_controller.mode == PaintMode.line)
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Hướng di chuyển của phương tiện"),
                              SizedBox(height: 2),
                              MultiSelectDropDown(
                                onOptionSelected:
                                    (List<ValueItem> selectedOptions) {
                                  setState(() {
                                    info.direct = selectedOptions.isEmpty
                                        ? 0
                                        : selectedOptions[0].value.value;
                                    isValidateDirect = selectedOptions.isEmpty;
                                  });
                                },
                                options: directlist,
                                hint: "Lựa chọn chiều đi được cho phép",
                                selectionType: SelectionType.single,
                                chipConfig:
                                    const ChipConfig(wrapType: WrapType.wrap),
                                dropdownHeight: 200,
                                controller: directController,
                                optionTextStyle: const TextStyle(fontSize: 16),
                                selectedOptionIcon:
                                    const Icon(Icons.check_circle),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              if (isValidateDirect)
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      "Hướng đi phương tiện không được để trống",
                                      style: TextStyle(
                                          color: Colors.red, fontSize: 12),
                                    )
                                  ],
                                )
                            ],
                          ),
                        ),
                      ),
                    if (_controller.mode == PaintMode.line)
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Loại phương tiện được phép đi"),
                              SizedBox(height: 2),
                              MultiSelectDropDown<ValueItem<dynamic>>(
                                onOptionSelected:
                                    (List<ValueItem<dynamic>> selectedOptions) {
                                  setState(() {
                                    List<String> tmp_att = [];
                                    selectedOptions.forEach((element) {
                                      tmp_att.add(element.value.value);
                                    });
                                    info.attributes = tmp_att;
                                    isValidateType = selectedOptions.isEmpty;
                                  });
                                },
                                options: const <ValueItem<ValueItem<dynamic>>>[
                                  ValueItem(
                                      label: 'Người đi bộ',
                                      value: ValueItem(
                                          label: 'Người đi bộ',
                                          value: "person")),
                                  ValueItem(
                                      label: 'Xe đạp',
                                      value: ValueItem(
                                          label: 'Xe đạp', value: "bicycle")),
                                  ValueItem(
                                      label: 'Ô tô',
                                      value: ValueItem(
                                          label: 'Ô tô', value: "car")),
                                  ValueItem(
                                      label: 'Xe máy',
                                      value: ValueItem(
                                          label: 'Xe máy',
                                          value: "motorcycle")),
                                  ValueItem(
                                      label: 'Xe buýt',
                                      value: ValueItem(
                                          label: 'Xe buýt', value: "bus")),
                                  ValueItem(
                                      label: 'Xe tải',
                                      value: ValueItem(
                                          label: 'Xe tải', value: "truck")),
                                ],
                                controller: typeTrafficController,
                                hint:
                                    "Lựa chọn các loại phương tiện được cho phép",
                                selectionType: SelectionType.multi,
                                chipConfig:
                                    const ChipConfig(wrapType: WrapType.wrap),
                                dropdownHeight: 300,
                                optionTextStyle: const TextStyle(fontSize: 16),
                                selectedOptionIcon:
                                    const Icon(Icons.check_circle),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              if (isValidateType)
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      "Phương tiện cho phép không được để trống",
                                      style: TextStyle(
                                          color: Colors.red, fontSize: 12),
                                    )
                                  ],
                                )
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  child: Text('Ok'),
                  onPressed: () {
                    setState(() {
                      isValidateName = nameLineController.text.isEmpty;
                      if (_controller.mode == PaintMode.line) {
                        isValidateDirect =
                            directController.selectedOptions.isEmpty;
                        isValidateType =
                            typeTrafficController.selectedOptions.isEmpty;
                        info.isLine = true;
                        isValidated = !isValidateName &&
                            !isValidateDirect &&
                            !isValidateType;
                      }else{
                        info.isLine = false;
                        isValidated = !isValidateName;
                      }
                    });
                    if (isValidated) {
                      Navigator.of(context).pop();
                      _controller.addPaintInfo(info);
                    }
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _openTextDialog() {
    _controller.setMode(PaintMode.text);
    final fontSize = 6 * _controller.strokeWidth;
    TextDialog.show(
      context,
      _textController,
      fontSize,
      _controller.color,
      textDelegate,
      onFinished: (context) {
        if (_textController.text.isNotEmpty) {
          _addPaintHistory(
            PaintInfo(
              mode: PaintMode.text,
              text: _textController.text,
              offsets: [],
              color: _controller.color,
              strokeWidth: _controller.scaledStrokeWidth,
            ),
          );
          _textController.clear();
        }
        Navigator.of(context).pop();
      },
    );
  }

  Widget _buildControls() {
    return Container(
      padding: const EdgeInsets.all(4),
      color: Colors.grey[200],
      child: Row(
        children: [
          AnimatedBuilder(
            animation: _controller,
            builder: (_, __) {
              final icon = Icons.edit;
              return PopupMenuButton(
                tooltip: textDelegate.changeMode,
                shape: ContinuousRectangleBorder(
                  borderRadius: BorderRadius.circular(40),
                ),
                icon: Icon(icon, color: Colors.grey[700]),
                itemBuilder: (_) => [_showOptionsRow()],
              );
            },
          ),
          const Spacer(),
          // IconButton(
          //   tooltip: textDelegate.undo,
          //   icon: widget.undoIcon ?? Icon(Icons.reply, color: Colors.grey[700]),
          //   onPressed: () => _controller.undo(),
          // ),
          IconButton(
            tooltip: textDelegate.saveLineEdit,
            icon: Icon(Icons.save),
            onPressed: () async {
              Map<String, dynamic> result = await request.createRule(
                  list.toSet().toList(), widget.cameraInforEntity.id);
              if (result['isSuccess']) {
                PanaraInfoDialog.show(
                  context,
                  title: "Thông báo",
                  message: "Thêm mới kẽ vẽ thành công",
                  buttonText: "Ok",
                  onTapDismiss: () {
                    Navigator.pop(context);
                  },
                  panaraDialogType: PanaraDialogType.success,
                  barrierDismissible:
                      false, // optional parameter (default is true)
                );
              } else {
                PanaraInfoDialog.show(
                  context,
                  title: "Lỗi",
                  message: result['message'],
                  buttonText: "Okay",
                  onTapDismiss: () {
                    Navigator.pop(context);
                  },
                  panaraDialogType: PanaraDialogType.error,
                  barrierDismissible:
                      false, // optional parameter (default is true)
                );
              }
            },
          ),
          IconButton(
            tooltip: textDelegate.clearAllProgress,
            icon: widget.clearAllIcon ??
                Icon(Icons.delete, color: Colors.grey[700]),
            onPressed: () {
              _controller.clear();
              setState(() {
                list.clear();
              });
            },
          ),
        ],
      ),
    );
  }

  void showSuccessDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Thông báo'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
