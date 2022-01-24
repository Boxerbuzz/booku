import 'package:booku/exports.dart';
import 'package:flutter/material.dart';

class EvLocationPicker extends StatefulWidget {
  const EvLocationPicker({
    required this.label,
    this.onChanged,
    this.prefix,
    this.hint,
    this.value,
    Key? key,
  }) : super(key: key);
  final String label;
  final ValueChanged<List<String>>? onChanged;
  final Widget? prefix;
  final String? hint;
  final String? value;

  @override
  _EvLocationPickerState createState() => _EvLocationPickerState();
}

class _EvLocationPickerState extends State<EvLocationPicker> {
  @override
  Widget build(BuildContext context) {
    AppTheme theme = context.watch();
    return FocusableActionDetector(
      autofocus: false,
      enabled: true,
      mouseCursor: MouseCursor.uncontrolled,
      focusNode: FocusNode(),
      child: GestureDetector(
        child: Container(
          width: double.infinity,
          height: 50,
          decoration: BoxDecoration(
            borderRadius: Corners.s10Border,
            border: Border.all(color: theme.primary),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: Insets.m,
            vertical: 8,
          ),
          child: Row(
            children: [
              widget.prefix ?? Container(),
              Expanded(
                child: widget.value == null
                    ? Text(widget.hint ?? widget.label, style: TextStyles.body1)
                        .padding(left: 10)
                    : Text(widget.value!, style: TextStyles.body1)
                        .padding(left: 10),
              ),
              EvSvgIc(R.I.chevronDown.svgB),
            ],
          ),
        ),
        onTap: () => onInteract(context),
      ),
    ).padding(bottom: Insets.l);
  }

  onInteract(BuildContext context) {
    AppHelper.unFocus();
    showMaterialModalBottomSheet(
      context: context,
      animationCurve: Curves.fastLinearToSlowEaseIn,
      builder: (_) => Container(),
    );
  }
}
