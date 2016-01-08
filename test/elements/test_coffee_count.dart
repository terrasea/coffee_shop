part of coffee_shop.test;

void test_coffee_count() {
  group('[CoffeeCount]', () {
    PolymerElement element;
    setUp(() {
      var completer = new Completer();

      element = new CoffeeCount();
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

    test('count is initially 0', () {
      expect(element.text.trim(), '0');
    });

    test('count when set to 1 displays 1', () {
      element.set('count', 1);
      expect(element.text.trim(), '1');
    });
  });
}