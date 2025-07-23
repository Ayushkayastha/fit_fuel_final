import 'package:geolocator/geolocator.dart';

class RunLocationService {
  Future<void> init() async {
    await Geolocator.checkPermission();
    await Geolocator.requestPermission();
  }

  Stream<Position> getPositionStream() {
    return Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.bestForNavigation,
        distanceFilter: 1,
      ),
    );
  }
}
