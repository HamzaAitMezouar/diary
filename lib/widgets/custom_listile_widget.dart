import 'package:flutter/material.dart';

class CustomListileWidget extends StatelessWidget {
  final BorderRadiusGeometry? radius;
  final String label;
  final Widget icon;
  final Color? color;
  final Color? backgroundColor;
  final bool? hasUnderline;
  final bool? hasTrailing;
  final Function() onTap;
  const CustomListileWidget({
    required this.label,
    required this.icon,
    this.color,
    this.backgroundColor,
    required this.onTap,
    this.hasUnderline,
    this.hasTrailing,
    this.radius,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
      ),
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: Durations.long1,
          height: 55,
          decoration: BoxDecoration(
            borderRadius: radius,
            color: backgroundColor ?? const Color.fromARGB(255, 165, 165, 165).withOpacity(0.4),
            border: hasUnderline == false
                ? null
                : const Border(
                    bottom: BorderSide(width: 1.0, color: Colors.grey),
                  ),
          ),
          child: Row(
            children: [
              Container(
                height: 35,
                width: 35,
                decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(10)),
                margin: const EdgeInsets.symmetric(horizontal: 15),
                child: Center(child: icon),
              ),
              Expanded(
                child: Text(
                  label,
                  style: const TextStyle(fontSize: 13, fontFamily: "Roboto", fontWeight: FontWeight.w500),
                ),
              ),
              hasTrailing == false
                  ? const SizedBox.shrink()
                  : const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Icon(
                        Icons.keyboard_arrow_right_outlined,
                        color: Colors.green,
                      ),
                    )
            ],
          ),
        ),
      ),
    );
  }
}
