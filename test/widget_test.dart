import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pustakara_web/main.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const PustakaraApp());
    expect(find.text('PUSTAKARA'), findsOneWidget);
  });
}