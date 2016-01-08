//@MirrorsUsed(metaTargets: CoffeeName)
library coffee_shop.coffees;

//import 'dart:mirrors';
import 'package:polymer/polymer.dart' show reflectable, JsProxy;

import 'package:reflectable/reflectable.dart';

class CoffeeName extends Reflectable {
//  final String name;
//  final String image;

  const CoffeeName() : super(newInstanceCapability, subtypeQuantifyCapability);
}

@CoffeeName()
abstract class Coffee extends JsProxy {
  static Map _cache = {};
  static Map get cache => _cache;

  String get id;
  String get name;
  double get price;

  factory Coffee(String name) => _cache.putIfAbsent(name, () => _findCoffee(name));

  static Coffee _findCoffee(String name) {
    const coffeeName = const CoffeeName();
    Map coffees = coffeeName.annotatedClasses.fold({}, (memo, c) => memo..[c.simpleName] = c);

    var className = name.replaceAll(' ', '');

    return coffees.containsKey(className) ? coffees[className].newInstance('', []) : new FakeCoffee();
//    var coffeeShop = currentMirrorSystem().findLibrary(#coffee_shop.coffees);
//    var coffees = coffeeShop.declarations.values.where((el) => el.metadata.where((ins) => ins.reflectee.runtimeType == CoffeeName && ins.reflectee.name == name).toList().length > 0);
//
//    return coffees.length > 0 ? coffees.first.newInstance(const Symbol(''), []).reflectee : new FakeCoffee();
  }
}

class FakeCoffee extends JsProxy implements Coffee {
  @reflectable String get id => "FakeCoffee";
  @reflectable String get name => 'Unknown Coffee';
  @reflectable double get price => 0.0;
}


//@CoffeeName()
//'Flat White', image: 'flat_white.jpg')
class FlatWhite extends JsProxy implements Coffee {
  @reflectable String get id => "FlatWhite";
  @reflectable String get name => 'Flat White';
  @reflectable double get price => 3.5;
}


//@CoffeeName()
//'Long Black', image: 'long_black.jpg')
class LongBlack extends JsProxy implements Coffee {
  @reflectable String get id => "LongBlack";
  @reflectable String get name => 'Long Black';
  @reflectable double get price => 2.5;
}

//@CoffeeName()
//('Mochaccino', image: 'mochaccino.jpg')
class Mochaccino extends JsProxy implements Coffee {
  @reflectable String get id => "Mochaccino";
  @reflectable String get name => 'Mochaccino';
  @reflectable double get price => 4.0;
}

class Cappuccino extends JsProxy implements Coffee {
  @reflectable String get id => "Cappuccino";
  @reflectable String get name => 'Cappuccino';
  @reflectable double get price => 4.0;
}

class Latte extends JsProxy implements Coffee {
  @reflectable String get id => "Latte";
  @reflectable String get name => 'Latte';
  @reflectable double get price => 4.0;
}

class Espresso extends JsProxy implements Coffee {
  @reflectable String get id => "Espresso";
  @reflectable String get name => 'Espresso';
  @reflectable double get price => 2.0;
}
