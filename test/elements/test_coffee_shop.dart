part of coffee_shop.test;

void test_coffee_shop() {
  group('[CoffeeShop]', () {
    CoffeeShop element;

    setUp(() {
      var completer = new Completer();
      element = new CoffeeShop();
      document.body.append(element);
      element.async(() => completer.complete());
      return completer.future.then((_) {
        var completer = new Completer();
        element.async(() => completer.complete());
        return completer.future;
      });
    });

    tearDown(() => element.remove());

    test('is not null', () {
      expect(element, isNotNull);
    });

    test('contains <coffee-order>', () {
      expect(new PolymerDom(element.root).querySelector('coffee-order'), isNotNull);
    });

    test('contained <coffee-order> is instance of CoffeeOrder', () {
      expect(new PolymerDom(element.root).querySelector('coffee-order'), new isInstanceOf<CoffeeOrder>());
    });

    test('contains <coffee-chooser>', () {
      expect(new PolymerDom(element.root).querySelector('coffee-chooser'), isNotNull);
    });

    test('contained <coffee-chooser> is instance of CoffeeChooser', () {
      expect(new PolymerDom(element.root).querySelector('coffee-chooser'), new isInstanceOf<CoffeeChooser>());
    });

    group('tapping coffee paper-button in <coffee-chooser>', () {
      CoffeeOrder order;
      //every notifyPath, etc needs a further async call, in this case order total is updated then another async to add the coffees into order
      //irritating, but there you have it.  There must be a better way.
      setUp(() {
        var completer = new Completer();
        element = new CoffeeShop();
        document.body.append(element);
        element.async(() => completer.complete());
        return completer.future.then((_) {
          var completer = new Completer();
          element.async(() => completer.complete());
          return completer.future.then((_) {
            var completer = new Completer();
            CoffeeChooser chooser = new PolymerDom(element.root).querySelector('coffee-chooser');
            new PolymerDom(chooser.root).querySelector('paper-button').click();
            order = new PolymerDom(element.root).querySelector('coffee-order');
            order.async(() => completer.complete());
            return completer.future.then((_) {
              var completer = new Completer();
              order.async(() => completer.complete());
              return completer.future;
            });
          });
        });
      });

      tearDown(() {
        element.remove();
        order = null;
      });

      test(' adds coffee to <coffee-order>', () {
        expect(new PolymerDom(order.root).querySelectorAll('.price'), isNotEmpty);
      });


//      test('makes total in <coffee-order> greater than 0', () {
//        expect(double.parse(new PolymerDom(order.root).querySelector('.total').text.trim().replaceAll('£', ''), (str) => 0.0), greaterThan(0.0));
//      });


    });

    group('tapping queue paper-button in emits submit', () {
      CoffeeOrder order;
      //every notifyPath, etc needs a further async call, in this case order total is updated then another async to add the coffees into order
      //irritating, but there you have it.  There must be a better way.
      setUp(() {
        var completer = new Completer();
        element = new CoffeeShop();
        document.body.append(element);
        element.async(() => completer.complete());
        return completer.future.then((_) {
          var completer = new Completer();
          element.async(() => completer.complete());
          return completer.future.then((_) {
            var completer = new Completer();
            CoffeeChooser chooser = new PolymerDom(element.root).querySelector('coffee-chooser');
            new PolymerDom(chooser.root).querySelector('paper-button').click();
            order = new PolymerDom(element.root).querySelector('coffee-order');
            order.async(() => completer.complete());
            return completer.future.then((_) {
              var completer = new Completer();
              order.async(() => completer.complete());
              return completer.future;
            });
          });
        });
      });

      tearDown(() {
        element.remove();
        order = null;
      });

//      test('sends to server', () {
//        new PolymerDom(element.root).querySelector('#place').click();
//
//
//      });

    });
  });
}