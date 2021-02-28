import 'package:flutter/foundation.dart';

/// Inspired by Java's Optional type.
@immutable
class Optional<T> {
  final T _optional;

  Optional._internal(this._optional);

  factory Optional(T it) => Optional._internal(it);

  factory Optional.of(T it) => Optional._internal(it);

  factory Optional.ofNullable(T it) => Optional._internal(it);

  factory Optional.empty() => Optional._internal(null);

  bool isPresent() => _optional != null;

  T get() =>
      isPresent() ? _optional : throw Exception("The Optional value is null!");

  @override
  int get hashCode => _optional.hashCode;

  @override
  bool operator ==(other) {
    return (other is Optional) && other._optional == _optional;
  }
}
