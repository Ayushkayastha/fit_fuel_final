import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'food_search_provider.g.dart';

final List<String> foods = [
  "Banana", "Apple", "Orange", "Strawberry", "Blueberry", "Pear", "Avocado", "Pineapple", "Mango", "Grapes",
  "Broccoli", "Carrot", "Spinach", "Tomato", "Potato", "Cucumber", "Sweet potato", "Bell pepper", "Lettuce", "Kale",
  "Whole wheat bread", "White bread", "7-grain bread", "Bagel", "Croissant", "Rice", "Brown rice", "Quinoa", "Pasta", "Oatmeal",
  "Chicken breast", "Ground beef", "Pork chop", "Salmon", "Tuna", "Egg", "Tofu", "Turkey breast", "Shrimp", "Bacon",
  "Milk", "Skim milk", "Yogurt", "Cheddar cheese", "Cottage cheese", "Butter", "Almond milk", "Soy milk", "Cream cheese", "Half-and-half",
  "Oreo cookie", "Chocolate chip cookie", "Donut", "Chocolate bar", "Potato chips", "Popcorn", "Pretzels", "Granola bar", "Ice cream", "Cake",
  "Hamburger", "Cheeseburger", "French fries", "Pizza", "Burrito", "Taco", "Hot dog", "Fried chicken", "Pancakes", "Waffle",
  "Coffee", "Latte", "Tea", "Orange juice", "Cola", "Beer", "Wine", "Fruit smoothie", "Sports drink", "Energy drink",
  "Mashed potatoes", "Macaroni and cheese", "Spaghetti with meat sauce", "Chili", "Lasagna", "Tomato soup", "Beef stew", "Quiche", "Sweetened cereal", "Granola",
  "Sushi", "Burrito bowl", "Falafel", "Hummus", "Margherita pizza", "Chicken curry", "Pad Thai", "Ramen", "Vegetable stir fry", "Guacamole",
];

@riverpod
class FoodSearch extends _$FoodSearch {
  @override
  List<String> build() => foods;

  void search(String query) {
    if (query.isEmpty) {
      state = foods;
    } else {
      final lower = query.toLowerCase();
      final sorted = foods
        ..sort((a, b) {
          final aStarts = a.toLowerCase().startsWith(lower) ? 0 : 1;
          final bStarts = b.toLowerCase().startsWith(lower) ? 0 : 1;
          if (aStarts != bStarts) return aStarts - bStarts;
          return a.toLowerCase().compareTo(b.toLowerCase());
        });
      state = sorted.where((f) => f.toLowerCase().contains(lower)).toList();
    }
  }
}
