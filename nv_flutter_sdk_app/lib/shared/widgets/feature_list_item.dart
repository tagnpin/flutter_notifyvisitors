import 'package:flutter/material.dart';

enum FeatureListItemType { accordion, simple }

class FeatureListItem extends StatefulWidget {
  final FeatureListItemType type;
  final String title;
  final String description;
  final IconData? icon;
  final List<FeatureChildItem>? children;
  final VoidCallback? onTap;

  const FeatureListItem.accordion({
    super.key,
    required this.title,
    required this.description,
    this.icon,
    required this.children,
  })  : type = FeatureListItemType.accordion,
        onTap = null;

  const FeatureListItem.simple({
    super.key,
    required this.title,
    required this.description,
    this.icon,
    required this.onTap,
  })  : type = FeatureListItemType.simple,
        children = null;

  @override
  State<FeatureListItem> createState() => _FeatureListItemState();
}

class _FeatureListItemState extends State<FeatureListItem>
    with SingleTickerProviderStateMixin {
  bool _expanded = false;

  void _toggle() {
    if (widget.type == FeatureListItemType.accordion) {
      setState(() => _expanded = !_expanded);
    } else {
      widget.onTap?.call();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: theme.colorScheme.primary,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: _toggle,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (widget.icon != null) ...[
                    Icon(widget.icon, color: theme.colorScheme.primary),
                    const SizedBox(width: 12),
                  ],
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.title,
                          style: theme.textTheme.titleMedium
                              ?.copyWith(fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          widget.description,
                          style: theme.textTheme.bodySmall
                              ?.copyWith(color: theme.hintColor),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  _buildTrailingIcon(theme),
                ],
              ),
            ),
          ),
          if (widget.type == FeatureListItemType.accordion && _expanded)
            const Divider(height: 1),
          if (widget.type == FeatureListItemType.accordion)
            AnimatedSize(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeInOut,
              child: _expanded ? _buildChildren(theme) : const SizedBox(),
            ),
        ],
      ),
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   final theme = Theme.of(context);

  //   return Column(
  //     children: [
  //       InkWell(
  //         borderRadius: BorderRadius.circular(12),
  //         onTap: _toggle,
  //         child: Container(
  //           decoration: BoxDecoration(
  //             borderRadius: BorderRadius.circular(12),
  //             border: Border.all(
  //               color: theme.colorScheme.primary,
  //               width: 1,
  //             ),
  //           ),
  //           padding: const EdgeInsets.all(16),
  //           child: Row(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               if (widget.icon != null) ...[
  //                 Icon(widget.icon, color: theme.colorScheme.primary),
  //                 const SizedBox(width: 12),
  //               ],
  //               Expanded(
  //                 child: Column(
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   children: [
  //                     Text(
  //                       widget.title,
  //                       style: theme.textTheme.titleMedium
  //                           ?.copyWith(fontWeight: FontWeight.w600),
  //                     ),
  //                     const SizedBox(height: 4),
  //                     Text(
  //                       widget.description,
  //                       style: theme.textTheme.bodySmall
  //                           ?.copyWith(color: theme.hintColor),
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //               const SizedBox(width: 8),
  //               _buildTrailingIcon(theme),
  //             ],
  //           ),
  //         ),
  //       ),
  //       if (widget.type == FeatureListItemType.accordion)
  //         AnimatedSize(
  //           duration: const Duration(milliseconds: 200),
  //           curve: Curves.easeInOut,
  //           child: _expanded ? _buildChildren(theme) : const SizedBox(),
  //         ),
  //     ],
  //   );
  // }

  Widget _buildTrailingIcon(ThemeData theme) {
    if (widget.type == FeatureListItemType.simple) {
      return Icon(
        Icons.chevron_right,
        color: theme.colorScheme.primary,
      );
    }

    return AnimatedRotation(
      turns: _expanded ? 0.5 : 0.0,
      duration: const Duration(milliseconds: 200),
      child: Icon(
        Icons.expand_more,
        color: theme.colorScheme.primary,
      ),
    );
  }

  Widget _buildChildren(ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
      child: Column(
        children: widget.children!
            .map(
              (child) => InkWell(
                onTap: child.onTap,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          child.title,
                          style: theme.textTheme.bodyMedium,
                        ),
                      ),
                      Icon(
                        Icons.chevron_right,
                        size: 18,
                        color: theme.colorScheme.primary,
                      ),
                    ],
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }

  // Widget _buildChildren(ThemeData theme) {
  //   return Padding(
  //     padding: const EdgeInsets.only(left: 48, top: 8, bottom: 8),
  //     child: Column(
  //       children: widget.children!
  //           .map(
  //             (child) => InkWell(
  //               onTap: child.onTap,
  //               child: Padding(
  //                 padding: const EdgeInsets.symmetric(vertical: 12),
  //                 child: Row(
  //                   children: [
  //                     Expanded(
  //                       child: Text(
  //                         child.title,
  //                         style: theme.textTheme.bodyMedium,
  //                       ),
  //                     ),
  //                     const Icon(Icons.chevron_right, size: 18),
  //                   ],
  //                 ),
  //               ),
  //             ),
  //           )
  //           .toList(),
  //     ),
  //   );
  // }
}

class FeatureChildItem {
  final String title;
  final VoidCallback? onTap;

  FeatureChildItem({
    required this.title,
    this.onTap,
  });
}
