import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

abstract class FilterButton extends StatefulWidget {
  IconData get icon;
  String get text;
  double get width;

  const FilterButton({super.key});

  @override
  State<FilterButton> createState() => _FilterButtonState();
}

class _FilterButtonState extends State<FilterButton> {
  bool selected = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => setState(() => selected = !selected),
      child: AnimatedContainer(
        width: widget.width,
        height: 50,
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: selected
              ? const Color.fromRGBO(33, 136, 255, 1)
              : Colors.transparent,
          border: selected
              ? null
              : Border.all(
                  color: Colors.grey[300]!,
                  width: 2,
                ),
          borderRadius: const BorderRadius.all(Radius.circular(8)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            PhosphorIcon(
              widget.icon,
              color: selected ? Colors.white : Colors.grey[500],
            ),
            const SizedBox(width: 3),
            Text(
              widget.text,
              style: TextStyle(
                  color: selected ? Colors.white : Colors.grey[500],
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
