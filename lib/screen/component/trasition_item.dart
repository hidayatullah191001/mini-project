import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

PageTransition TransisiHalaman(
    {required PageTransitionType tipe,
    Alignment? align,
    required Widget page}) {
  return PageTransition(
    type: tipe,
    alignment: align,
    duration: const Duration(milliseconds: 700),
    reverseDuration: const Duration(milliseconds: 700),
    child: page,
  );
}
