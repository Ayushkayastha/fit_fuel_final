import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'nav_bar_provider.g.dart';

@riverpod
class BottomNavBarIndex extends _$BottomNavBarIndex {
  @override
  int build() {
    return 0;
  }

  void setIndex(int newIndex) {
    state = newIndex;
  }
}
