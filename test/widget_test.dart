import 'package:flutter_test/flutter_test.dart';

import 'package:tarim_asistan/main.dart';

void main() {
  testWidgets('Uygulama başlar', (WidgetTester tester) async {
    await tester.pumpWidget(const TarimAsistanApp());
    expect(find.text('Tarım Asistan'), findsOneWidget);
  });
}
