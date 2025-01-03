class Counter {
  int _value = 0;
  int get count => _value;

  void increment() => _value++;//make increment
  void decrement() => _value--;//make decrement

  void reset() => _value = 0;// returned value = 0 again
}
