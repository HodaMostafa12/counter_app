
import 'package:counter_app/CounterApp/counter.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late Counter counter;
  setUp(
    () {
      counter = Counter();
    },
  );
  
  group('Counter class -', () {
    
    test('value of count should be 0', () {
      //act
      final val = counter.count;
      //Assert
      expect(val, 0);
    });

    test('value of count should be 1', () {
      counter.increment();
      final val = counter.count;
      expect(val, 1);
    });

    test('value of count in case decrement should be -1', () {
      counter.decrement();
      final val = counter.count;
      expect(val, -1);
    });

    test('value of count in reset count should be 0', () {
      counter.reset();
      final val = counter.count;
      expect(val, 0);
    });
  });
}
