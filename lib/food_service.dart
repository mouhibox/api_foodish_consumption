class FoodService {
  // List of food images categorized by the number you provided
  final Map<String, List<String>> images = {
    'burger': List.generate(
        87,
        (index) =>
            'https://foodish-api.com/images/burger/burger${index + 1}.jpg'),
    'biryani': List.generate(
        81,
        (index) =>
            'https://foodish-api.com/images/biryani/biryani${index + 1}.jpg'),
    'butter-chicken': List.generate(
        22,
        (index) =>
            'https://foodish-api.com/images/butter-chicken/butter-chicken${index + 1}.jpg'),
    'dessert': List.generate(
        36,
        (index) =>
            'https://foodish-api.com/images/dessert/dessert${index + 1}.jpg'),
    'dosa': List.generate(83,
        (index) => 'https://foodish-api.com/images/dosa/dosa${index + 1}.jpg'),
    'idly': List.generate(77,
        (index) => 'https://foodish-api.com/images/idly/idly${index + 1}.jpg'),
    'pasta': List.generate(
        34,
        (index) =>
            'https://foodish-api.com/images/pasta/pasta${index + 1}.jpg'),
    'pizza': List.generate(
        95,
        (index) =>
            'https://foodish-api.com/images/pizza/pizza${index + 1}.jpg'),
    'rice': List.generate(35,
        (index) => 'https://foodish-api.com/images/rice/rice${index + 1}.jpg'),
    'samosa': List.generate(
        22,
        (index) =>
            'https://foodish-api.com/images/samosa/samosa${index + 1}.jpg'),
  };

  // Method to fetch food image based on category and random index
  Future<String> fetchFoodImage(String category, int index) async {
    final List<String>? categoryImages = images[category];
    if (categoryImages != null && index < categoryImages.length) {
      return categoryImages[index];
    } else {
      throw Exception('No images found for this category');
    }
  }
}
