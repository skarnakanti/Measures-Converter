import '../models/unit.dart';
import 'dart:math';

enum MeasureType { length, weight, volume, temperature, area }

class Converters {
  // Units lists per measure
  static Map<MeasureType, List<Unit>> units = {
    MeasureType.length: [
      Unit(id: 'm', name: 'Meters'),
      Unit(id: 'km', name: 'Kilometers'),
      Unit(id: 'mi', name: 'Miles'),
      Unit(id: 'ft', name: 'Feet'),
      Unit(id: 'in', name: 'Inches'),
    ],
    MeasureType.weight: [
      Unit(id: 'kg', name: 'Kilograms'),
      Unit(id: 'g', name: 'Grams'),
      Unit(id: 'lb', name: 'Pounds'),
      Unit(id: 'oz', name: 'Ounces'),
    ],
    MeasureType.volume: [
      Unit(id: 'l', name: 'Liters'),
      Unit(id: 'ml', name: 'Milliliters'),
      Unit(id: 'gal', name: 'Gallons (US)'),
      Unit(id: 'cup', name: 'Cups'),
    ],
    MeasureType.temperature: [
      Unit(id: 'c', name: 'Celsius'),
      Unit(id: 'f', name: 'Fahrenheit'),
      Unit(id: 'k', name: 'Kelvin'),
    ],
    MeasureType.area: [
      Unit(id: 'sqm', name: 'Square meters'),
      Unit(id: 'sqft', name: 'Square feet'),
      Unit(id: 'acre', name: 'Acres'),
      Unit(id: 'sqkm', name: 'Square kilometers'),
    ],
  };

  /// Main conversion dispatcher. Throws FormatException on unknown unit.
  static double convert({
    required MeasureType measure,
    required String fromUnit,
    required String toUnit,
    required double value,
  }) {
    if (measure == MeasureType.length) {
      return _convertLength(fromUnit, toUnit, value);
    } else if (measure == MeasureType.weight) {
      return _convertWeight(fromUnit, toUnit, value);
    } else if (measure == MeasureType.volume) {
      return _convertVolume(fromUnit, toUnit, value);
    } else if (measure == MeasureType.temperature) {
      return _convertTemperature(fromUnit, toUnit, value);
    } else if (measure == MeasureType.area) {
      return _convertArea(fromUnit, toUnit, value);
    } else {
      throw FormatException('Unsupported measure type');
    }
  }

  // ---------------- LENGTH ----------------
  // base unit: meters
  static double _toMeters(String unit, double v) {
    switch (unit) {
      case 'm':
        return v;
      case 'km':
        return v * 1000.0;
      case 'mi':
        return v * 1609.344;
      case 'ft':
        return v * 0.3048;
      case 'in':
        return v * 0.0254;
      default:
        throw FormatException('Unknown length unit: $unit');
    }
  }

  static double _fromMeters(String unit, double meters) {
    switch (unit) {
      case 'm':
        return meters;
      case 'km':
        return meters / 1000.0;
      case 'mi':
        return meters / 1609.344;
      case 'ft':
        return meters / 0.3048;
      case 'in':
        return meters / 0.0254;
      default:
        throw FormatException('Unknown length unit: $unit');
    }
  }

  static double _convertLength(String from, String to, double value) {
    final meters = _toMeters(from, value);
    return _fromMeters(to, meters);
  }

  // ---------------- WEIGHT ----------------
  // base: kilograms
  static double _toKilograms(String unit, double v) {
    switch (unit) {
      case 'kg':
        return v;
      case 'g':
        return v / 1000.0;
      case 'lb':
        return v * 0.45359237;
      case 'oz':
        return v * 0.028349523125;
      default:
        throw FormatException('Unknown weight unit: $unit');
    }
  }

  static double _fromKilograms(String unit, double kg) {
    switch (unit) {
      case 'kg':
        return kg;
      case 'g':
        return kg * 1000.0;
      case 'lb':
        return kg / 0.45359237;
      case 'oz':
        return kg / 0.028349523125;
      default:
        throw FormatException('Unknown weight unit: $unit');
    }
  }

  static double _convertWeight(String from, String to, double value) {
    final kg = _toKilograms(from, value);
    return _fromKilograms(to, kg);
  }

  // ---------------- VOLUME ----------------
  // base: liters
  static double _toLiters(String unit, double v) {
    switch (unit) {
      case 'l':
        return v;
      case 'ml':
        return v / 1000.0;
      case 'gal':
        return v * 3.785411784; // US gallon
      case 'cup':
        return v * 0.24; // approximate metric cup (0.24 L)
      default:
        throw FormatException('Unknown volume unit: $unit');
    }
  }

  static double _fromLiters(String unit, double liters) {
    switch (unit) {
      case 'l':
        return liters;
      case 'ml':
        return liters * 1000.0;
      case 'gal':
        return liters / 3.785411784;
      case 'cup':
        return liters / 0.24;
      default:
        throw FormatException('Unknown volume unit: $unit');
    }
  }

  static double _convertVolume(String from, String to, double value) {
    final l = _toLiters(from, value);
    return _fromLiters(to, l);
  }

  // ---------------- TEMPERATURE ----------------
  static double _convertTemperature(String from, String to, double value) {
    double inC;
    switch (from) {
      case 'c':
        inC = value;
        break;
      case 'f':
        inC = (value - 32.0) * 5.0 / 9.0;
        break;
      case 'k':
        inC = value - 273.15;
        break;
      default:
        throw FormatException('Unknown temperature unit: $from');
    }

    switch (to) {
      case 'c':
        return inC;
      case 'f':
        return inC * 9.0 / 5.0 + 32.0;
      case 'k':
        return inC + 273.15;
      default:
        throw FormatException('Unknown temperature unit: $to');
    }
  }

  // ---------------- AREA ----------------
  // base: square meters
  static double _toSquareMeters(String unit, double v) {
    switch (unit) {
      case 'sqm':
        return v;
      case 'sqft':
        return v * 0.09290304;
      case 'acre':
        return v * 4046.8564224;
      case 'sqkm':
        return v * 1e6;
      default:
        throw FormatException('Unknown area unit: $unit');
    }
  }

  static double _fromSquareMeters(String unit, double sqm) {
    switch (unit) {
      case 'sqm':
        return sqm;
      case 'sqft':
        return sqm / 0.09290304;
      case 'acre':
        return sqm / 4046.8564224;
      case 'sqkm':
        return sqm / 1e6;
      default:
        throw FormatException('Unknown area unit: $unit');
    }
  }

  static double _convertArea(String from, String to, double value) {
    final sqm = _toSquareMeters(from, value);
    return _fromSquareMeters(to, sqm);
  }
}