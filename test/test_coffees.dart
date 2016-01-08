part of coffee_shop.test;

void test_coffees() {
  group('[Coffee]', () {
    test('non existent coffee creates fake coffee instance', () {
      expect(new Coffee('REally Fake'), new isInstanceOf<FakeCoffee>());
    });

    test('creates Flat White', () {
      expect(new Coffee('Flat White'), new isInstanceOf<FlatWhite>());
    });

    test('New Flat White is same object as previously created', () {
      var coffee = new Coffee('Flat White');
      expect(new Coffee('Flat White'), coffee);
    });

    test('creates Long Black', () {
      expect(new Coffee('Long Black'), new isInstanceOf<LongBlack>());
    });

    test('New Long Black is same object as previously created', () {
      var coffee = new Coffee('Long Black');
      expect(new Coffee('Long Black'), coffee);
    });

    test('creates Mochaccino', () {
      expect(new Coffee('Mochaccino'), new isInstanceOf<Mochaccino>());
    });

    test('New Mochaccino is same object as previously created', () {
      var coffee = new Coffee('Mochaccino');
      expect(new Coffee('Mochaccino'), coffee);
    });
  });
}