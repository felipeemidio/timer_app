import 'package:fake_async/fake_async.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_timer/timer_controller.dart';
import 'package:flutter_timer/timer_page.dart';

main() {
  testWidgets('Widget - Check timer page initialState', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: TimerPage()));

    final textWidget = find.text('10');
    final buttonWidget = find.byType(ElevatedButton);

    expect(textWidget, findsOneWidget);
    expect(buttonWidget, findsOneWidget);
  });

  testWidgets('Widget - Test timer running', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: TimerPage()));

    final buttonWidget = find.byType(ElevatedButton);

    expect(
      tester.widget(buttonWidget),
      isA<ElevatedButton>().having((t) => t.enabled, 'enabled', true),
    );

    await tester.tap(buttonWidget);
    await tester.pump();

    expect(find.text('10'), findsOneWidget);
    expect(
      tester.widget(buttonWidget),
      isA<ElevatedButton>().having((t) => t.enabled, 'enabled', false),
    );

    await tester.pump(const Duration(seconds: 1));

    expect(find.text('9'), findsOneWidget);

    await tester.pump(const Duration(seconds: 2));

    expect(find.text('7'), findsOneWidget);

    await tester.pump(const Duration(seconds: 7));

    expect(find.text('0'), findsOneWidget);
    expect(
      tester.widget(buttonWidget),
      isA<ElevatedButton>().having((t) => t.enabled, 'enabled', true),
    );
  });

  test('Controller - Test timer running', () async {
    const int initialTime = 12; // needs to be > 2
    final controller = TimerController(initialTimeInSeconds: initialTime);

    expect(controller.currentTimeInSeconds, initialTime);
    expect(controller.isActive, false);

    controller.initTimer();

    await Future.delayed(const Duration(seconds: 2));

    expect(controller.currentTimeInSeconds, initialTime - 2);
    expect(controller.isActive, true);

    await Future.delayed(const Duration(seconds: initialTime - 2));

    expect(controller.currentTimeInSeconds, 0);
    expect(controller.isActive, false);
  });

  test('Controller with fakeAsync - Test timer running', () async {
    fakeAsync((FakeAsync async) {
      const int initialTime = 12; // needs to be > 2
      final controller = TimerController(initialTimeInSeconds: initialTime);

      expect(controller.currentTimeInSeconds, initialTime);
      expect(controller.isActive, false);

      controller.initTimer();

      async.elapse(const Duration(seconds: 2));

      expect(controller.currentTimeInSeconds, initialTime - 2);
      expect(controller.isActive, true);

      async.elapse(const Duration(seconds: initialTime - 2));

      expect(controller.currentTimeInSeconds, 0);
      expect(controller.isActive, false);

    });
  });

}