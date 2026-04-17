validator demo(
  param1: (ByteArray, ByteArray),
  param2: ByteArray,
  param3: ByteArray,
) {
  else(_) {
    expect param1.1st == param2
    expect param1.2nd == param3
    True
  }
}
