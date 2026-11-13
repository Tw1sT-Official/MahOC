import 'package:flutter_test/flutter_test.dart';
import 'package:mah_oc/main.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const MahOCApp());
  });
}
