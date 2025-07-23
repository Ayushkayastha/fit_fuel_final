class RunData {
  final double distanceMeters;
  final Duration elapsed;
  final double currentSpeed; // m/s
  final double averageSpeed; // m/s

  RunData({
    required this.distanceMeters,
    required this.elapsed,
    required this.currentSpeed,
    required this.averageSpeed,
  });
}
