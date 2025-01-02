class Counter {
  int _value = 0;
  int get count => _value;

  void increment() => _value++;
  void decrement() => _value--;

  void reset() => _value = 0;
}
