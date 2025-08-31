/// Simple model representing a unit
class Unit {
  final String id;
  final String name;

  Unit({required this.id, required this.name});

  @override
  String toString() => name;
}