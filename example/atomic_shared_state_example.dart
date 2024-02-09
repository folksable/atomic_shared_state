import 'package:atomic_shared_state/atomic_shared_state.dart';

void main() {
  final sharedState = AtomicSharedState<int>(0);
  sharedState.addListener(() {
    print('value changed to ${sharedState.value}');
  });
  sharedState.value = 1;
  sharedState.value = 2;
  sharedState.value = 3;
  sharedState.dispose();
}