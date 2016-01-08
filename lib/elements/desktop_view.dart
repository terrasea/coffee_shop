@HtmlImport('desktop_view.html')
library coffee_shop.desktop_view;

import 'dart:html';

import 'package:polymer/polymer.dart';
import 'package:web_components/web_components.dart';

@PolymerRegister('desktop-view')
class DesktopView extends PolymerElement {

  DesktopView.created() : super.created();
  factory DesktopView() => document.createElement('desktop-view');
}