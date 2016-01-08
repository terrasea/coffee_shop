part of coffee_shop.test;

void test_coffee_chooser() {
  group('[CoffeeChooser]', () {
    PolymerElement element;
    setUp(() {
      var completer = new Completer();

      element = new CoffeeChooser();
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


    test('has 6 buttons/coffees', () {
      expect(new PolymerDom(element.root).querySelectorAll('paper-button').length, 6);
    });

    test('tap coffee button emits add-coffee event', () {
      var completer = new Completer();
      element.on['add-coffee'].listen((e, [d]) {
          completer.complete();
        });
      ;

      new PolymerDom(element.root).querySelector('paper-button').click();

      expect(completer.future, completes);
    });


    test('all coffee-count elements are initially set to 0', () {
      var coffee_counts = new PolymerDom(element.root).querySelectorAll('coffee-count');
      expect(coffee_counts.every((coffee_count) => coffee_count.text.trim() == '0'), isTrue);
    });


    test('tap coffee button increments inner coffee-count of paper-button by 1', () {
      var coffee_count = new PolymerDom(element.root).querySelector('coffee-count');
      new PolymerDom(element.root).querySelector('paper-button').click();

      expect(coffee_count.text.trim(), '1');
    });
  });
}

