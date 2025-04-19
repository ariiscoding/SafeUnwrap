
extension Optional {
    /// Safely unwraps the optional or throws the provided error (or a default one).
    ///
    /// - Parameter error: An `@autoclosure` that returns the `Error` to throw if the underlying value is `nil`.
    /// - Throws: The passed-in error.
    /// - Returns: The unwrapped value.
    public func unwrapped<E>(error: @autoclosure () -> E) throws(E) -> Wrapped where E: Error {
        guard let value = self else {
            throw error()
        }
        return value
    }
    
    /// Safely unwraps the optional or throws `SafeUnwrapError`.
    ///
    /// - Throws: `SafeUnwrapError` with the associated type `Wrapped`.
    /// - Returns: The unwrapped value.
    public var unwrapped: Wrapped {
        get throws(SafeUnwrapError) {
            try unwrapped(error: SafeUnwrapError(type: Wrapped.self))
        }
    }
}
