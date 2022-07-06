import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Category{
  final int quiz_id;
  final String name;
  final dynamic icon;
  Category(this.quiz_id, this.name, {this.icon});

}

final List<Category> categories = [
  Category(9,"Angular Js", icon: FontAwesomeIcons.globeAsia),
];