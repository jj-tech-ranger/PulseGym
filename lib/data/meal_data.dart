class MealData {
  static const Map<String, List<Map<String, dynamic>>> mealsByCategory = {
    'Breakfast': [
      {
        'title': 'Protein Pancakes',
        'calories': '350 kcal',
        'protein': '25g',
        'carbs': '45g',
        'time': '15 min',
        'difficulty': 'Easy',
        'imageUrl': 'https://images.unsplash.com/photo-1567620905732-2d1ec7ab7445',
        'ingredients': [
          '2 eggs',
          '1 banana',
          '1/2 cup oats',
          '1 scoop protein powder',
          '1/4 cup milk',
          'Berries for topping'
        ],
        'preparation': [
          'Blend eggs, banana, oats, protein powder, and milk until smooth',
          'Heat non-stick pan over medium heat',
          'Pour batter to form pancakes',
          'Cook 2-3 minutes each side until golden',
          'Top with fresh berries and serve'
        ]
      },
      {
        'title': 'Greek Yogurt Bowl',
        'calories': '280 kcal',
        'protein': '20g',
        'carbs': '35g',
        'time': '5 min',
        'difficulty': 'Easy',
        'imageUrl': 'https://images.unsplash.com/photo-1488477181946-6428a0291777',
        'ingredients': [
          '1 cup Greek yogurt',
          '1/4 cup granola',
          '1 tbsp honey',
          'Mixed berries',
          '1 tbsp chia seeds',
          'Sliced banana'
        ],
        'preparation': [
          'Add Greek yogurt to bowl',
          'Top with granola and chia seeds',
          'Add fresh berries and banana slices',
          'Drizzle with honey',
          'Enjoy immediately'
        ]
      },
      {
        'title': 'Veggie Omelette',
        'calories': '320 kcal',
        'protein': '22g',
        'carbs': '12g',
        'time': '10 min',
        'difficulty': 'Easy',
        'imageUrl': 'https://images.unsplash.com/photo-1525351484163-7529414344d8',
        'ingredients': [
          '3 eggs',
          '1/4 cup bell peppers',
          '1/4 cup mushrooms',
          '1/4 cup spinach',
          '2 tbsp cheese',
          'Salt and pepper'
        ],
        'preparation': [
          'Whisk eggs with salt and pepper',
          'Sauté vegetables in pan',
          'Pour eggs over vegetables',
          'Cook until edges set, add cheese',
          'Fold and serve hot'
        ]
      },
    ],
    'Lunch': [
      {
        'title': 'Grilled Chicken Salad',
        'calories': '420 kcal',
        'protein': '35g',
        'carbs': '25g',
        'time': '20 min',
        'difficulty': 'Medium',
        'imageUrl': 'https://images.unsplash.com/photo-1546069901-ba9599a7e63c',
        'ingredients': [
          '150g chicken breast',
          '2 cups mixed greens',
          '1/2 avocado',
          'Cherry tomatoes',
          'Cucumber slices',
          'Olive oil dressing'
        ],
        'preparation': [
          'Season and grill chicken breast',
          'Slice chicken into strips',
          'Arrange greens on plate',
          'Add vegetables and avocado',
          'Top with chicken and dressing'
        ]
      },
      {
        'title': 'Quinoa Buddha Bowl',
        'calories': '480 kcal',
        'protein': '18g',
        'carbs': '55g',
        'time': '25 min',
        'difficulty': 'Medium',
        'imageUrl': 'https://images.unsplash.com/photo-1512621776951-a57141f2eefd',
        'ingredients': [
          '1 cup cooked quinoa',
          'Roasted chickpeas',
          'Sweet potato cubes',
          'Kale or spinach',
          'Tahini dressing',
          'Avocado slices'
        ],
        'preparation': [
          'Cook quinoa according to package',
          'Roast chickpeas and sweet potato',
          'Sauté kale until wilted',
          'Arrange all ingredients in bowl',
          'Drizzle with tahini dressing'
        ]
      },
      {
        'title': 'Turkey Wrap',
        'calories': '380 kcal',
        'protein': '28g',
        'carbs': '35g',
        'time': '10 min',
        'difficulty': 'Easy',
        'imageUrl': 'https://images.unsplash.com/photo-1626700051175-6818013e1d4f',
        'ingredients': [
          'Whole wheat tortilla',
          '100g turkey slices',
          'Lettuce and tomato',
          'Hummus spread',
          'Cucumber strips',
          'Red onion slices'
        ],
        'preparation': [
          'Spread hummus on tortilla',
          'Layer turkey slices',
          'Add vegetables',
          'Roll tightly',
          'Cut in half and serve'
        ]
      },
    ],
    'Dinner': [
      {
        'title': 'Baked Salmon & Veggies',
        'calories': '520 kcal',
        'protein': '40g',
        'carbs': '30g',
        'time': '30 min',
        'difficulty': 'Medium',
        'imageUrl': 'https://images.unsplash.com/photo-1485921325833-c519f76c4927',
        'ingredients': [
          '200g salmon fillet',
          'Broccoli florets',
          'Asparagus spears',
          'Lemon slices',
          'Olive oil',
          'Herbs and spices'
        ],
        'preparation': [
          'Preheat oven to 400°F',
          'Season salmon with herbs',
          'Arrange salmon and vegetables on tray',
          'Drizzle with olive oil',
          'Bake 20-25 minutes until done'
        ]
      },
      {
        'title': 'Lean Beef Stir-Fry',
        'calories': '460 kcal',
        'protein': '35g',
        'carbs': '40g',
        'time': '25 min',
        'difficulty': 'Medium',
        'imageUrl': 'https://images.unsplash.com/photo-1603133872878-684f208fb84b',
        'ingredients': [
          '150g lean beef strips',
          'Mixed vegetables',
          'Brown rice',
          'Soy sauce',
          'Garlic and ginger',
          'Sesame oil'
        ],
        'preparation': [
          'Cook brown rice',
          'Stir-fry beef in hot wok',
          'Add vegetables and cook',
          'Season with soy sauce and spices',
          'Serve over rice'
        ]
      },
      {
        'title': 'Chicken & Sweet Potato',
        'calories': '490 kcal',
        'protein': '38g',
        'carbs': '45g',
        'time': '35 min',
        'difficulty': 'Easy',
        'imageUrl': 'https://images.unsplash.com/photo-1598103442097-8b74394b95c6',
        'ingredients': [
          '180g chicken breast',
          '1 large sweet potato',
          'Green beans',
          'Olive oil',
          'Rosemary',
          'Garlic powder'
        ],
        'preparation': [
          'Cube sweet potato and roast',
          'Season and grill chicken',
          'Steam green beans',
          'Slice chicken',
          'Plate all components together'
        ]
      },
    ],
  };

  static const List<String> dietaryPreferences = [
    'All',
    'Vegetarian',
    'Vegan',
    'Keto',
    'Paleo',
    'High Protein',
  ];
}
