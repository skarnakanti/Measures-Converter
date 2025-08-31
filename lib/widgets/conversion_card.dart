import 'package:flutter/material.dart';
import '../models/unit.dart';
import '../utils/converters.dart';
import 'unit_dropdown.dart';

class ConversionCard extends StatelessWidget {
  final MeasureType measure;
  final List<Unit> unitOptions;
  final Unit fromUnit;
  final Unit toUnit;
  final ValueChanged<Unit?> onFromChanged;
  final ValueChanged<Unit?> onToChanged;
  final TextEditingController controller;
  final VoidCallback onConvert;
  final String resultText;

  const ConversionCard({
    super.key,
    required this.measure,
    required this.unitOptions,
    required this.fromUnit,
    required this.toUnit,
    required this.onFromChanged,
    required this.onToChanged,
    required this.controller,
    required this.onConvert,
    required this.resultText,
  });

  @override
  Widget build(BuildContext context) {
    final title = measure.name[0].toUpperCase() + measure.name.substring(1);
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style:
                const TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: controller,
                    keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                    decoration: const InputDecoration(
                      labelText: 'Value',
                      border: OutlineInputBorder(),
                      contentPadding:
                      EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: UnitDropdown(
                    selected: fromUnit,
                    options: unitOptions,
                    onChanged: onFromChanged,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: UnitDropdown(
                    selected: toUnit,
                    options: unitOptions,
                    onChanged: onToChanged,
                  ),
                ),
                const SizedBox(width: 12),
                ElevatedButton.icon(
                  onPressed: onConvert,
                  icon: const Icon(Icons.swap_horiz),
                  label: const Text('Convert'),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              resultText,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}