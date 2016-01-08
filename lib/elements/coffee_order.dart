@HtmlImport('coffee_order.html')
library coffee_shop.coffee_order;

import 'dart:html';
import 'dart:convert' show JSON;

import 'package:polymer/polymer.dart';
import 'package:web_components/web_components.dart';

import 'package:polymer_elements/iron_flex_layout/classes/iron_flex_layout.dart';
import 'package:polymer_elements/iron_form_element_behavior.dart';
import 'package:polymer_elements/iron_media_query.dart';

import 'package:coffee_shop/order.dart' show OrderCoffee;
import 'package:coffee_shop/coffees.dart' show Coffee, FlatWhite;

@PolymerRegister('coffee-order')
class CoffeeOrder extends PolymerElement with IronFormElementBehavior {
  @Property(
    notify: true
  )
  bool phoneScreen = false;


  @Property(
      reflectToAttribute: true,
      notify: true,
      computed: "hasOrder(hasTotal)"
  )
  bool showOrder;


  @reflectable
  bool hasOrder(totalShown) {
    return totalShown;
  }


  String _value;
  @Property(
      reflectToAttribute: true,
      notify: true
  )
  String get value => _value;
  @reflectable
  void set value(val) {
    _value = val;
    notifyPath('value', value);
  }

  List _coffees = [];
  @Property(
      reflectToAttribute: true,
      notify: true
  )
  List get coffees => _coffees;
  @reflectable
  void set coffees(val) {
    _coffees = val;
    total = _coffees.fold(0.0, (double prev, next) => prev + double.parse(next.price));
    notifyPath('coffees', coffees);
    value = JSON.encode(coffees);
//    notifyPath('value', value);
  }

  String _total = 0.0.toStringAsFixed(2);
  @Property(reflectToAttribute: true, notify: true)
  String get total => _total;
  @reflectable
  void set total(val) {
    if(val is double || val is int) {
      _total = val.toStringAsFixed(2);
    } else {
      _total = val;
    }

    if(double.parse(total, (src) => 0.0) > 0) {
      set('hasTotal', true);
    } else {
      set('hasTotal', false);
    }

    notifyPath('total', total);
  }

  @Property(notify: true)
  bool hasTotal = false;

  CoffeeOrder.created() : super.created();
  factory CoffeeOrder() => document.createElement('coffee-order');
}
