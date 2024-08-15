// Copyright 2022-present 650 Industries. All rights reserved.

/**
 Native equivalent of `Int8Array` in JavaScript, an array of two's-complement 8-bit signed integers.
 */
public final class Int8Array: TypedArray {
  typealias ContentType = Int8
}

/**
 Native equivalent of `Int16Array` in JavaScript, an array of two's-complement 16-bit signed integers.
 */
public final class Int16Array: TypedArray {
  typealias ContentType = Int16
}

/**
 Native equivalent of `Int32Array` in JavaScript, an array of two's-complement 32-bit signed integers.
 */
public final class Int32Array: TypedArray {
  typealias ContentType = Int32
}

/**
 Native equivalent of `Uint8Array` in JavaScript, an array of 8-bit unsigned integers.
 */
public final class Uint8Array: TypedArray {
  typealias ContentType = UInt8
}

/**
 Native equivalent of `Uint8ClampedArray` in JavaScript, an array of 8-bit unsigned integers clamped to 0-255.
 */
public final class Uint8ClampedArray: TypedArray {
  typealias ContentType = UInt8
}

/**
 Native equivalent of `Uint16Array` in JavaScript, an array of 16-bit unsigned integers.
 */
public final class Uint16Array: TypedArray {
  typealias ContentType = UInt16
}

/**
 Native equivalent of `Uint32Array` in JavaScript, an array of 32-bit unsigned integers.
 */
public final class Uint32Array: TypedArray {
  typealias ContentType = UInt32
}

/**
 Native equivalent of `Float32Array` in JavaScript, an array of 32-bit floating point numbers.
 */
public final class Float32Array: TypedArray {
  typealias ContentType = Float32
}

/**
 Native equivalent of `Float64Array` in JavaScript, an array of 64-bit floating point numbers.
 */
public final class Float64Array: TypedArray {
  typealias ContentType = Float64
}

/**
 Native equivalent of `BigInt64Array` in JavaScript, an array of 64-bit signed integers.
 */
public final class BigInt64Array: TypedArray {
  typealias ContentType = Int64
}

/**
 Native equivalent of `BigUint64Array` in JavaScript, an array of 64-bit unsigned integers.
 */
public final class BigUint64Array: TypedArray {
  typealias ContentType = UInt64
}
