import 'package:flutter/material.dart';

import '../../image_painter.dart';
import '_color_widget.dart';

class SelectionItems extends StatelessWidget {
  final bool isSelected;
  final ModeData data;
  final VoidCallback? onTap;

  const SelectionItems({
    required this.data,
    Key? key,
    this.isSelected = false,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 2.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.0),
          color: isSelected ? Colors.blue : Colors.transparent),
      child: ListTile(
        leading: IconTheme(
          data: const IconThemeData(opacity: 1.0),
          child: Icon(
            data.icon,
            color: isSelected ? Colors.white : Colors.black,
          ),
        ),
        title: Text(
          data.label,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: isSelected
                    ? Colors.white
                    : Theme.of(context).textTheme.bodyLarge?.color,
              ),
        ),
        onTap: onTap,
        contentPadding: const EdgeInsets.symmetric(horizontal: 8.0),
        selected: isSelected,
      ),
    );
  }
}

List<ModeData> paintModes(TextDelegate textDelegate) => [
      ModeData(
          icon: Icons.horizontal_rule,
          mode: PaintMode.line,
          label: textDelegate.line,
          color: Colors.yellow
      ),
      ModeData(
          icon: Icons.crop_free,
          mode: PaintMode.rectRedlight,
          label: textDelegate.recRedlight,
          color: Colors.white
      ),

    ];

@immutable
class ModeData {
  const ModeData({
    required this.icon,
    required this.mode,
    required this.label,
    required this.color,
  });
  final IconData icon;
  final PaintMode mode;
  final String label;
  final Color color;
}
const Map<String,Color?> ColorMode={
  "centerLaneColor":Colors.red,
  "rightLaneColor" : Colors.blue,
  "leftLaneColor" : Colors.yellow,
  "redLightRectColor" : Colors.white,
  "centerDirectColor" : Colors.red,
  "rightDirectColor" : Colors.blue,
  "leftDirectColor" : Colors.yellow
};
