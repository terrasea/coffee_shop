@HtmlImport('coffee_count.html')
library coffee_shop.coffee_order_count;

import 'dart:html';

import 'package:polymer/polymer.dart';
import 'package:web_components/web_components.dart';

@PolymerRegister('coffee-count')
class CoffeeCount extends PolymerElement {
  int _count = 0;
  @Property(
      reflectToAttribute: true,
      notify: true
  )
  int get count => _count;
  @reflectable
  void set count(val) {
    _count = val;
    notifyPath('count', count);
  }

  CoffeeCount.created() : super.created();

  factory CoffeeCount() => document.createElement('coffee-count');
}