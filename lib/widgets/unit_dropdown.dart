import 'package:flutter/material.dart';
import '../models/unit.dart';

class UnitDropdown extends StatelessWidget {
  final Unit selected;
  final List<Unit> options;
  final ValueChanged<Unit?> onChanged;

  const UnitDropdown({
    super.key,
    required this.selected,
    required this.options,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<Unit>(
      value: selected,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      ),
      items: options
          .map(
            (u) => DropdownMenuItem<Unit>(
          value: u,
          child: Text(u.name),
        ),
      )
          .toList(),
      onChanged: onChanged,
    );
  }
}