@HtmlImport('mobile_view.html')
library coffee_shop.mobile_view;

import 'dart:html';

import 'package:polymer/polymer.dart';
import 'package:web_components/web_components.dart';

import 'package:polymer_elements/paper_button.dart';

@PolymerRegister('mobile-view')
class MobileView extends PolymerElement {
  bool _showForm = false;
  @Property(
    reflectToAttribute: true,
    notify: true
  )
  bool get showForm => _showForm;
  @reflectable
  void set showForm(val) {
    _showForm = val;
    notifyPath('showForm', showForm);
  }

  bool _hasOrder = false;
  @Property(
      reflectToAttribute: true,
      notify: true
  )
  bool get hasOrder => _hasOrder;
  @reflectable
  void set hasOrder(val) {
    _hasOrder = val;
    notifyPath('hasOrder', hasOrder);
  }

  MobileView.created() : super.created();
  factory MobileView() => document.createElement('mobile-view');

  @reflectable
  void verifyOrder([_, __]) {
    if(hasOrder) {
      showForm = true;
    }
  }
}