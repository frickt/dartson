library dartson.inheritance;

/// The interface for creating new transformers.
/// For a basic example on how to use this interface take a look at [DateTimeParser].
abstract class EntityMapperFactory {

  /// Receives the [value] of type [T] and returns a serializable result which
  /// will be passed into the JSON representation.
  Object getInstance(String className);
}