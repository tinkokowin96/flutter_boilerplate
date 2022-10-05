import 'dart:async';
import 'package:exceed_resources_frontend/app/modules/core/theme/index.dart';
import 'package:exceed_resources_frontend/app/modules/core/theme/miscs.dart';
import 'package:exceed_resources_frontend/app/modules/core/theme/size.dart';
import 'package:exceed_resources_frontend/app/modules/core/theme/sizebox.dart';
import 'package:exceed_resources_frontend/app/modules/core/utils/enum.dart';
import 'package:exceed_resources_frontend/app/modules/core/widgets/container/hoverable_container.dart';
import 'package:exceed_resources_frontend/app/modules/core/widgets/form_field_input.dart';
import 'package:exceed_resources_frontend/app/modules/core/widgets/text_button.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class AppDropdown extends StatefulWidget {
  final double width;
  final String hint;
  final bool loading;
  final List<Map> items;
  final TextEditingController dropdownController;
  final Function({Map? value, bool? checked}) onChanged;
  final bool isMulti;
  final bool searchable;
  final bool noPadding;
  final Function(String value)? onSearched;
  final List<Map>? initialItems;
  final List<String>? selected;
  final Map? addNew;
  final Function(String? value)? validator;
  final String? title;
  const AppDropdown({
    Key? key,
    required this.width,
    required this.hint,
    required this.loading,
    required this.items,
    required this.onChanged,
    required this.dropdownController,
    this.searchable = false,
    this.noPadding = false,
    this.isMulti = false,
    this.onSearched,
    this.selected,
    this.initialItems,
    this.validator,
    this.addNew,
    this.title,
  }) : super(key: key);

  @override
  State<AppDropdown> createState() => _AppDropdownState();
}

class _AppDropdownState extends State<AppDropdown> {
  final _layerLink = LayerLink();
  late final FocusNode _focusNode;
  late final OverlayState? _overlay;
  late final OverlayEntry? _entry;
  String searchedText = '';
  Map? _selectedDropdown;
  Timer? _timer;
  late final List<String> _selected = widget.selected ?? [];

  void debounceSearch(String search) {
    searchedText = search;
    if (_timer != null) {
      _timer!.cancel();
    }
    _timer = Timer(
      const Duration(milliseconds: 400),
      (() => widget.onSearched != null ? widget.onSearched!(search) : () => null),
    );
  }

  void selectDropdownHandler({required Map value, bool? checked}) {
    setState(() {
      if (checked == null) {
        widget.dropdownController.text = value['text'];
        _selectedDropdown = value;
        _focusNode.unfocus();
      } else {
        if (checked) {
          final isAlreadySelected = _selected.contains(value['text']);
          if (!isAlreadySelected) {
            _selected.add(value['text']);
          }
        } else {
          _selected.removeWhere((item) => item == value['text']);
        }

        widget.dropdownController.text = '';
        for (final item in _selected) {
          if (widget.dropdownController.text.isEmpty) {
            widget.dropdownController.text += item;
          } else {
            widget.dropdownController.text += ', $item';
          }
        }
        _entry!.markNeedsBuild();
      }
      widget.onChanged(value: value, checked: checked);
    });
  }

  void executeAfterBuild(bool build) {
    if (build) {
      _entry!.markNeedsBuild();
    } else {
      final renderBox = context.findRenderObject() as RenderBox;
      final position = renderBox.localToGlobal(Offset.zero);
      final screenHeight = MediaQuery.of(context).size.height;
      _overlay = Overlay.of(context)!;
      _entry = OverlayEntry(
        builder: (context) => Positioned(
          width: renderBox.size.width,
          child: CompositedTransformFollower(
            link: _layerLink,
            showWhenUnlinked: false,
            offset: Offset(
              0,
              position.dy / screenHeight < 0.7 ? renderBox.size.height : -(AppSize.dH + AppSize.lg),
            ),
            child: DopdownItems(
              items: !widget.loading && widget.initialItems != null && searchedText.isEmpty
                  ? widget.initialItems!
                  : widget.items,
              loading: widget.loading,
              noPadding: widget.noPadding,
              width: widget.width,
              focus: _focusNode,
              addNew: widget.addNew,
              selectDropdownHandler: selectDropdownHandler,
              isMulti: widget.isMulti,
              selected: _selected,
            ),
          ),
        ),
      );
    }
  }

  void showDropdown(bool show) {
    if (show) {
      _overlay!.insert(_entry!);
      setState(() {
        _selectedDropdown = null;
      });
    } else {
      if (widget.searchable) {
        widget.dropdownController.text = '';
      }
      _entry!.remove();
      if (_selectedDropdown == null) {
        widget.onChanged();
      }
    }
  }

