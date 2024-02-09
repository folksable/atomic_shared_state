import 'package:atomic_shared_state/atomic_shared_state.dart';
import 'package:test/test.dart';

void main() {
  group('test shared state', () {
    test('test shared state', () {
      final sharedState = AtomicSharedState<int>(0);
      sharedState.addListener(() {
        print('value changed to ${sharedState.value}');
      });
      sharedState.value = 1;
      sharedState.value = 2;
      sharedState.value = 3;
      sharedState.dispose();
    });

    test('test values change', () {
      final sharedState = AtomicSharedState<int>(0);
      int count = 0;

      sharedState.addListener(() {
        count++;
      });

      for (int i = 0; i < 100; i++) {
        sharedState.value = i;
      }

      expect(count, 100);
      sharedState.dispose();
    });

    test('test values are correctly assigned', () {
      final sharedState = AtomicSharedState<int>(0);
      sharedState.value = 1;
      expect(sharedState.value, 1);
      sharedState.dispose();
    });

    test('listeners are removed correctly', () {
      final sharedState = AtomicSharedState<int>(0);
      int count = 0;

      void incrCount() {
        count++;
      }

      sharedState.addListener(incrCount);

      sharedState.value = 1;
      sharedState.value = 2;
      sharedState.value = 3;

      sharedState.removeListener(incrCount);

      sharedState.value = 4;
      sharedState.value = 5;
      sharedState.value = 6;

      expect(count, 3);
      sharedState.dispose();
    });

    test('listener throws exception', () {
      final sharedState = AtomicSharedState<int>(0);

      sharedState.addListener(() {
        print('value changed to ${sharedState.value}');
      });

      sharedState.addListener(() {
        throw Exception('test exception');
      });

      sharedState.value = 1;
      sharedState.value = 2;
      sharedState.value = 3;

      sharedState.dispose();
    });

  });
}
