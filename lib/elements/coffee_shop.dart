@HtmlImport('coffee_shop.html')
library coffee_shop.coffee_shop;

import 'dart:html';
import 'dart:convert';
import 'dart:js' as js;

import 'package:polymer/polymer.dart';
import 'package:web_components/web_components.dart';

import 'package:polymer_elements/iron_form.dart';
import 'package:polymer_elements/iron_ajax.dart';
import 'package:polymer_elements/paper_button.dart';
import 'package:polymer_elements/iron_media_query.dart';
import 'package:polymer_elements/iron_resizable_behavior.dart';

import 'package:coffee_shop/elements/coffee_chooser.dart';
import 'package:coffee_shop/elements/coffee_order.dart';
import 'package:coffee_shop/elements/coffee_order_total.dart';
import 'package:coffee_shop/elements/mobile_desktop.dart';

import 'package:coffee_shop/coffees.dart';
import 'package:coffee_shop/order.dart';

@PolymerRegister('coffee-shop')
class CoffeeShop extends PolymerElement with IronResizableBehavior {
  Order _order = new Order();
  @Property(reflectToAttribute: true, notify: true)
  Order get order => _order;
  @reflectable
  void set order(val) {
    _order = val;
    notifyPath('order', order);
  }

  List<OrderCoffee> _coffees = [];
  @Property(reflectToAttribute: true, notify: true)
  List<OrderCoffee> get coffees => _coffees;
  @reflectable
  void set coffees(val) {
    _coffees = val;
    notifyPath('coffees', coffees);
  }

  String _total;
  @Property(reflectToAttribute: true, notify: true)
  String get total => _total;
  @reflectable
  void set total(val) {
    _total = val;
    notifyPath('total', total);
  }

  bool _showForm = false;
  @Property(reflectToAttribute: true, notify: true)
  bool get showForm => _showForm;
  @reflectable
  void set showForm(val) {
    _showForm = val;
    notifyPath('showForm', showForm);
  }

  bool _reset = false;
  @Property(notify: true)
  bool get reset => _reset;
  @reflectable
  void set reset(val) {
    _reset = val;
    notifyPath('reset', reset);
  }

  bool _hasOrder = false;
  @Property(reflectToAttribute: true, notify: true)
  bool get hasOrder => _hasOrder;
  @reflectable
  void set hasOrder(val) {
    _hasOrder = val;
    notifyPath('hasOrder', hasOrder);
  }

  bool _phone = false;
  @Property(reflectToAttribute: true, notify: true)
  bool get phone => _phone;
  @reflectable
  void set phone(val) {
    _phone = val;
    notifyPath('phone', phone);
  }

  CoffeeShop.created() : super.created();
  factory CoffeeShop() => document.createElement('coffee-shop');

//  void ready() {
//    on['iron-resize'].listen((CustomEvent e) {
//      print('${parent.offsetWidth}');
//    });
//  }

  @reflectable
  void addCoffee(e, coffee) {
    order.coffees.add(coffee);
    this.coffees = _parseToOrderCoffees(order.coffees);
  }

  @reflectable
  void removeCoffee(e, coffee) {
    coffees.clear();
    order.coffees.remove(coffee);
    coffees = _parseToOrderCoffees(order.coffees);
  }

  @reflectable
  void preprocessOrder(CustomEventWrapper e, d) {
    print(((e.currentTarget as IronForm).request as IronAjax));
    js.JsObject obj =
        ((e.currentTarget as IronForm).serialize() as js.JsObject);

    List coffeeOrder = JSON
        .decode(JSON.decode(js.context['JSON'].callMethod('stringify', [obj]))[
            'order'])
        .map((item) => JSON.decode(item))
        .toList();

    window.alert(JSON.encode(coffeeOrder));
    e.preventDefault();
  }

  List<OrderCoffee> _parseToOrderCoffees(List<Coffee> val) {
    Map map = {};
    val.forEach((Coffee coffee) {
      OrderCoffee item =
          map.putIfAbsent(coffee.name, () => new OrderCoffee(coffee, 0));
      item.quantity++;
    });
    return map.values.toList()
      ..sort((item1, item2) => item1.coffee.name.compareTo(item2.coffee.name));
  }

  @reflectable
  void placeOrder([_, __]) {
    ($['order-form'] as IronForm).submit();
    showForm = false;
    order.coffees.clear();
    coffees = [];
    notifyPath('coffees', coffees);
    reset = true;
  }

  @reflectable
  void addMore([_, __]) {
    showForm = false;
  }

  @reflectable
  void cancelOrder([_, __]) {
    showForm = false;
    order.coffees.clear();
    coffees = [];
    notifyPath('coffees', coffees);
    reset = true;
  }
}
