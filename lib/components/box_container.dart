import 'package:flutter/material.dart';

class BoxContainer extends StatelessWidget {
  const BoxContainer({super.key, required this.child, this.padding});
  final EdgeInsetsGeometry? padding;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    // print(size.width);
    return Container(
      padding: padding ?? const EdgeInsets.all(10),
      width: size.width,
      constraints: const BoxConstraints(maxHeight: 80),
      decoration: BoxDecoration(
        // border: Border.fromBorderSide(side),
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
      ),
      child: child,
    );
  }
}
