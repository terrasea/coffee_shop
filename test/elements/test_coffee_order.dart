part of coffee_shop.test;

void test_coffee_order() {
  group('[CoffeeOrder]', () {
    CoffeeOrder element;
    Order order;
    List coffees;
    double total;

    setUp(() {
      var completer = new Completer();

      coffees = [];
      total = 0.0;

      element = new CoffeeOrder();
      element.coffees = coffees;
      element.total = total;

      document.body.append(element);
      element.async(() => completer.complete());

      return completer.future;
    });

    tearDown(() {
      element.remove();
    });

    test('is not null', () {
      expect(element, isNotNull);
    });

    test('there are no initial coffees in the order', () {
      expect(new PolymerDom(element.root).querySelectorAll('.price'), isEmpty);
    });

    test('initial order total is not displayed', () {
      expect(new PolymerDom(element.root).querySelectorAll('.total'), isEmpty);
    });

    group('add coffees', () {
      List coffees = [new OrderCoffee(new Coffee('Flat White'), 2), new OrderCoffee(new Coffee('Long Black'), 1)];
      setUp(() {
        var completer = new Completer();

        element = new CoffeeOrder();
        element.coffees = coffees;

        document.body.append(element);
        element.async(() => completer.complete());

        //needs the double future async as it needs to have time to update display, given there are coffees added
        return completer.future.then((_) {
          var completer = new Completer();

          element.async(() => completer.complete());

          return completer.future;
        });
      });

      tearDown(() {
        element.remove();
      });

      test('order displays coffees', () {

          expect(new PolymerDom(element.root)
              .querySelectorAll('.price')
              .length, 2);

      });

//      test('order total is displayed as £${coffees.fold(0.0, (double prev, OrderCoffee coffee) => prev + double.parse(coffee.price)).toStringAsFixed(2)}', () {
//        print(new PolymerDom(element.root).querySelector('div'));
//        expect(new PolymerDom(element.root).querySelector('.total').text.trim(), '£${coffees.fold(0.0, (double prev, OrderCoffee coffee) => prev + double.parse(coffee.price)).toStringAsFixed(2)}');
//      });
    });

  });
}