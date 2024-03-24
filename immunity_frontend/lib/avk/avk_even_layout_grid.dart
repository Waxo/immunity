import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';

class AvkEvenLayoutGrid extends StatelessWidget {
  final int columnCount;
  final List<Widget> children;
  final double? rowGap;
  final double? columnGap;

  const AvkEvenLayoutGrid({
    required this.columnCount,
    required this.children,
    this.rowGap,
    this.columnGap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    List<FlexibleTrackSize> columnSizes = List.filled(columnCount, 1.fr);
    int length = (children.length / columnCount).ceil();
    List<IntrinsicContentTrackSize> rowSizes =
        List.filled(length == 0 ? 1 : length, auto);

    return LayoutGrid(
      columnSizes: columnSizes,
      rowSizes: rowSizes,
      columnGap: columnGap ?? 8,
      rowGap: rowGap ?? 8,
      gridFit: GridFit.loose,
      children: children.isNotEmpty
          ? children
          : [
              const SizedBox.shrink(),
            ],
    );
  }
}
