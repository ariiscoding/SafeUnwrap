
public struct SafeUnwrapError: Error, CustomStringConvertible {
    public let type: Any.Type
    
    public var description: String {
        "Found nil while unwrapping Optional<\(type)>"
    }
    
    public init(type: Any.Type) {
        self.type = type
    }
}
