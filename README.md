# Atomic Shared State

This Dart package provides a mechanism for managing shared state in a thread-safe manner. It includes two main classes: `SharedStateObject` and `AtomicSharedState`.

## SharedStateObject

`SharedStateObject` is a generic class that represents a shared state object. It allows you to set and get the value of the shared state, add and remove listeners, and notify all listeners of changes. It also provides a `dispose` method to remove all listeners when the object is no longer needed.

## AtomicSharedState

`AtomicSharedState` is a wrapper around `SharedStateObject` that provides a simple way to manage shared state. It ensures that only one operation can be performed on the shared state at a time, preventing race conditions.

## Usage

First, import the package:

```dart
import 'package:atomic_shared_state/atomic_shared_state.dart';
```

Then, create an `AtomicSharedState` object:

```dart
var atomicState = AtomicSharedState<int>(0);
```

You can get and set the value of the shared state:

```dart
print(atomicState.value); // Outputs: 0
atomicState.value = 1;
print(atomicState.value); // Outputs: 1
```

You can add listeners that will be notified when the value changes:

```dart
atomicState.addListener(() {
  print('Value changed to ${atomicState.value}');
});
```

And you can remove listeners when they are no longer needed:

```dart
atomicState.removeListener(listener);
```

Finally, you can dispose of the atomic shared state when it is no longer needed:

```dart
atomicState.dispose();
```

## Logging

This package uses the `logger` package for logging. It logs messages when listeners are added or removed, and errors when there is a problem calling a listener.

## License

This package is licensed under the MIT License. See the LICENSE file for more details.