import 'package:logger/logger.dart';

typedef Listener = void Function();

/// A logger instance for logging messages and errors.
final Logger _logger = Logger(
  printer: SimplePrinter(),
);

/// A generic class representing a shared state object.
class SharedStateObject<T> {
  T _value;
  final List<Listener> _listeners = [];
  static final bool log = false;

  /// Constructs a [SharedStateObject] with an initial value.
  SharedStateObject(this._value);

  /// Retrieves the current value of the shared state object.
  T get value => _value;

  /// Sets the value of the shared state object and notifies all listeners.
  set value(T newValue) {
    _value = newValue;
    _notifyListeners();
  }

  /// Adds a listener function to the shared state object.
  void addListener(Listener listener) {
    _listeners.add(listener);
    if(log) {
      _logger.i('Listener added to the shared state object. Total listeners: ${_listeners.length}');
    }
  }

  /// Removes a listener function from the shared state object.
  void removeListener(Listener listener) {
    _listeners.remove(listener);
    if(log) {
      _logger.i('Listener removed from the shared state object. Total listeners: ${_listeners.length}');
    }
  }

  /// Notifies all listeners of the shared state object.
  void _notifyListeners() {
    for (var listener in _listeners) {
      try {
        listener();
      } catch (err) {
        _logger.e('Error calling listener',
            stackTrace: StackTrace.current, error: err);
      }
    }
  }

  /// Disposes the shared state object by removing all listeners.
  void dispose() {
    _listeners.clear();
  }
}

/// A generic class representing an atomic shared state.
class AtomicSharedState<T> {
  final SharedStateObject<T> _sharedStateObject;

  /// Constructs an [AtomicSharedState] with an initial value.
  AtomicSharedState(T initialValue)
      : _sharedStateObject = SharedStateObject(initialValue);

  /// Retrieves the current value of the atomic shared state.
  T get value => _sharedStateObject.value;

  /// Sets the value of the atomic shared state.
  set value(T newValue) {
    _sharedStateObject.value = newValue;
  }

  /// Adds a listener function to the atomic shared state.
  void addListener(Listener listener) {
    _sharedStateObject.addListener(listener);
  }

  /// Removes a listener function from the atomic shared state.
  void removeListener(Listener listener) {
    _sharedStateObject.removeListener(listener);
  }

  /// Disposes the atomic shared state by removing all listeners.
  void dispose() {
    _sharedStateObject.dispose();
  }
}
