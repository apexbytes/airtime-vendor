import 'package:flutter/material.dart';

class MySelectDropdown<T> extends StatelessWidget {
  final T? value;
  final List<DropdownMenuItem<T>> items;
  final ValueChanged<T?>? onChanged;
  final String? hintText;
  final FocusNode? focusNode;
  final bool isExpanded;
  final double? menuMaxHeight;

  const MySelectDropdown({
    super.key,
    required this.items,
    this.value,
    this.onChanged,
    this.hintText,
    this.focusNode,
    this.isExpanded = true,
    this.menuMaxHeight,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      value: value,
      items: items,
      onChanged: onChanged,
      focusNode: focusNode,
      isExpanded: isExpanded,
      menuMaxHeight: menuMaxHeight,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).colorScheme.tertiary),
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).colorScheme.tertiary),
          borderRadius: BorderRadius.circular(12),
        ),
        hintText: hintText,
        hintStyle: TextStyle(
          color: Theme.of(context).colorScheme.inversePrimary,
        ),
        fillColor: Theme.of(context).colorScheme.secondary,
        filled: true,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      ),
      style: TextStyle(
        color: Theme.of(context).textTheme.titleMedium?.color ?? Theme.of(context).colorScheme.onSurface,
        fontSize: 16,
      ),
      dropdownColor: Theme.of(context).colorScheme.secondary,
      icon: Icon(
        Icons.arrow_drop_down,
        color: Theme.of(context).colorScheme.inversePrimary,
      ),
    );
  }
}
