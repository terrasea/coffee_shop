@HtmlImport('coffee_order_total.html')
library coffee_shop.coffee_order_total;

import 'dart:html';

import 'package:polymer/polymer.dart';
import 'package:web_components/web_components.dart';

import 'package:polymer_elements/iron_flex_layout/classes/iron_flex_layout.dart';

@PolymerRegister('coffee-order-total')
class CoffeeOrderTotal extends PolymerElement {
  String _total;
  @Property(
    reflectToAttribute: true,
    notify: true
  )
  String get total => _total;
  @reflectable
  void set total(val) {
    _total = val;
    notifyPath('total', total);
  }

  bool _phone = false;
  @Property(
    reflectToAttribute: true,
    notify: true
  )
  bool get phone => _phone;
  @reflectable
  void set phone(val) {
    _phone = val;
    notifyPath('phone', phone);
  }

  CoffeeOrderTotal.created() : super.created();
  factory CoffeeOrderTotal() => document.createElement('coffee-order-total');

  void ready() {
    async(() {
//      this.customStyle['--total-font-size'] = 'large';
//      updateStyles();
    });
  }
}