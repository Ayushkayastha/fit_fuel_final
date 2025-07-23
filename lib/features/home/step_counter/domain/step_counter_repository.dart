abstract class StepCounterRepository {
  Stream<int> getStepCountStream();
  Future<bool> requestPermission();
}