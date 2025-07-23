import 'dart:async';
import 'package:geolocator/geolocator.dart';
import '../../domain/entities/run_data.dart';
import '../data_sources/run_location_service.dart';

class RunRepositoryImpl {
  final RunLocationService _locationService;
  StreamSubscription<Position>? _positionSub;
  final _controller = StreamController<RunData>.broadcast();

  // internal state
  Position? _lastPosition;
  double _totalDistance = 0;
  DateTime? _startTime;

  RunRepositoryImpl(this._locationService);

  Future<void> start() async {
    await _locationService.init();
    _totalDistance = 0;
    _startTime = DateTime.now();
    _lastPosition = null;

    _positionSub = _locationService
        .getPositionStream()
        .listen((pos) {
      final now = DateTime.now();
      if (_lastPosition != null) {
        _totalDistance += Geolocator.distanceBetween(
          _lastPosition!.latitude,
          _lastPosition!.longitude,
          pos.latitude,
          pos.longitude,
        );
      }
      _lastPosition = pos;

      final elapsed = now.difference(_startTime!);
      final currentSpeed = pos.speed;
      final avgSpeed = elapsed.inSeconds > 0
          ? _totalDistance / elapsed.inSeconds
          : 0.0;

      _controller.add(RunData(
        distanceMeters: _totalDistance,
        elapsed: elapsed,
        currentSpeed: currentSpeed,
        averageSpeed: avgSpeed,
      ));
    });
  }

  Future<void> stop() async {
    await _positionSub?.cancel();
    // optionally reset state here
  }

  Stream<RunData> get stream => _controller.stream;
}
