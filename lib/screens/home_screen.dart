import 'package:flutter/material.dart';
import '../models/unit.dart';
import '../utils/converters.dart';
import '../widgets/conversion_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  MeasureType _selectedMeasure = MeasureType.length;

  // controllers & selected units per measure
  final Map<MeasureType, TextEditingController> _controllers = {
    MeasureType.length: TextEditingController(text: '1'),
    MeasureType.weight: TextEditingController(text: '1'),
    MeasureType.volume: TextEditingController(text: '1'),
    MeasureType.temperature: TextEditingController(text: '25'),
    MeasureType.area: TextEditingController(text: '1'),
  };

  late Map<MeasureType, Unit> _fromUnits;
  late Map<MeasureType, Unit> _toUnits;
  late Map<MeasureType, String> _results;

  @override
  void initState() {
    super.initState();
    _fromUnits = {
      for (var m in MeasureType.values) m: Converters.units[m]!.first
    };
    _toUnits = {
      for (var m in MeasureType.values) m: Converters.units[m]!.elementAt(1)
    };
    _results = {for (var m in MeasureType.values) m: ''};
  }

  void _doConvert(MeasureType measure) {
    final controller = _controllers[measure]!;
    final text = controller.text.trim();
    if (text.isEmpty) {
      setState(() {
        _results[measure] = 'Please enter a value';
      });
      return;
    }
    double? value = double.tryParse(text);
    if (value == null) {
      setState(() {
        _results[measure] = 'Invalid number';
      });
      return;
    }

    try {
      final res = Converters.convert(
        measure: measure,
        fromUnit: _fromUnits[measure]!.id,
        toUnit: _toUnits[measure]!.id,
        value: value,
      );
      setState(() {
        _results[measure] = '${res.toStringAsPrecision(8)} ${_toUnits[measure]!.name}';
      });
    } catch (e) {
      setState(() {
        _results[measure] = 'Error: ${e.toString()}';
      });
    }
  }

  Widget _buildMeasureCard(MeasureType measure) {
    final unitOptions = Converters.units[measure]!;
    return ConversionCard(
      measure: measure,
      unitOptions: unitOptions,
      fromUnit: _fromUnits[measure]!,
      toUnit: _toUnits[measure]!,
      controller: _controllers[measure]!,
      onFromChanged: (u) {
        if (u == null) return;
        setState(() => _fromUnits[measure] = u);
      },
      onToChanged: (u) {
        if (u == null) return;
        setState(() => _toUnits[measure] = u);
      },
      onConvert: () => _doConvert(measure),
      resultText: _results[measure] == '' ? 'Result will appear here' : _results[measure]!,
    );
  }

  @override
  void dispose() {
    for (var c in _controllers.values) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Top tabs to switch between measures
    return Scaffold(
      appBar: AppBar(
        title: const Text('Measures Converter'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // horizontal selector
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: SizedBox(
                height: 48,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  children: MeasureType.values.map((m) {
                    final name = m.name[0].toUpperCase() + m.name.substring(1);
                    final selected = m == _selectedMeasure;
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      child: ChoiceChip(
                        label: Text(name),
                        selected: selected,
                        onSelected: (_) => setState(() => _selectedMeasure = m),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
            // show the selected measure card
            _buildMeasureCard(_selectedMeasure),

            // also show quick shortcuts to convert other measures below
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Quick converters', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 6),
                  // show small versions for all measures
                  for (var m in MeasureType.values)
                    if (m != _selectedMeasure)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: ListTile(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          tileColor: Colors.grey[100],
                          leading: const Icon(Icons.swap_calls),
                          title: Text(m.name[0].toUpperCase() + m.name.substring(1)),
                          subtitle: Text(_results[m] == '' ? 'No result yet' : _results[m]!),
                          trailing: ElevatedButton(
                            onPressed: () {
                              // switch to this measure
                              setState(() => _selectedMeasure = m);
                            },
                            child: const Text('Open'),
                          ),
                        ),
                      ),
                ],
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}