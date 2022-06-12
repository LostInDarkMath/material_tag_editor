class Tag {
  final String name;
  final double weight;
  final String description;

  const Tag({
    required this.name,
    required this.weight,
    required this.description,
  });

  @override
  String toString() => '$name, $weight, $description';
}
