# minNonZeroFloat64 equals the smallest possible non-zero 64-bit floating point
# number value
function std::minNonZeroFloat64 -> Float64 =
    // 1 / 2**(1023 - 1 + 52)
    4.940656458412465441765687928682213723651e-324
