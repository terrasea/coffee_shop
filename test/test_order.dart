part of coffee_shop.test;

void test_order() {
  group('[Order]', () {
    Order order;

    setUp(() {
      order = new Order();
    });

    tearDown(() {
      order = null;
    });

    test('initial order is empty', () {
      expect(order.coffees, isEmpty);
    });

    test('initial order total is 0', () {
      expect(order.total, 0);
    });

    test('after adding a Flat White total is ${new Coffee('Flat White').price}', () {
      order.coffees.add(new Coffee('Flat White'));

      expect(order.total, new Coffee('Flat White').price);
    });

    test('after adding a Flat White and Long Black total is ${new Coffee('Flat White').price + new Coffee('Long Black').price}', () {
      order.coffees
        ..add(new Coffee('Flat White'))
        ..add(new Coffee('Long Black'))
      ;


      expect(order.total, new Coffee('Flat White').price + new Coffee('Long Black').price);
    });


    test('after adding a Flat White, Long Black and a Mochacinno, total is ${new Coffee('Flat White').price + new Coffee('Long Black').price + new Coffee('Mochaccino').price}', () {
      order.coffees
        ..add(new Coffee('Flat White'))
        ..add(new Coffee('Long Black'))
        ..add(new Coffee('Mochaccino'))
      ;


      expect(order.total, new Coffee('Flat White').price + new Coffee('Long Black').price + new Coffee('Mochaccino').price);
    });

  });
}