//@TestOn('dartium')
library coffee_shop.test;

import 'dart:html';
import 'dart:async';
import 'dart:js' as js;

import 'package:polymer/polymer.dart';

import 'package:test/test.dart';

import 'package:coffee_shop/coffees.dart';
import 'package:coffee_shop/order.dart';

import 'package:coffee_shop/elements/coffee_chooser.dart';
import 'package:coffee_shop/elements/coffee_count.dart';
import 'package:coffee_shop/elements/coffee_order.dart';
import 'package:coffee_shop/elements/coffee_shop.dart';

part 'test_coffees.dart';
part 'test_order.dart';

part 'elements/test_coffee_chooser.dart';
part 'elements/test_coffee_count.dart';
part 'elements/test_coffee_order.dart';
part 'elements/test_coffee_shop.dart';

main() async {
  await initPolymer();

  test_coffees();
  test_order();

  test_coffee_chooser();
  test_coffee_count();
  test_coffee_order();
  test_coffee_shop();
}