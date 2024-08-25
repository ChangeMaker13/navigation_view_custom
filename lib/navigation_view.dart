library navigation_view;

import 'package:flutter/material.dart';
import 'package:navigation_view/item_navigation_view.dart';

class NavigationView extends StatefulWidget {
  final Function(int) onChangePage;
  final Color? backgroundColor;
  final Color? borderTopColor;
  final Curve? curve;
  final Color? color;
  final BorderRadiusGeometry? borderRadius;
  final Gradient? gradient;
  final Duration? durationAnimation;
  final List<ItemNavigationView> items;
  final int selectedFlex;
  final int unselectedFlex;
  const NavigationView({
    Key? key,
    required this.onChangePage,
    required this.items,
    this.durationAnimation,
    this.backgroundColor,
    this.borderRadius,
    this.gradient,
    this.color,
    this.curve,
    this.borderTopColor,
    int? selectedFlex,
    int? unselectedFlex,
  })  : this.selectedFlex = selectedFlex ?? 4,
        this.unselectedFlex = unselectedFlex ?? 3,
        super(key: key);

  @override
  State<StatefulWidget> createState() => _NavigationView();
}

class _NavigationView extends State<NavigationView> {
  final double borderRadius = 11.1;
  late int _currentPage = 0;

  final Color color = Colors.blue;
  Duration durationAnimation = const Duration(milliseconds: 250);
  @override
  void initState() {
    if (widget.durationAnimation != null)
      durationAnimation = widget.durationAnimation!;
    _currentPage = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.maxFinite,
        color: (widget.backgroundColor != null)
            ? widget.backgroundColor
            : Colors.white,
        height: 55,
        child: Column(
          children: [
            Container(
              width: double.maxFinite,
              height: 1,
              color: (widget.borderTopColor != null)
                  ? widget.borderTopColor!
                  : Colors.grey.withAlpha(20),
            ),
            Expanded(
              child: LayoutBuilder(
                builder: (p0, constraints) {
                  double totalWidth = constraints.maxWidth;
                  int totalFlex = widget.items.length * widget.unselectedFlex +
                      (widget.selectedFlex -
                          widget
                              .unselectedFlex); // 모든 항목이 3 flex를 가짐. 선택된 항목은 4 flex로 할당됨.
                  double unitWidth = totalWidth / totalFlex;

                  return Stack(
                    children: [
                      AnimatedPositioned(
                        curve: (widget.curve != null)
                            ? widget.curve!
                            : Curves.easeInOutQuint,
                        left: unitWidth *
                            ((widget.items.length - 1) - _currentPage) *
                            widget.unselectedFlex,
                        width: unitWidth *
                            widget.selectedFlex, // 선택된 항목의 크기를 4 flex 만큼 할당
                        height: constraints.maxHeight,
                        duration: Duration(
                            milliseconds: durationAnimation.inMilliseconds),
                        child: Padding(
                          padding: EdgeInsets.only(
                              top: 5,
                              bottom: 0,
                              left: (45 / widget.items.length),
                              right: (45 / widget.items.length)),
                          child: InkWell(
                            onTap: () {},
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  borderRadius: (widget.borderRadius != null)
                                      ? widget.borderRadius
                                      : BorderRadius.circular(borderRadius)),
                              child: Column(
                                children: [
                                  Padding(
                                      padding: const EdgeInsets.only(
                                          left: 4, right: 4),
                                      child: AnimatedContainer(
                                        duration: Duration(
                                            milliseconds: durationAnimation
                                                    .inMilliseconds ~/
                                                2),
                                        width: double.maxFinite,
                                        height: 2,
                                        decoration: BoxDecoration(
                                            color: (widget.color != null)
                                                ? widget.color!
                                                : color,
                                            borderRadius:
                                                (widget.borderRadius != null)
                                                    ? widget.borderRadius!
                                                    : const BorderRadius.only(
                                                        topLeft:
                                                            Radius.circular(0),
                                                        topRight:
                                                            Radius.circular(0),
                                                        bottomLeft:
                                                            Radius.circular(0),
                                                        bottomRight:
                                                            Radius.circular(0),
                                                      )),
                                      )),
                                  Expanded(
                                      child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 5, right: 5),
                                    child: AnimatedContainer(
                                      duration: Duration(
                                          microseconds: durationAnimation
                                                  .inMilliseconds ~/
                                              2.1),
                                    ),
                                  )),
                                  Padding(
                                      padding: const EdgeInsets.only(
                                          left: 4, right: 4, bottom: 4),
                                      child: AnimatedContainer(
                                        duration: Duration(
                                            milliseconds: durationAnimation
                                                    .inMilliseconds ~/
                                                2),
                                        width: double.maxFinite,
                                        height: 2,
                                        decoration: BoxDecoration(
                                            color: (widget.color != null)
                                                ? widget.color!
                                                : color,
                                            borderRadius:
                                                (widget.borderRadius != null)
                                                    ? widget.borderRadius!
                                                    : const BorderRadius.only(
                                                        topLeft:
                                                            Radius.circular(0),
                                                        topRight:
                                                            Radius.circular(0),
                                                        bottomLeft:
                                                            Radius.circular(0),
                                                        bottomRight:
                                                            Radius.circular(0),
                                                      )),
                                      ))
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: double.maxFinite,
                        height: double.maxFinite,
                        child: Row(
                          textDirection: TextDirection.rtl,
                          children: widget.items
                              .map((e) => Flexible(
                                    flex: (_currentPage ==
                                            widget.items.indexOf(e))
                                        ? widget.selectedFlex
                                        : widget.unselectedFlex,
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          _currentPage =
                                              widget.items.indexOf(e);
                                          widget.onChangePage
                                              .call(widget.items.indexOf(e));
                                        });
                                      },
                                      child: LayoutBuilder(builder:
                                          (BuildContext context,
                                              BoxConstraints constraints) {
                                        return Center(
                                            child: (_currentPage ==
                                                    widget.items.indexOf(e))
                                                ? e.childAfter
                                                : e.childBefore);
                                      }),
                                    ),
                                  ))
                              .toList(),
                        ),
                      ),
                    ],
                  );
                },
              ),
            )
          ],
        ));
  }
}
