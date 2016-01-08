@HtmlImport('mobile_desktop.html')
library coffee_shop.mobile_desktop;

import 'dart:html';

import 'package:polymer/polymer.dart';
import 'package:web_components/web_components.dart';

import 'package:polymer_elements/iron_pages.dart';

import 'mobile_view.dart';
import 'desktop_view.dart';

@PolymerRegister('mobile-desktop')
class MobileDesktop extends PolymerElement {
  @Property(
    reflectToAttribute: true,
    notify: true,
    observer: 'phoneScreenChanged'
  )
  bool phone = false;

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

  MobileDesktop.created() : super.created();
  factory MobileDesktop() => document.createElement('mobile-desktop');

  @Observe('phoneScreen')
  void phoneScreenChanged([_, __]) {
    notifyPath('phone', phone);
  }
}