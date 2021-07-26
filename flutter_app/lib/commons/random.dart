import 'dart:math';

Random source = Random();

/// Generate random double in range of min (inclusive) to max (exclusive)
double doubleRandomRange(double min, double max) {
  return source.nextDouble() * (max - min) + min;
}

/// Generate random int in range of min (inclusive) to max (exclusive)
int intRandomRange(int min, int max) {
  return source.nextInt(max - min) + min;
}
