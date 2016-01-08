library coffee_shop;

@MirrorsUsed(metaTargets: Inject) // might be necessary when you build this code to JavaScript
import 'dart:mirrors';


class Inject {
  final name;
  const Inject(this.name);
}

abstract class Coffee {
  static final _types = {};
  static final Map _cache = {};

  String get name;
  double get profit;

  factory Coffee.create(name) => _cache.putIfAbsent(name, () => _findCoffee(name));

  static Coffee _findCoffee(name) {
    var coffeeShop = currentMirrorSystem().findLibrary(#coffee_shop);
    var coffees = coffeeShop.declarations.values.where((el) => el.metadata.where((ins) => ins.reflectee.runtimeType == Inject && ins.reflectee.name == name).toList().length > 0);

    return coffees.length > 0 ? coffees.first.newInstance(const Symbol(''), []).reflectee : new FakeCoffee();
  }
}

class FakeCoffee implements Coffee {
  String get name => 'Unknown Coffee';
  double get profit => 0.0;
}

@Inject('Cappucinno')
class Cappucinno implements Coffee {
  String get name => 'Cappucinno';
  double get profit => 0.5;
}

@Inject('Flat White')
class FlatWhite implements Coffee {
  String get name => 'Flat White';
  double get profit => 0.3;
}


@Inject('Esspresso')
class Esspresso implements Coffee {
  String get name => 'Esspresso';
  double get profit => 0.1;
}

main() {
  var coffee = new Coffee.create('Cappucinno');
  print(coffee.name);
  print(coffee.profit);

  var coffee2 = new Coffee.create('Flat White');
  print(coffee2.name);
  print(coffee2.profit);

  var coffee3 = new Coffee.create('Invalid Coffee Name');
  print(coffee3.name);
  print(coffee3.profit);

  var coffee4 = new Coffee.create('Esspresso');
  print(coffee4.name);
  print(coffee4.profit);
}
