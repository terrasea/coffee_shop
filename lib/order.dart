library coffee_shop.order;

import 'dart:convert' show JSON;

import 'package:polymer/polymer.dart' show reflectable, JsProxy;

import 'coffees.dart';

class Order extends JsProxy {
  @reflectable List<Coffee> coffees = new List<Coffee>();

  @reflectable double get total => coffees.fold(0.0, (price, coffee) => price + coffee.price);
}

class OrderCoffee extends JsProxy {
  @reflectable Coffee coffee;
  @reflectable int quantity = 0;
  @reflectable String get price => (coffee.price * quantity).toStringAsFixed(2);

  OrderCoffee(this.coffee, this.quantity);

  factory OrderCoffee.fromJson(Map json) {
    return new OrderCoffee(new Coffee(json['coffee']), json['quantity']);
  }

  String toJson() {
    return JSON.encode({'coffee': coffee.name, 'quantity': quantity, 'price': coffee.price * quantity});
  }
}