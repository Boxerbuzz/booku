import 'package:booku/exports.dart';
import 'package:flutter/material.dart';

enum EvPopSelectMode { field, container }

/*================== Main Selector ============================*/

class EvPopSelect extends StatefulWidget {
  const EvPopSelect({
    required this.options,
    required this.label,
    this.selected,
    this.onChanged,
    this.prefix,
    this.hint,
    this.mode = EvPopSelectMode.field,
    Key? key,
  }) : super(key: key);
  final List<String> options;
  final List<String>? selected;
  final String label;
  final ValueChanged<List<String>>? onChanged;
  final Widget? prefix;
  final String? hint;
  final EvPopSelectMode mode;

  @override
  _EvPopSelectState createState() => _EvPopSelectState();
}

class _EvPopSelectState extends State<EvPopSelect> {
  late List<String>? _selected;
  late List<String> _options;

  @override
  void initState() {
    super.initState();
    _options = widget.options;
    _selected = widget.selected ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => _PopSelectorProvider(),
      builder: (context, child) {
        List<String> selected = context
            .select<_PopSelectorProvider, List<String>>((val) => val.selected);

        return Provider.value(
          value: selected,
          builder: (context, child) {
            return FocusableActionDetector(
              autofocus: false,
              enabled: true,
              mouseCursor: MouseCursor.uncontrolled,
              focusNode: FocusNode(),
              child: GestureDetector(
                child: widget.mode == EvPopSelectMode.field
                    ? _InputMode(widget.label,
                        hint: widget.hint,
                        prefix: widget.prefix,
                        selected: _selected)
                    : _ContainerMode(widget.label,
                        hint: widget.hint,
                        prefix: widget.prefix,
                        selected: _selected),
                onTap: () => onInteract(context),
              ),
            ).padding(bottom: Insets.l);
          },
        );
      },
    );
  }

  onInteract(BuildContext context) {
    AppHelper.unFocus();
    _PopSelectorProvider store =
        Provider.of<_PopSelectorProvider>(context, listen: false);
    showMaterialModalBottomSheet(
      context: context,
      animationCurve: Curves.fastLinearToSlowEaseIn,
      builder: (_) => _EvSelector(
        _options,
        title: widget.label,
        selected: _selected ?? [],
        onChanged: (List<String> value) {
          widget.onChanged!(value);
          _selected = value.map((e) => e).toList();
          store.selected = value;
        },
      ),
    );
  }
}

/*====================== Private items =========================*/

class _ContainerMode extends StatelessWidget {
  const _ContainerMode(this.label,
      {Key? key, this.selected, this.prefix, this.hint})
      : super(key: key);
  final List<String>? selected;
  final String label;
  final Widget? prefix;
  final String? hint;
  @override
  Widget build(BuildContext context) {
    AppTheme theme = context.watch();
    return EvContainer(
      width: double.infinity,
      border: Border.all(color: theme.txt),
      borderRadius: Corners.s10Border,
      color: theme.background,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: Insets.m, vertical: Insets.m),
        child: selected!.isNotEmpty
            ? Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  Row(
                    children: [
                      (prefix ?? Container()).padding(right: Insets.m),
                      Text(
                        label,
                        style: TextStyles.body1.textColor(theme.greyStrong),
                      ),
                    ],
                  ).padding(bottom: 5),
                  ...selected!
                      .map((e) => _Item(e, selected: true, onClose: () {})),
                ],
              )
            : Column(
                children: [
                  VSpace.lg,
                  EvSvgIc(R.I.clipboard.svgB, size: 80, color: theme.primary),
                  VSpace.md,
                  Text(label, style: TextStyles.body1),
                  VSpace.md,
                  EvSvgIc(R.I.chevronDown.svgB)
                ],
              ),
      ),
    );
  }
}

