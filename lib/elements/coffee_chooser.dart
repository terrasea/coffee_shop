@HtmlImport('coffee_chooser.html')
library coffee_shop.coffee_chooser;

import 'dart:html';

import 'package:polymer/polymer.dart';
import 'package:web_components/web_components.dart';


import 'package:polymer_elements/paper_card.dart';
import 'package:polymer_elements/iron_selector.dart';
import 'package:polymer_elements/iron_icon.dart';
import 'package:polymer_elements/paper_button.dart';

import 'coffee_count.dart';

import 'package:coffee_shop/coffees.dart';

@PolymerRegister('coffee-chooser')
class CoffeeChooser extends PolymerElement {


  Map<String, String> _coffees;
  @property Map<String, String> get coffees {
    if(_coffees == null) {
      const coffeeName = const CoffeeName();

      var coffees = coffeeName.annotatedClasses.map((c) => c.simpleName).toList()..removeWhere((String c) => c.contains('FakeCoffee') || c.contains(new RegExp(r'^Coffee$')));

      _coffees = new Map.fromIterable(coffees,
          key: (String name) => name.contains(new RegExp(r'[A-Z]'), 1) ? '${name.substring(0, name.indexOf(new RegExp(r'[A-Z]'), 1))} ${name.substring(name.indexOf(new RegExp(r'[A-Z]'), 1), name.length)}' : name,
          value: (String name) => name.contains(new RegExp(r'[A-Z]'), 1) ? '${name.substring(0, name.indexOf(new RegExp(r'[A-Z]'), 1)).toLowerCase()}_${name.substring(name.indexOf(new RegExp(r'[A-Z]'), 1), name.length).toLowerCase()}.jpg' : '${name.toLowerCase()}.jpg');
    }

    return _coffees;
  }

  List<Map<String, String>> _coffeeVals;
  @Property(
    notify: true
  )
  List<Map<String, dynamic>> get coffeeVals {
    if(_coffeeVals == null) {
      _coffeeVals = coffees.keys.map((key) => {'name': key, 'image': coffees[key], 'id': key.replaceAll(' ', ''), 'count': 0, 'price': 0.toStringAsFixed(2)}).toList();
    }

    return _coffeeVals;
  }
  @reflectable
  void set coffeeVals(val) {
    _coffeeVals = val;
    notifyPath('coffeeVals', coffeeVals);
  }

  bool _reset = false;
  @Property(
    reflectToAttribute: true,
    notify: true,
    observer: 'resetChanged'
  )
  bool get reset => _reset;
  @reflectable
  void set reset(val) {
    _reset = val;
    notifyPath('reset', reset);
  }

  CoffeeChooser.created() : super.created();

  factory CoffeeChooser() => document.createElement('coffee-chooser');

  @reflectable
  void selectCoffee(CustomEvent e, i) {
    PaperButton button = e.currentTarget;

    var coffeeVal = coffeeVals.firstWhere((vals) => vals['id'] == button.id);

    coffeeVal['count']++;

    Coffee coffee = new Coffee(coffeeVal['name']);
    fire('add-coffee', detail: coffee);

    _updateCoffeeVals(coffeeVal);
    //there has to be a better way to do this, but with the number of coffees varying, it hard to do through 2 or 1 way binding
//    (new PolymerDom(this.root).querySelector('#count-${coffee.id}') as PolymerElement).set('count', coffeeVal['count']);
  }

  void _updateCoffeeVals(coffeeVal) {
    int pos = coffeeVals.indexOf(coffeeVal);
    set('coffeeVals.${pos}.count', coffeeVal['count']);
    set('coffeeVals.${pos}.price', (new Coffee(coffeeVal['name']).price * coffeeVal['count']).toStringAsFixed(2));

//    notifyPath('coffeeVals', coffeeVals);
  }

  @reflectable
  void removeCoffee(event, detail) {
    switch(detail['state']) {
      case 'start':
        break;
      case 'track':
        break;
      case 'end':
        var button = event.currentTarget;
        var coffeeVal = coffeeVals.firstWhere((vals) => vals['id'] == button.id);
        if(coffeeVal['count'] > 0) coffeeVal['count']--;
        Coffee coffee = new Coffee(coffeeVal['name']);
        fire('remove-coffee', detail: coffee);
        _updateCoffeeVals(coffeeVal);
        break;
    }
  }

  @Observe('reset')
  void resetChanged([_, __]) {
    if(reset) {
      coffeeVals.forEach((coffeeVal) {
        coffeeVal['count'] = 0;
        _updateCoffeeVals(coffeeVal);
      });
      reset = false;
    }
  }
}