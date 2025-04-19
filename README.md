# SafeUnwrap

Lightweight Swift helpers for safely unwrapping `Optional` values with throwable APIs.

## Overview

`SafeUnwrap` provides a clean, consistent way to unwrap optionals in Swift, letting you either supply a custom `Error` or use a default error that includes type information.

## Features

- **`unwrapped(error:) throws -> Wrapped`**
  - Generic method to unwrap an optional or throw a user‑supplied error.
  - Uses `@autoclosure` for a clean call site and deferred evaluation.

- **`unwrapped` computed property**
  - Throws a default `SafeUnwrapError` carrying the missing type if the optional is `nil`.

- **`SafeUnwrapError`**
  - Error type that captures the `Any.Type` of the missing value and prints a helpful description.

## Requirements

- Swift 6.1 or newer
- Swift Package Manager

## Installation

Add the package to your `Package.swift` dependencies:

```swift
// swift-tools-version: 6.1
import PackageDescription

let package = Package(
    name: "YourApp",
    dependencies: [
        .package(url: "https://github.com/ariiscoding/SafeUnwrap", from: "1.0.0"),
    ],
    targets: [
        .target(
            name: "YourApp",
            dependencies: ["SafeUnwrap"]
        ),
    ]
)
```

Or, in Xcode:
1. File ➜ Add Packages...
2. Enter `https://github.com/your-org/SafeUnwrap.git`
3. Choose the version you want.

## Usage

Import and use the APIs in your code:

```swift
import SafeUnwrap

// 1) Custom error:
enum MyError: Error { case missingValue }
let valueOpt: String? = nil

do {
    let value = try valueOpt.unwrapped(error: MyError.missingValue)
    print(value)
} catch {
    print("Caught custom error: \(error)")
}

// 2) Default error:
let intOpt: Int? = nil

do {
    let intValue = try intOpt.unwrapped
    print(intValue)
} catch {
    print(error) // -> "Found nil while unwrapping Optional<Int>"
}
```

## API Reference

### `func unwrapped<E>(error: @autoclosure () -> E) throws(E) -> Wrapped where E: Error`
Unwraps the optional or throws the provided `Error`. The error is only constructed if needed.

- **Parameter**: `error` — an `@autoclosure` returning the `Error` to throw.
- **Throws**: The supplied `Error` if the optional is `nil`.
- **Returns**: The unwrapped `Wrapped` value.

### `var unwrapped: Wrapped`
Computed property that unwraps the optional or throws a default `SafeUnwrapError` with the missing type.

- **Throws**: `SafeUnwrapError` when `self` is `nil`.
- **Returns**: The unwrapped `Wrapped` value.

### `struct SafeUnwrapError: Error, CustomStringConvertible`
Error type capturing the missing `Any.Type`.

- **Property**: `type: Any.Type` — the underlying type that was `nil`.
- **Property**: `description: String` — a friendly message, e.g. `"Found nil while unwrapping Optional<MyType>"`.

## License

This project is available under the MIT License.