class _InputMode extends StatelessWidget {
  const _InputMode(this.label,
      {Key? key, this.selected, this.prefix, this.hint})
      : super(key: key);
  final List<String>? selected;
  final String label;
  final Widget? prefix;
  final String? hint;

  @override
  Widget build(BuildContext context) {
    AppTheme theme = context.watch();
    return Container(
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
          prefix ?? Container(),
          Expanded(
            child: selected!.isEmpty
                ? Text(hint ?? label, style: TextStyles.body1).padding(left: 10)
                : EvHScroll(
                    child: Row(
                      children: [
                        HSpace.md,
                        ...selected!.map((item) =>
                            _Item(item, selected: true).padding(right: 5)),
                      ],
                    ),
                  ),
          ),
          EvSvgIc(R.I.chevronDown.svgT),
        ],
      ),
    );
  }
}

class _Item extends StatelessWidget {
  const _Item(
    this.item, {
    this.onClose,
    this.onPressed,
    this.icon,
    this.selected = false,
    Key? key,
  }) : super(key: key);
  final String item;
  final VoidCallback? onClose;
  final VoidCallback? onPressed;
  final Widget? icon;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    AppTheme theme = context.watch();
    final content = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (icon != null) ...{
          Container(),
        },
        Text(
          item.toUpperCase(),
          style: TextStyles.footnote
              .letterSpace(1)
              .textColor(selected ? Colors.white : theme.primary),
        ).center().padding(all: 5),
        if (onClose != null) ...{
          EvIcBtn(
            const Icon(
              Icons.close,
              color: Colors.white,
              size: 15,
            ),
            padding: const EdgeInsets.all(0),
            color: Colors.grey[300],
            onPressed: onClose,
            shrinkWrap: true,
          ),
        },
      ],
    );
    return IgnorePointer(
      ignoring: false,
      child: Container(
        child: content,
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          borderRadius: Corners.s5Border,
          color: selected ? theme.primary : null,
          border: Border.all(color: theme.primary),
        ),
      ).clickable(onPressed).animate(600.milliseconds, Curves.easeOutExpo),
    );
  }
}

/*====================== Popup Selector ============================*/

class _EvSelector extends StatefulWidget {
  const _EvSelector(
    this.options, {
    required this.title,
    this.subTitle,
    this.onChanged,
    this.selected = const [],
    Key? key,
  }) : super(key: key);
  final List<String> options;
  final String title;
  final String? subTitle;
  final ValueChanged<List<String>>? onChanged;
  final List<String> selected;

  @override
  State<_EvSelector> createState() => _EvSelectorState();
}

class _EvSelectorState extends State<_EvSelector> {
  late List<String> _selected = [];

  @override
  void initState() {
    super.initState();
    _selected = widget.selected;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: Corners.s8Border,
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: Insets.l),
        controller: ModalScrollController.of(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            VSpace.md,
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.title, style: TextStyles.h6),
                      widget.subTitle != null
                          ? Text(widget.subTitle ?? '', style: TextStyles.h6)
                          : const SizedBox.shrink(),
                    ],
                  ),
                ),
                EvIcBtn(
                  EvSvgIc(R.I.chevronDown.svgT),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            VSpace.md,
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                ...widget.options.map(
                  (e) => _Item(
                    e,
                    onPressed: () => onSelected(e),
                    selected: _selected.any((element) => element == e),
                  ),
                ),
              ],
            ),
            VSpace.lg,
          ],
        ),
      ),
    );
  }

  onSelected(String value) {
    if (!_selected.contains(value)) {
      setState(() => _selected.add(value));
    } else if (_selected.contains(value)) {
      setState(() => _selected.remove(value));
    }
    widget.onChanged!(_selected);
  }
}

/*======================= Selector Provider =========================*/

class _PopSelectorProvider extends ChangeNotifier {
  List<String> _selected = [];
  List<String> get selected => _selected;
  set selected(List<String> value) {
    _selected = value.map((e) => e).toList();
    notifyListeners();
  }
}