  @override
  void initState() {
    _focusNode = FocusNode();
    WidgetsBinding.instance.addPostFrameCallback((_) => executeAfterBuild(false));
    super.initState();
  }

  @override
  void didUpdateWidget(AppDropdown oldWidget) {
    // WidgetsBinding.instance.addPersistentFrameCallback((timeStamp) {
    //   //   if (_entry != null) {
    //   //     _entry!.markNeedsBuild();
    //   //   }
    // }); NOTE: directly manipulating like this will tirgger Concurrent modification during iteration: error
    WidgetsBinding.instance.addPostFrameCallback((_) => executeAfterBuild(true));
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    if (_overlay != null) {
      //   _overlay!.dispose(); NOTE: this triggering error may be bug in flutter
    }
    if (_entry != null) {
      _entry!.dispose();
    }
    if (_timer != null) {
      _timer!.cancel();
    }
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: FormFieldInput(
        title: widget.title,
        controller: widget.dropdownController,
        width: widget.width,
        hintText: widget.hint,
        focusNode: _focusNode,
        readOnly: !widget.searchable,
        onChanged: (value) => {debounceSearch(value)},
        onFocusChange: (hasFocus) => showDropdown(hasFocus),
        validator: (String? value) => widget.validator != null ? widget.validator!(value) : null,
      ),
    );
  }
}

class DopdownItems extends StatelessWidget {
  final bool loading;
  final double width;
  final List<Map> items;
  final FocusNode focus;
  final Function({required Map value, bool? checked}) selectDropdownHandler;
  final bool noPadding;
  final bool isMulti;
  final List<String> selected;
  final Map? addNew;

  const DopdownItems({
    Key? key,
    required this.loading,
    required this.width,
    required this.items,
    required this.selectDropdownHandler,
    required this.focus,
    required this.noPadding,
    required this.isMulti,
    required this.selected,
    this.addNew,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [AppThemeMiscs.shadow2],
        ),
        child: Padding(
          padding: const EdgeInsets.all(AppSize.sm),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                loading
                    ? SizedBox(
                        width: width,
                        height: AppSize.dH,
                        child: Center(
                          child: Lottie.asset(
                            'assets/animation/search_loading.json',
                            width: AppSize.dL,
                          ),
                        ),
                      )
                    : AppSizeBox.zero,
                !loading
                    ? SizedBox(
                        width: width,
                        height: AppSize.dH,
                        child: ListView.builder(
                          itemCount: items.length,
                          itemBuilder: (BuildContext context, int index) => !isMulti
                              ? AppHoverableContainer(
                                  hoverColor: AppTheme.of(context).color.primary.withOpacity(0.2),
                                  idleColor: Colors.white,
                                  onPressed: () => selectDropdownHandler(
                                    value: items[index],
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                            vertical: noPadding ? 0 : AppSize.sm,
                                          ),
                                          alignment:
                                              items[index]['type'] != null ? Alignment.centerLeft : Alignment.center,
                                          child: Text(
                                            items[index]['text'],
                                            style: AppTheme.of(context).text.h3(context: context),
                                          ),
                                        ),
                                      ),
                                      items[index]['type'] != null
                                          ? ColoredBox(
                                              color: AppTheme.of(context).color.primary.withOpacity(0.2),
                                              child: Text(
                                                items[index]['type'],
                                                style:
                                                    AppTheme.of(context).text.h4(context: context, type: EText.primary),
                                              ),
                                            )
                                          : AppSizeBox.zero,
                                    ],
                                  ),
                                )
                              : Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: AppSize.md,
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        items[index]['text'],
                                        style: AppTheme.of(context).text.h3(context: context),
                                      ),
                                      Checkbox(
                                        fillColor: MaterialStateProperty.all<Color>(
                                          AppTheme.of(context).color.primary,
                                        ),
                                        value: selected.contains(items[index]['text']),
                                        onChanged: (value) => selectDropdownHandler(
                                          value: items[index],
                                          checked: value,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                        ),
                      )
                    : AppSizeBox.zero,
                AppSizeBox.sm,
                addNew != null
                    ? Padding(
                        padding: const EdgeInsets.symmetric(vertical: AppSize.sm),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            AppTextButton(
                              text: addNew!['text'],
                              onPressed: () {
                                focus.unfocus();
                                addNew!['onPressed']();
                              },
                            )
                          ],
                        ),
                      )
                    : AppSizeBox.zero,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
