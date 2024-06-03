import 'package:chucknorris_jokes/features/jokes/domain/entities/categories.dart';
import 'package:chucknorris_jokes/features/jokes/domain/entities/joke.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const testCategoriesList = ['Test category'];
  const categories = Categories(names: testCategoriesList);

  test("Should be initialized correctly", () {
    expect(categories.names, testCategoriesList);
  });

  test('should support value equality', () {
    // Keeping the 'final' keyword to ensure the integrity of the test
    // ignore: prefer_const_constructors
    final categories1 = Categories(names: testCategoriesList);
    // ignore: prefer_const_constructors
    final categories2 = Categories(names: testCategoriesList);

    expect(categories1, equals(categories2));
    expect(categories1, categories2);
  });
}
